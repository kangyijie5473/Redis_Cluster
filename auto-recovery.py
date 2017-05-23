#!/usr/bin/env python
# coding=utf-8
# Jack Kang
import os
import time
import sys

# 检测是否存活
def check(port):
    isAlive = "ps -ef | grep \"" + port + " \[cluster\]\"" 
    recovery = "redis-server ./" + port + "/redis.conf"  
    if os.system(isAlive): #判断
        os.system(recovery) #重启节点



#设置为守护进程
stdin = '/dev/null'
stdout = '/dev/null'
stderr = '/dev/null'

try:
    pid = os.fork()
    if pid > 0 :
        sys.exit(0)
except OSError, e:
    #sys.stderr.write("Fork #1 failed: (%d) %s\n" % (e.errno, e.strerror))
    print "error #1"
    sys.exit(1)

os.chdir("./redis_cluster")
os.umask(0)
os.setsid()

try:
    pid = os.fork()
    if pid > 0:
        sys.exit(0)
except OSError:
    #sys.stderr.write("Fork #2 failed:(%d) %s\n" % (e.errno, e.strerror))
    print "error #2"
    sys.exit(1)

#for f in sys.stdout, sys.stderr: f.flush() 这句话没弄明白
si = open(stdin, 'r')
so = open(stdout, 'a+')
se = open(stderr, 'a+', 0)
os.dup2(si.fileno(), sys.stdin.fileno())
os.dup2(so.fileno(), sys.stdout.fileno())
os.dup2(se.fileno(), sys.stderr.fileno())

#循环 每5s检测是存活
port = sys.argv[1]  
while True:
    check(port)
    time.sleep(5)
