
1 每个ModelClass 都有一个成员变量叫做 connection_specification_name。
2 Rails有一个 "数据库连接池的哈希列表"，ActiveRecord::Base.connection_handler.owner_to_pool
3 ModelClass在查询数据库的时候，通过connection_specification_name 和 "数据库连接池的哈希列表"，可以获取到对应的数据库连接。

![sharding](/images/ruby_sharding1.png)

