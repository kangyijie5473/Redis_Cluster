#!/bin/bash 

if [ "$2"x == "master"x ]
then
    port1=7000
    port2=7001
    port3=7002
elif [ "$2"x == "slave"x ]
then 
    port1=7003
    port2=7004
    port3=7005
else
    echo "argv error only (master/slave)"
    exit -1
fi



if which apt-get >/dev/null; then
    sudo apt-get install -y ruby rubygems
elif which yum >/dev/null; then
        sudo yum install -y  ruby rubygems
fi

gem install redis

mkdir redis_3.2.8
cd  redis_3.2.8
wget http://download.redis.io/releases/redis-3.2.8.tar.gz
tar zxvf redis-3.2.8.tar.gz
cd redis-3.2.8
sudo make 
sudo make install


cd src
sudo cp redis-trib.rb /usr/local/bin/
sudo cp redis-server /usr/local/bin/
sudo cp redis-benchmark /usr/local/bin/
sudo cp redis-check-aof /usr/local/bin/
sudo cp redis-check-rdb /usr/local/bin/
sudo cp redis-check-cli /usr/local/bin/
sudo cp redis-sentinel /usr/local/bin/

cd ..
mkdir redis_cluster
cd redis_cluster
mkdir $port1 $port2 $port3

cp ../redis.conf $port1
cd $port1 
sed -i "s/# cluster-config-file nodes-6379.conf/cluster-config-file nodes-6379.conf/g" `grep "# cluster-config-file nodes-6379.conf" -rl .`
sed -i "s/6379/$port1/g" `grep 6379 -rl .`
cd ..

cp ../redis.conf $port2
cd $port2 
sed -i "s/# cluster-config-file nodes-6379.conf/cluster-config-file nodes-6379.conf/g" `grep "# cluster-config-file nodes-6379.conf" -rl .`
sed -i "s/6379/$port2/g" `grep 6379 -rl .`
cd ..

cp ../redis.conf $port3
cd $port3 
sed -i "s/# cluster-config-file nodes-6379.conf/cluster-config-file nodes-6379.conf/g" `grep "# cluster-config-file nodes-6379.conf" -rl .`
sed -i "s/6379/$port3/g" `grep 6379 -rl .`
cd ..

sed -i "s/daemonize no/daemonize yes/g" `grep "daemonize no" -rl .`
sed -i "s/appendonly no/appendonly yes/g" `grep "appendonly no" -rl .`
sed -i "s/# cluster-node-timeout 15000/cluster-node-timeout 15000/g" `grep "# cluster-node-timeout 15000" -rl .`
sed -i "s/# cluster-enabled yes/cluster-enabled yes/g" `grep "# cluster-enabled yes" -rl .`
sed -i "s/bind 127.0.0.1/bind $1/g" `grep "bind 127.0.0.1" -rl .`


redis-server $port1/redis.conf
redis-server $port2/redis.conf
redis-server $port3/redis.conf
