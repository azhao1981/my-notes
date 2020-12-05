# serverless

## awesome

https://github.com/anaibol/awesome-serverless

## [《微服务：从设计到部署》中文版](https://github.com/oopsguy/microservices-from-design-to-deployment-chinese)

https://github.com/babylikebird/Micro-Service-Skeleton

[Kubernetes中文指南/云原生应用架构实践手册](https://github.com/rootsongjc/kubernetes-handbook)

### ruby serverless

https://github.com/tongueroo/jets
https://blog.boltops.com/2019/01/13/build-an-api-service-with-jets-ruby-serverless-framework
https://medium.freecodecamp.org/the-best-ways-to-test-your-serverless-applications-40b88d6ee31e
https://medium.com/square-corner-blog/serverless-instant-checkout-links-with-square-6fa331d51928
https://hackernoon.com/serverless-websockets-with-aws-lambda-fanout-15384bd30354


https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
https://blog.codeship.com/running-rails-development-environment-docker/
https://blog.codeship.com/architecting-rails-apps-as-microservices/

https://auth0.com/blog/ruby-on-rails-killer-workflow-with-docker-part-1/

### spring cloud

### 微服务管理框架service mesh——Istio简介


### API网关

[netflix-api]

- <https://medium.com/netflix-techblog/reactive-programming-in-the-netflix-api-with-rxjava-7811c3a1496a>
- <https://medium.com/netflix-techblog/optimizing-the-netflix-api-5c9ac715cf19>

使用传统的异步回调方式来编写 API 组合代码会很快使您陷入回调地狱。代码将会变 得杂乱、难以理解并且容易出错。

一个更好的方式是使用**响应式方法**以声明式编写 API 网关代码。

响应式抽象的例子包括
    Scala 的 Future
    Java 8 中的 CompletableFuture
    JavaScript 中的 [Promise](https://developers.google.com/web/fundamentals/primers/promises?hl=zh-cn)

Netflix 为 JVM 创 建了RxJava，专门应用于其 API 网关
JavaScript 的 RxJS

有两种进程间通信方案
一是使用基于消息的异步机制。某些实现采用了消息代理，如 JMS 和 AMQP。其他采用无代理的方式直接与服务通信，如 Zeromq。
另一种类型的进程间通信采用了同步机制，如 HTTP 和 Thrift。

[Netflix Hystrix 是一个非常有用的库，用于编写调用远程服务代码](https://github.com/Netflix/Hystrix)

nginx plus API网关,我只能说贵的一逼...2500刀/年或5000刀/年

[api设计](https://www.programmableweb.com/news/how-to-design-great-apis-api-first-design-and-raml/how-to/2015/07/10)

处理 API 变更的方式取决于变更的程度。某些更改是次要或需要向后兼容以前的版本。 例如，您可能会向请求或响应添加属性。此时设计客户端与服务遵守**鲁棒性原则**就显 得很有意义了

https://en.wikipedia.org/wiki/Robustness_principle

[Netflix处理局部故障的策略 ](https://medium.com/netflix-techblog/fault-tolerance-in-a-high-volume-distributed-system-91ab4faae74a)

始终使用超时方案。
    使用超时方案确保资源 不被无限地消耗。

限制未完成的请求数量
    对客户端拥有特定服务的未完成请求的数量设置上限。如果达到了上限，发出的 额外请求可能是毫无意义的，
    因此这些尝试需要立即失败。

[断路器模式](https://martinfowler.com/bliki/CircuitBreaker.html)
    追踪成功和失败请求的数量。如果错误率超过配置阈值，则断开断路器，以便后 续的尝试能立即失败

提供回退
    请求失败时执行回退逻辑。例如，返回缓存数据或者默认值，如一组空白的推荐 数据

Netflix Hystrix 是一个实现上述和其他模式的开源库

 同步的请求/响应 IPC
 Apache Thrift  RPC
    RabbitMQ、Apache Kafka、Apache ActiveMQ 和 NSQ。

 开源的 Registrator 项目是一个很好的服务注册器示例
     https://github.com/gliderlabs/registrator
     https://github.com/Netflix/Prana
Aminator
    Netflix 使用 Aminator 将每个服务打 包为 EC2 AMI。每个运行的服务实例都是一个 EC2 实例
     您可以配置您的持续集成(CI)服务器 (比如 Jenkins)来调用 Aminator 将服务打包为一个 EC2 AMI
     Packer 是自动化虚 拟机镜像创建的另一个选择。与 Aminator 不同，它支持各种虚拟化技术，包括 EC2、 DigitalOcean、VirtualBox 和 VMware

 Boxfuse 公司有一种非常棒的方式用来构建虚拟机镜像，其克服了我将在下面描述的 虚拟机的缺点。Boxfuse 将您的 Java 应用程序打包成一个最小化的 VM 镜像。这些 镜像可被快速构建、快速启动且更加安全，因为它们暴露了一个有限的攻击面。

CloudNative 公司拥有 Bakery，这是一种用于创建 EC2 AMI 的 SaaS 产品。您可以 配置您的 CI 服务器，以在微服务通过测试后调用 Bakery。之后 Bakery 将您的服务 打包成一个 AMI。使用一个如 Bakery 的 SaaS 产品意味着您不必浪费宝贵的时间来设 置 AMI 创建基础架构

## host server

https://github.com/alexellis/faas

https://github.com/metrue/fx

## 微服务框架对比

https://colobu.com/2016/09/05/benchmarks-of-popular-rpc-frameworks/

## rpc

[RPC框架实践之：Google gRPC](https://my.oschina.net/hansonwang99/blog/1815743)

## simple

https://github.com/0x4D31/honeyLambda

https://github.com/zeit/now

https://github.com/nuclio/nuclio

[Chrome automation made simple. Runs locally or headless on AWS Lambda](https://github.com/graphcool/chromeless)

## 介绍

Serverless 领域 AWS Lambda是先行者，随后其他厂商相继推出了自己的函数服务，包括 Azure Function，Google Cloud Functions。阿里云的Serverless产品函数服务（Function Compute）现在正在紧张的研发阶段，预计2016年底之前会正式对外发布。
6.阿里云的Serverless规划
阿里云未来会围绕Serverless概念构建完整的生态体系，产品层面将全力打造API Gateway，Docker，Function Compute等为主的Serverless基础产品序列，同时围绕基础框架提升大数据服务能力，推动API经济发展，使阿里云成为中国Serverless的领导者。

7.技术文章推荐
http://martinfowler.com/articles/serverless.html
http://martinfowler.com/bliki/Serverless.html

高频访问类应用，例如开发网站/移动应用后端系统。阿里云函数计算高可用，实时弹性伸缩，按需收费，成本低廉。用户能快速的实现系统原型，并且同样的架构能够平滑扩展，支持用户业务规模的快速扩张。
低频访问类应用，例如各种数据导入导出任务，或者系统中的cron job。阿里云函数计算不但保证任务可靠执行，减小运维负担；而且按照实际使用情况收费，降低用户成本。

https://github.com/elgris/microservice-app-example