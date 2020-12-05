
# 面向对象服务

## 引用

[Building a Service-oriented Architecture with Rails and Kafka](https://blog.heroku.com/service-oriented-architecture-rails-kafka)


## 使用Docker快速建立一个Kafka实例
https://segmentfault.com/a/1190000015627478

https://hub.docker.com/r/wurstmeister/kafka/
https://github.com/zendesk/ruby-kafka

https://hub.docker.com/r/bitnami/kafka/

Suppose you want to know more information about how your users are engaged on your platform: the pages they visit, the buttons they click, and so on.
A sufficiently(充分地) popular app could produce billions of events, and sending such a high volume of data to an analytics service could be challenging, to say the least.

Enter Kafka, an integral(完整的) piece for web applications that require real-time data flow. Kafka provides fault-tolerant communication between producers, which generate events, and consumers, which read those events. There can be multiple producers and consumers in any single app.
In Kafka, every event is persisted(持续) for a configured length of time, so multiple consumers can read the same event over and over.
A Kafka cluster is comprised(包含) of several brokers(经纪人), which is just a fancy(想象力) name for any instance running Kafka.

One of the key performance characteristics of Kafka is that it can process an extremely(非常) high throughput of events. Traditional enterprise queuing systems, like AMQP, have the event infrastructure itself keep track of the events that each consumer has processed.
As your number of consumers scales up, that infrastructure(基础设施) will suffer under a greater load, as it needs to keep track of more and more states.
And even establishing an agreement with a consumer is not trivial(琐碎的).
Should a broker mark a message as "done" once it's sent over the network? What happens if a consumer goes down and needs a broker to re-send an event?

Kafka brokers, on the other hand, do not track any of its consumers.
The consumer service itself is in charge of telling Kafka where it is in the event processing stream, and what it wants from Kafka.
A consumer can start in the middle, having provided Kafka an offset of a specific event to read, or it can start at the very beginning or even very end. A consumer's ability to read event data is constant(恒定的) time of O(1); as more events arrive, the amount of time to look up information from the stream doesn't change.

Kafka also has a scalable and fault-tolerant profile. It runs as a cluster on one or more servers that can be scaled out horizontally by adding more machines. The data itself is written to disk and then replicated across multiple brokers. For a concrete number around what scalable looks like, companies such as Netflix, LinkedIn, and Microsoft all send over a trillion messages per day through their Kafka clusters!


We'll talk more about Kafka's serialization formats below, but in this scenario, we're using good old JSON.

The topic keyword argument refers to the log where Kafka is going to write the event.
Topics themselves are divided into partitions(分开), which allow you to "split" the data in a particular topic across multiple brokers for scalability and reliability.
It's a good idea to have two or more partitions per topic so if one partition fails, your events can still be written and consumed.
Kafka guarantees that events are delivered in order inside a partition, but not inside a whole topic.
If the order of the events is important, passing in a partition_key will ensure that all events of a specific type go to the same partition.

One challenge with this setup is that the upstream service is responsible for monitoring the downstream availability. If the email system is having a really bad day, the upstream service is responsible for knowing whether that email service is available. And if it isn't available, it also needs to be in charge of retrying any failing requests. How might Kafka's event stream help in this situation? Let's take a look:

In this event-oriented world, the upstream service can write an event to Kafka indicating that an order was created. Because Kafka has an "at least once" guarantee(保证), the event is going to be written to Kafka at least once, and will be available for a downstream consumer to read. If the email service is down, the event is still persisted for it to consume. When the downstream email service comes back online, it can continue to process the events it missed in sequence.

Another challenge with an RPC-oriented architecture is that, in increasingly complex systems, integrating a new downstream service means also changing an upstream service. Suppose you'd like to integrate a new service that kicks off a fulfillment process when an order is created. In an RPC world, the upstream service would need to add a new API call out to your new fulfillment service. But in an event-oriented world, you would add a new consumer inside the fulfillment service that consumes the order once the event is created inside of Kafka.

Incorporating events in a service-oriented architecture

In a blog post titled "What do you mean by “Event-Driven”," Martin Fowler discusses the confusion surrounding "event-driven applications." When developers discuss these systems, they can actually be talking about incredibly(难以置信地) different kinds of applications. In an effort to bring a shared understanding to what an event-driven system is, he's started defining a few architectural patterns.

Let's take a quick look at what these patterns are! If you'd like to learn more about them, check out his keynote at GOTO Chicago 2017 that covers these in-depth.

Event Notification
The first pattern Fowler talks about is called Event Notification. In this scenario, one service simply notifies the downstream services that an event happened with the bare minimum of information:


A third designation from Fowler is an Event-Sourced architecture.
This implementation suggests that not only is each piece of communication between your services kicked off(开始) by an event, but that by storing a representation(陈述) of an event, you could drop all your databases and still completely rebuild the state of your application by replaying that event stream.
In other words, each payload encapsulates(压缩) the exact state of your system at any moment.

An enormous(庞大的) challenge to this approach is that, over time, code changes. A future API call to a downstream service might return a different set of data that previously available, which makes it difficult to recalculate(重新计算) the state at that moment.

Command Query Responsibility(责任) Segregation(分享)

The final pattern mentioned is Command Query Responsibility Segregation, or CQRS.
The idea here is that actions you might need to perform on a record--creating, reading, updating--are split out into separate domains.
That means that one service is responsible for writing and another is responsible for reading.
In event-oriented architectures, you'll often see event systems nestled in the diagrams at the place where commands are actually written.


















