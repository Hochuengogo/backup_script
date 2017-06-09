#!/bin/sh

cd ../tmp

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

PATH = 
for f in ../src/static_data/*.erl
  do
	echo $f
	echo ""
	erlc -I ../include/ $f
  done

erl +P 1024000 -smp disable -name xzsj_tool@127.0.0.1 -s static_data_all start


