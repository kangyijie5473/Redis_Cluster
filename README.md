#This is my tools and demo in Redis

##First tool --> redis_cluster_without_mind.sh
A simple shell script about start redis-cluster quickly.
第一个小工具，无脑一键配置redis-cluster 
### How to use

default master ports are 7000 7001 7002
```
 $ chmod u+x redis_cluster_without_mind.sh
 $./redis_cluster_without_mind.sh 192.168.30.109 master
```
default slave ports are 7003 7004 7005
```
 $ chmod u+x redis_cluster_without_mind.sh
 $./redis_cluster_without_mind.sh 192.168.30.109 slave
```


