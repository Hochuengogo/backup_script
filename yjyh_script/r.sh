#!/bin/sh

cd ../
mkdir temp

cd temp

mkdir include 

erlc -I ../include/ ../src/db/mysql/mysql_auth.erl
erlc -I ../include/ ../src/db/mysql/mysql_conn.erl
erlc -I ../include/ ../src/db/mysql/mysql_recv.erl
erlc -I ../include/ ../src/db/mysql/mysql.erl
erlc -I ../include/ ../src/db/poolboy_server.erl
erlc -I ../include/ ../src/db/db_init.erl
erlc -I ../include/ ../src/db/poolboy/poolboy_sup.erl
erlc -I ../include/ ../src/db/poolboy/poolboy_worker.erl
erlc -I ../include/ ../src/db/poolboy/poolboy.erl


erlc -I ../include/ ../src/db/erlydb/erlsql.erl
erlc -I ../include/ ../src/db/erlydb/erlydb.erl
erlc -I ../include/ ../src/db/erlydb/erlydb_base.erl
erlc -I ../include/ ../src/db/erlydb/erlydb_field.erl
erlc -I ../include/ ../src/db/erlydb/erlydb_mysql.erl
erlc -I ../include/ ../src/db/erlydb/smerl.erl

erlc -I ../include/ ../src/db/sql_util_pool.erl
erlc -I ../include/ ../src/misc/tool.erl

erlc -I ../include/ ../tools/mysql_to_record.erl

erl +P 1024000 -smp disable -name kysy_tool@127.0.0.1 -s mysql_to_record start

cd ../include
rm *.hrl_*
