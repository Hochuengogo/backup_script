#!/bin/sh

NODE=101
COOKIE=keysszj1
NODE_NAME=qyz$NODE@192.168.11.50
CONFIG_FILE=run

SMP=auto
ERL_PROCESSES=102400

cd ../config
erl +P $ERL_PROCESSES -smp $SMP -pa ../ebin -name $NODE_NAME -setcookie $COOKIE -boot start_sasl -config $CONFIG_FILE -s main start_server
