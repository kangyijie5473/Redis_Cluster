#!/usr/bin/env python
# coding=utf-8
# Jack Kang
import os
import time

def check(port):
    command = "ps -ef | grep \"" + port + " \[cluster\]\"" 
    if os.system(command):
        print "false" #To do : recovery node




port = sys.argv[1]  
os.chdir("./redis_cluster")
#
#To do : set daemon
#
while True:
    check(port)
    time.sleep(5)
