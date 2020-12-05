phoenix

---------

### 重构rails

http://littlelines.com/blog/2016/09/27/using-phoenix-with-a-legagy-rails-app/

想法不错,但是让rails使用反向代理,在rails基本已经不能胜任的情况下是不能的

所以比较好的情况还是 想办法把反向代理 放在Phoenix上,反向代理给rails

唯一问题是,怎么做统一的身份谁证

https://github.com/axsuul/rails-reverse-proxy 把这个改成phoenix版本
