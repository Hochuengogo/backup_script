@echo off

set SCRIPT_PATH=%cd%
svn update ../

cd ../
set PROJECT_PATH=%cd%

::make_record
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

echo removing files

rd ebin /s /q

::make_new
cd %SCRIPT_PATH%
erlc +debug_info -I ..\include -o ..\ebin  ..\src\user_default.erl

cd ..
mkdir ebin
copy map\mapebin\map_data_*.beam ebin

erl -make

set USERDESTOP=%USERPROFILE%\Desktop

set ymd=%date:~0,4%%date:~5,2%%date:~8,2%
set UPDATE_FILE_NAME=%ymd%
set UPDATE_PATH=%USERDESTOP%\%UPDATE_FILE_NAME%
set SERVER_PATH=%UPDATE_PATH%\server
set DATA_PATH=%UPDATE_PATH%\data
set EBIN_PATH=%SERVER_PATH%\ebin
set INCLUDE_PATH=%SERVER_PATH%\include

set UPDATE_TABLE=qyz_update_game.sql

mkdir %UPDATE_PATH%
mkdir %SERVER_PATH%
mkdir %DATA_PATH%
mkdir %EBIN_PATH%
mkdir %INCLUDE_PATH%


del %PROJECT_PATH%\include\table_to_record*_*

xcopy %PROJECT_PATH%\ebin %EBIN_PATH% /e
xcopy %PROJECT_PATH%\include %INCLUDE_PATH% /e
copy %PROJECT_PATH%\%UPDATE_TABLE% %DATA_PATH%


echo SQL:Copy template
setlocal EnableDelayedExpansion
for /f %%i in ('mysql -h 192.168.10.216 -uxzsj -pxzsj -P3306 qyz_game -Bse "show tables like '%%template'"') do set table=!table! %%i
mysqldump -h 192.168.10.216 -uxzsj -pxzsj  -P3306 qyz_game %table% > qyz_template.sql
move qyz_template.sql %DATA_PATH%

pause

