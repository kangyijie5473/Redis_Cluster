#!/usr/bin/env python
# coding=utf-8
# Jack Kang
from rediscluster import StrictRedisCluster
import sys

def redis_cluster():
    redis_nodes = [{'host':'192.168.30.132','port':7009},
                   {'host':'192.168.30.132','port':7010},
                   {'host':'192.168.30.132','port':7011},
                   {'host':'192.168.30.120','port':7000},
                   {'host':'192.168.30.120','port':7001},
                   {'host':'192.168.30.120','port':7002}
                  ]
    try:
        redisconn = StrictRedisCluster(startup_nodes = redis_nodes)
    except Exception,e:
        print "connect error"
        sys.exit(1)
    
    redisconn.set('name','kk')
    print "name is", redisconn.get('name')
    
redis_cluster()
