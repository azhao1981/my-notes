### jira 开发

```ruby
http://jira.flyudesk.com:8099
rest/api/2/filter/#{filter_id}

http://jira.flyudesk.com:8099/rest/api/2/filter/12603

return response["jql"]

uri = URI.parse("#{LION_CONFIG.fetch('jira_host')}/rest/api/2/search")

req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
req.basic_auth "liuyunfeng", "lyf22351"
req.body = jql

filter_content = nil
    Net::HTTP.start(uri.hostname, uri.port) do |http|
    filter_content = http.request(req).body
end

return JSON.parse(filter_content)["issues"]
```

curl --basic -u user:pass

http://myhost.com:8080/rest/api/2.0.alpha1/project/JRA
http://myhost.com:8080/rest/api/2/issue/JFL-89/editmeta

REST结果的访问格式为：

http://host:port/rest/api-name/api-version/resource-name     如果正常的jira首页地址为http://host:port

http://host:port/context/rest/api-name/api-version/resource-name   如果正常的jira首页地址为http://host:port/context

其中：

apiname只有 'api' and 'auth' 2个值可用，api主要查询issue相关的信息，而auth主要查看权限相关的信息

api-version自然是你要用哪个版本的api了，其实就是当前rest插件的版本，一般不同的jira版本中api版本也不一样，如jira4.4的api版本为：2.0.alpha1

resource-name就是具体要请求那个资源了。如：user，issue，project等，后面还可以跟具体的参数，如：?user=myname

请求样式： http://myhost.com:8080/rest/api/2.0.alpha1/project/JRA

http://www.cnblogs.com/wade-xu/p/6096902.html
http://www.cnblogs.com/starcrm/p/4837971.html
https://www.jianshu.com/p/279aa98c3cfa