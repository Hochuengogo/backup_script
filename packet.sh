#!/bin/sh

#config
PJ_DIR=erl-fz
TARGET_DIR=fz_bag
ProjectName=fz
TARGET_PJ_NAME=jt_bzwsfz
empty_table=bzwsfz_empty_table.sql
template=jt_bzwsfz_template.sql
SQL_UPDATE=jt_bzwsfz_update.sql
DB_BASE=fz_game
#config

time1=$(date "+%Y%m%d")
FName1=$ProjectName"_"$time1
FName2=$TARGET_PJ_NAME"_"$time1
TAGET_PATH=$TARGET_DIR/$FName1/$FName2
temp_table_name=$ProjectName"_temp_table"
CP_TARGET_PATH=$TAGET_PATH/server/

mkdir -p $TARGET_DIR
rm -rf $TARGET_DIR/$FName1
mkdir -p $TAGET_PATH/server
mkdir -p $TAGET_PATH/server/include
mkdir -p $TAGET_PATH/server/ebin

mysql -usysg -psysg -h192.168.10.8 -P3301 -D$DB_BASE -Bse  "show tables like '%%template%%'" > $TAGET_PATH/$temp_table_name 2>/dev/null

# template_table
for i in $(cat $TAGET_PATH/$temp_table_name);
do
   mysqldump  -usysg -psysg -h192.168.10.8 -P3301 --default-character-set=utf8  $DB_BASE $i --skip-lock-tables >> $TAGET_PATH/$template 2>/dev/null;
done

cp -rf $PJ_DIR/include $CP_TARGET_PATH
cp -rf $PJ_DIR/ebin $CP_TARGET_PATH
cp -rf $PJ_DIR/$SQL_UPDATE $TAGET_PATH

rm -rf $TAGET_PATH/server/include/*.hrl_*
rm $TAGET_PATH/$temp_table_name

tar -cf $TARGET_DIR/$FName1/$FName2".zip" $TARGET_DIR/$FName1/*
tar -cf $TAGET_PATH/server.zip $TAGET_PATH/*

# 999
mkdir $TAGET_PATH/server999
mv $TAGET_PATH/server.zip $TAGET_PATH/server999/
cp -rf $TAGET_PATH/$template $TAGET_PATH/server999/

# empty_table
mysqldump -usysg -psysg -h192.168.10.8 -P3301 --default-character-set=utf8  $DB_BASE -R --no-data > $TAGET_PATH/server999/$empty_table 2>/dev/null

cd $TAGET_PATH/server999
tar -cf server999.zip *
tar -cf bzws.zip $empty_table
mv server999.zip ..



