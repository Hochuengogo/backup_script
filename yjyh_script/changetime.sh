#!/bin/sh

read a
if [ $a = 1 ];then
  date -s "2017-7-1 16:30"
else
  date -s "2017-8-28 14:51"
fi
