#!/bin/sh

cd ../
mkdir tmp

cd tmp

mkdir include 

erlc -I ../include/ ../src/mysql/mysql/mysql_auth.erl
erlc -I ../include/ ../src/mysql/mysql/mysql_conn.erl
erlc -I ../include/ ../src/mysql/mysql/mysql_recv.erl
erlc -I ../include/ ../src/mysql/mysql/mysql.erl

erlc -I ../include/ ../src/mysql/erlydb/erlsql.erl
erlc -I ../include/ ../src/mysql/erlydb/erlydb.erl
erlc -I ../include/ ../src/mysql/erlydb/erlydb_base.erl
erlc -I ../include/ ../src/mysql/erlydb/erlydb_field.erl
erlc -I ../include/ ../src/mysql/erlydb/erlydb_mysql.erl
erlc -I ../include/ ../src/mysql/erlydb/smerl.erl

erlc -I ../include/ ../src/mysql/sql_util.erl
erlc -I ../include/ ../src/util/tool.erl

erlc -I ../include/ ../src/util/mysql_to_record.erl

erl +P 1024000 -smp disable -name zxsj_tool@127.0.0.1 -s mysql_to_record start

