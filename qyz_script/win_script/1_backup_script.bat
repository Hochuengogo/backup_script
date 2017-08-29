@echo off

cd ../
set PROJECT_PATH=%cd%

cd ../
set NOW_PATH=%cd%

set BACKUP_FILE_NAME=%ymd%
set BACKUP_PATH=%NOW_PATH%\edition\%BACKUP_FILE_NAME%
set SERVER_PATH=%BACKUP_PATH%\server
set DATA_PATH=%BACKUP_PATH%\data

set EMPTY_TABLE=qyz_empty_table.sql
set UPDATE_TABLE=qyz_update_game.sql
set CM_MESSAGE=青云志简体备份

:step_1
@echo please input backup name(1:today;0:exit;Other:input backup name)
set /p choice1=

if not defined choice1 goto step_1
if %choice1%==1 (set ymd=%date:~0,4%%date:~5,2%%date:~8,2%test) else (if %choice1%==0 (goto SVN_RUN) else set ymd=%choice1%)

mkdir %BACKUP_PATH%
mkdir %SERVER_PATH%
mkdir %DATA_PATH%

echo FILE:Copying all files to server
xcopy %PROJECT_PATH%\*.* %SERVER_PATH% /e

echo FILE:remove not need file
rd %SERVER_PATH%\ebin /s /q
rd %SERVER_PATH%\tmp /s /q
rd %SERVER_PATH%\.idea /s /q
del %SERVER_PATH%\*.iml
del %SERVER_PATH%\*.config


echo SQL:Copying %EMPTY_TABLE% to data
mysqldump -P 3306 -h 192.168.10.216 -u xzsj -pxzsj qyz_game -R --no-data > %EMPTY_TABLE%
move %EMPTY_TABLE% %DATA_PATH%

echo SQL:Copying %UPDATE_TABLE% to data
copy %PROJECT_PATH%\%UPDATE_TABLE% %DATA_PATH%

echo SQL:Copy template
setlocal EnableDelayedExpansion
for /f %%i in ('mysql -h 192.168.10.216 -uxzsj -pxzsj -P3306 qyz_game -Bse "show tables like '%%template'"') do set table=!table! %%i
mysqldump -h 192.168.10.216 -uxzsj -pxzsj  -P3306 qyz_game %table% > qyz_template.sql
move qyz_template.sql %DATA_PATH%

:SVN_RUN
echo SVN:Commit back_up files
set today_date=%date:~0,4%%date:~5,2%%date:~8,2%

:step_2
echo input commit message（1:[版本]青云志简体备份,date;0:exit;Other:input message）:
set /p choice2=
if not defined choice2 (goto step_2)
if %choice2%==0 (pause) else (if %choice2%==1 (set mg=[版本]%CM_MESSAGE%,%today_date%) else set mg=%choice2%))


echo %mg%
svn add "%BACKUP_PATH%"
svn commit -m "%mg%" "%BACKUP_PATH%"

pause

