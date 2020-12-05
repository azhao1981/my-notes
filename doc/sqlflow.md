# sqlflow

## ref

https://github.com/sql-machine-learning/sqlflow

https://sql-machine-learning.github.io/

docker run --rm -it -p 8888:8888 sqlflow/sqlflow:latest \
bash -c "sqlflowserver --datasource='mysql://root:root@tcp(host.docker.internal:3306)/?maxAllowedPacket=0' &
SQLFLOW_SERVER=localhost:50051 jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root"


会 SQL 就能搞定 AI！蚂蚁金服重磅开源机器学习工具 SQLFlow
https://www.infoq.cn/article/vlVqC68h2MT-028lh68C

