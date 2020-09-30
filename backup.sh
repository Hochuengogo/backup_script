#!/bin/sh

ProjectName=fz
Language1=jt
PJ_DIR=erl-fz
SERVER=fz_server
DBName=fz
DB_BASE=$DBName"_game"
DB_BACKUP=$DBName"_game_bak"

#config

time1=$(date "+%Y%m%d")
FName1=$ProjectName"_"$time1
FName2=$ProjectName"_backups_"$time1
bag=$ProjectName"_bag"
empty_table=$ProjectName"_empty_table.sql"
template=$Language1"_"$ProjectName"_template.sql"
filter_content="t_filter_content.sql"
temp_table_name=$ProjectName"_temp_table"

#backup_template_path
BACKUP_TEMP_PATH=$bag/$FName2

#remove old data
rm -rf ./$BACKUP_TEMP_PATH/$temp_table_name
rm -rf ./$BACKUP_TEMP_PATH/$empty_table
rm -rf ./$BACKUP_TEMP_PATH/$template

mkdir ./$bag
mkdir ./$BACKUP_TEMP_PATH

mysql -usysg -psysg -h192.168.10.8 -P3301 -D$DB_BASE -Bse  "show tables like '%%template%%'">$BACKUP_TEMP_PATH/$temp_table_name 2>/dev/null

# empty_table
mysqldump -usysg -psysg -h192.168.10.8 -P3301 --default-character-set=utf8  $DB_BASE -R --no-data>$BACKUP_TEMP_PATH/$empty_table 2>/dev/null

# template_table
for i in $(cat $BACKUP_TEMP_PATH/$temp_table_name);
do
       	mysqldump  -usysg -psysg -h192.168.10.8 -P3301 --default-character-set=utf8  $DB_BASE $i --skip-lock-tables >>$BACKUP_TEMP_PATH/$template 2>/dev/null;
done

# t_filter_content
mysqldump -usysg -psysg -h192.168.10.8 -P3301 --default-character-set=utf8  $DB_BASE t_filter_content --skip-lock-tables >>$BACKUP_TEMP_PATH/$filter_content 2>/dev/null

mysql -usysg -psysg -h192.168.10.8 -P3301 -D$DB_BACKUP < $BACKUP_TEMP_PATH/$empty_table 2>/dev/null
mysql -usysg -psysg -h192.168.10.8 -P3301 -D$DB_BACKUP < $BACKUP_TEMP_PATH/$template 2>/dev/null
mysql -usysg -psysg -h192.168.10.8 -P3301 -D$DB_BACKUP < $BACKUP_TEMP_PATH/$filter_content 2>/dev/null


   cd $PJ_DIR
   svn up

   cd ../edition

   rm -rf ./$FName1

   #copy files
   mkdir ./$FName1/data
   cp -rf ./$BACKUP_TEMP_PATH/$empty_table $FName1/data/
   cp -rf ./$BACKUP_TEMP_PATH/$template $FName1/data/


   cp -rf ../$PJ_DIR/config $FName1/$SERVER/
   cp -rf ../$PJ_DIR/flash_policy $FName1/$SERVER/
   cp -rf ../$PJ_DIR/html5 $FName1/$SERVER/
   cp -rf ../$PJ_DIR/include $FName1/$SERVER/
   cp -rf ../$PJ_DIR/map $FName1/$SERVER/
   cp -rf ../$PJ_DIR/sh $FName1/$SERVER/
   cp -rf ../$PJ_DIR/src $FName1/$SERVER/
   cp -rf ../$PJ_DIR/script $FName1/$SERVER/
   cp -rf ../$PJ_DIR/hefu $FName1/$SERVER/
   cp -rf ../$PJ_DIR/tools $FName1/$SERVER/
   cp -rf ../$PJ_DIR/Emakefile $FName1/$SERVER/
   cp -rf ../$PJ_DIR/数据修改.txt $FName1/$SERVER/
   cp -rf ../$PJ_DIR/数据库修改.txt $FName1/$SERVER/

   cp -rf ../$PJ_DIR/bzwsfz_clear_data.sql $FName1/$SERVER/
   cp -rf ../$PJ_DIR/jt_bzwsfz_update.sql $FName1/$SERVER/
   cp -rf ../$PJ_DIR/game_clear_user.sql $FName1/$SERVER/
   cp -rf ../$PJ_DIR/game_db_setup.txt $FName1/$SERVER/
   cp -rf ../$PJ_DIR/rebar.config $FName1/$SERVER/
   cp -rf ../$PJ_DIR/yjyh_server.iml $FName1/$SERVER/

   rm -rf $FName1/$SERVER/config/server.app
   cp -rf $FName1/$SERVER/config/server1.app $FName1/$SERVER/config/server.app

   svn cleanup
   svn add $FName1
   svn ci -m "版本自动备份提交"


