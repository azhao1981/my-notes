# Sentry

## 安装 docker 和 docker-compose

```bash
sudo su -
curl -sSL https://git.io/vyg91 | bash
curl -L http://mirrors.aliyun.com/docker-toolbox/linux/compose/1.15.0/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose
```

## 安装 sentry

```shell
git clone https://github.com/getsentry/onpremise
git clone git@github.com:azhao1981/onpremise.git

cd onpremise

# https://docs.sentry.io/server/installation/docker/
# 上面有使用docker安装的过程，不过docker-compose的教程目前还没merge到master，暂时看不到，不过用
# docker-compose 非常方便

sudo make build
mkdir -p data/{sentry,postgres}    # Make our local database and sentry config directories.`
sudo docker-compose run --rm web config generate-secret-key    # Generate a secret key.
# Add it to `docker-compose.yml` in `base` as `SENTRY_SECRET_KEY`.（把上一步key写到docker-compose.yml里）
#  建创数据库.  这步需要创建管理员账号
sudo docker-compose run --rm web upgrade
# 启动服务
sudo docker-compose up -d

# 修改邮件,下面有一个生效
vim sentry.conf.py
SENTRY_SERVER_EMAIL="sentry@support.udesk.cn"
vim docker-compose.yml
SENTRY_SERVER_EMAIL: sentry@support.udesk.cn
# 都不生效就使用
vim config.yml
mail.host: 'support.udesk.cn'
mail.from: 'sentry@support.udesk.cn'

```

<https://github.com/boot2docker/boot2docker/issues/581>

现在访问你的 <http://localhost:9000>

## 参考

[使用docker-compose运行错误收集工具Sentry](http://ningning.today/2016/10/18/python/docker-sentry/)

[整合Sentry和NodeJS实现分布式日志收集](http://vernonzheng.com/2014/12/26/%E6%95%B4%E5%90%88Sentry%E5%92%8CNodejs%E5%AE%9E%E7%8E%B0%E5%88%86%E5%B8%83%E5%BC%8F%E6%97%A5%E5%BF%97%E6%94%B6%E9%9B%86/)
