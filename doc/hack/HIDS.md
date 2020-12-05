# 入侵检测 HIDS

## OSSEC

http://www.ossec.net/downloads.html

OSSEC HIDS是一种基于主机的入侵检测系统（HIDS），用于安全检测，可见性和合规性监控。
它基于多平台代理，将系统数据（例如，日志消息，文件哈希值和检测到的异常）转发给中央管理器，
在中央管理器中进行进一步分析和处理，从而产生安全警报。
代理通过安全且经过身份验证的渠道将事件数据传送到中央管理器进行分析。
此外，OSSEC HIDS还提供集中式系统日志服务器和无代理配置监控系统，
可提供对无代理设备（如防火墙，交换机，路由器，接入点，网络设备等）上的事件和更改的安全洞察。

### 安装

[HIDS之wazuh部署入门](https://paper.tuisec.win/detail/5accd9bac828078)

### 使用

企业安全建设之 HIDS （二）：入侵检测 & 应急响应
https://www.chainnews.com/articles/651668758165.htm

[HIDS-Wazuh 功能分析](https://hellohxk.com/blog/hids-wazuh/)

[如何用ELK和Wazuh搭建 PCI-DSS（支付卡行业安全标准）](http://www.liuhaihua.cn/archives/349258.html)

云享家 | 基于AWS云平台的IDS联合监控分析
https://www.bespinglobal.cn/wp-content/uploads/2018/11/%E4%BA%91%E4%BA%AB%E5%AE%B6-%E5%9F%BA%E4%BA%8EAWS%E4%BA%91%E5%B9%B3%E5%8F%B0%E7%9A%84IDS%E8%81%94%E5%90%88%E7%9B%91%E6%8E%A7%E5%88%86%E6%9E%90-.pdf

### 主机重要日志分析

wazhu之agent功能详解

https://www.cnblogs.com/backlion/p/10329601.html

#### 主机登录日志(ssh)
### 重要系统文件完整性检查
### root-kit检测等功能

汉化: kibana界面汉化
https://blog.csdn.net/qq_28449663/article/details/79868334

## OpenSCAP

OpenSCAP是一种OVAL（开放漏洞评估语言）和XCCDF（可扩展配置清单描述格式）解释器，用于检查系统配置和检测易受攻击的应用程序。

## 漏洞

### [心脏出血](doc/hack/heartbleeder.md)

## 参考

<<互联网企业安全高级指南>>.赵彦

驭龙HIDS的简介，它开源了
https://blog.csdn.net/lengye7/article/details/79789121

威胁猎杀实战（三）：基于Wazuh, Snort/Suricata和Elastic Stack的SOC
https://www.secpulse.com/archives/81629.html

如何通过Kibana、Wazuh和Bro IDS提高中小企业的威胁检测能力？
https://www.doc11.com/p/9456.html

人生苦短，我用Wazuh！  ---- 这个不错
https://paper.tuisec.win/detail/b744646101b7e4c

