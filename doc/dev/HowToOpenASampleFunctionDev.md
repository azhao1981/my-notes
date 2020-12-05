一个简单功能的正确开发方式
-----

从一个简单的满意度调查说起

这是一个简单的功能:

在一个web即时会话里,客服可以让客户进行满意度评价,一个会话不能重复发起满意度评价

为了避免重复发起: (功能1)
```ruby
# 入参: customer_id agent_id
{
  has_survey: last_session.try(:im_session).try(:im_survey_vote).present?
}
```

提交的时候也确认了一下,如果有了就不会再评价 (功能2)
```ruby
# 入参: customer_id agent_id
self.im_survey_vote.blank?
  ImSurveyVote.new({company_id: company_id, customer_id: customer_id, im_session_id: id, agent_id: agent_id || im_sub_sessions.last.agent_id})
  vote.survey_option_id = survey_option_id
  vote.save!
end
```
看起来已经满足需求了

### 功能1真的能档住 重复发起吗?

不能,因为我们可以开启多个 tap ,在不评价前我们可以无限弹起

### 功能2 真的能阻止重复评价吗?
不能,多个请求并发时,im_survey_vote还没有写入库中,self.im_survey_vote.blank? 一直为真
而产生并发十分的廉价,只需要在页面消失前使劲点击提交就可以了

### 解决
我们在功能2加了把锁,在3秒内,一个客户对一个客服的评价只处理一次
```
if unlocked?(customer_id,agent_id,3.seconds)
  功能2
end
```
前端也阻止了多次点击的可能

### 又出现飞来横"评"
