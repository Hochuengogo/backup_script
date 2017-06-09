#!bin/sh

if [ ! -d "temp" ]; then
   mkdir "temp"
fi


cd "temp"

for f in `ls ../src/mysql/emysql/*.erl`
do
  echo $f
  erlc -I "../include/" $f
done

for f in `ls ../src/mysql/mysql/*.erl`
do
  echo $f
  erlc -I "../include/" $f
done

for f in `ls ../src/mysql/*.erl`
do
  echo $f
  erlc -I "../include/" $f
done

for f in `ls ../src/util/*.erl`
do
  echo $f
  erlc -I "../include/" $f
done

erlc -I ../include/ ../src/tool/mysql_to_record.erl
erlc -I ../include/ ../src/tool/admin_to_record.erl

echo admin_to_record
erl +P 1024000 -smp disable -name kyfg_tool@127.0.0.1 -s admin_to_record start

echo mysql_to_record
erl +P 1024000 -smp disable -name kyfg_tool@127.0.0.1 -s mysql_to_record start

