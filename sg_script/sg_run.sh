#!/bin/sh
NODE=101
IP=192.168.10.52
TMP=$NODE/100
CONFIG_NODE=$NODE-$TMP*100
COOKIE=kyfg
NODE_NAME=kyfg_game$NODE@$IP
CONFIG_FILE=game

SMP=able
ERL_MAX_ATOM=10485760

ERL_MAX_PORTS=32000

ERL_PROCESSES=500000

ERL_MAX_ETS_TABLES=1400

cd config


erl +P $ERL_PROCESSES +t $ERL_MAX_ATOM -smp $SMP -pa ../ebin -name $NODE_NAME -setcookie $COOKIE -boot start_sasl -config $CONFIG_FILE -kernel inet_dist_listen_min 20000 inet_dist_listen_max 30000 -s server_ctrl start_server

