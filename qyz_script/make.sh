#!/bin/sh


erlc +debug_info -I ../include -o ../ebin  ../src/user_default.erl

cd ..
mkdir ebin
cp map/mapebin/map_data_*.beam ebin

erl -make


