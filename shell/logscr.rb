#!/usr/bin/env ruby

# 分析慢请求 比如以下内容

time = ARGV.first || '1000'
time = time.to_f

# [2016-05-10 10:48:03] [INFO] [User#19637] [huogou.udesk.cn] [218.203.63.249] [f450a882-4c5d-46] [api] Requested: {"method":"GET","path":"/api/v2/im/agent.json","query":"user_id=4144220&sign=d6b568b81c8aadd3967aee1fb1908e17","data":null,"params":null}

while line = STDIN.gets
  result = /user_id=([\d.]+)/.match(line)
  if result
    duration = $1
    if duration.to_f > time
      puts line
    end
  end
end
