minitest.md
----

### 集成测试

[文档](http://doc.bccnsoft.com/docs/rails-guides-4.1-cn/testing.html#%E9%9B%86%E6%88%90%E6%B5%8B%E8%AF%95)

rails generate integration_test im_pre_form

#### tip

```ruby

# Runs all tests before Ruby exits, using `Kernel#at_exit`.
require 'minitest/autorun'

# Enables rainbow-coloured test output.
require 'minitest/pride'

# Enables parallel (multithreaded) execution for all tests.
require 'minitest/hell'


require 'minitest/autorun'

# Classes act as groups of tests.
class RandomTests < Minitest::Test

  # The `setup` method is run before every test.
  def setup
    @random = File.open('/dev/random')
  end

  # The `teardown` method is run after every test.
  def teardown
    @random.close
  end

  # Tests are methods that begin with "test_".
  def test_reading
    content = @random.read(5)
    assert_equal 5, content.length
  end

  # The `skip` method prevents a test from running.
  # Skipped tests do not count as failures.
  def test_skipping
    skip 'Fix this test later'
  end


  def test_assertions
    # The subjects (values being tested)
    singer = 'Michael Buble'
    calculation = 0.3 - 0.2 # = 0.09999999999999998

    # The most basic assertion
    assert singer.end_with?('e')

    # Equality/matching
    assert_equal 'Michael', singer.split.first # expected == actual
    assert_same singer, singer # expected.equal?(actual)
    assert_nil nil
    assert_match /Michael (Buble|Jackson)/, singer # regex =~ singer

    # Containers
    assert_empty "" # obj.empty?
    assert_includes singer, 'Bub' # singer.include?('Bub')

    # Numeric
    assert_in_delta 0.1, calculation    # float comparison (absolute error method)
    assert_in_epsilon 0.1, calculation  # float comparison (relative error method)
    assert_operator calculation, :<, 5  # calculation < 5

    # Types/messages
    assert_instance_of Float, calculation  # calculation.instance_of?(Float)
    assert_kind_of Numeric, calculation    # calculation.kind_of?(Numeric)
    assert_respond_to singer, :downcase    # singer.respond_to?(:downcase)

    # Generic
    assert_predicate calculation, :positive?   # calculation.positive?
    assert_send [singer, :start_with?, 'Mic']  # singer.start_with?('Mic')

    # Exceptions
    error = assert_raises(ZeroDivisionError) { 5 / 0 }
    assert_equal error.message, 'divided by 0'

    # Output
    assert_output("0.09999999999999998\n") { puts calculation }
    assert_silent { "nothing output to $stdout or $stderr" }

    # Refute (opposite of assert)
    refute singer.end_with?('Jackson')
    refute_empty singer
    refute_equal singer, 'Lady Gaga'
    refute_in_delta calculation, 3.14
    refute_in_epsilon calculation, 3.14
    refute_includes singer, 'z'
    refute_instance_of Numeric, calculation
    refute_kind_of Integer, calculation
    refute_match /Gaga/, singer
    refute_nil singer
    refute_operator calculation, :>, 3.14
    refute_predicate singer, :empty?
    refute_respond_to singer, :sing
    refute_same singer, 'Michael Buble'
  end

  # Runs tests in alphabetical order, instead of random order.
  i_suck_and_my_tests_are_order_dependent!

  # Runs tests in parallel (multithreaded).
  parallelize_me!

  # Generates nicer diffs for complicated, nested values.
  make_my_diffs_pretty!

  def assert_uppercase(str, msg = nil)
    msg = message(msg) { "Expected #{mu_pp(str)} to be uppercase" }
    assert(str == str.upcase, msg)
  end

  def test_custom_assertion
    assert_uppercase 'HAHAHA'
  end

end

```
