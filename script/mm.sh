#!/bin/sh


erlc +debug_info -I ../include -o ../ebin  ../src/user_default.erl

cd ..
mkdir ebin
cp map/mapebin/map_data_*.beam ebin
cd script

erl -eval "case make:files([\"mmake.erl\"]) of error -> halt(1); _ -> ok end" -eval "case mmake:all(4) of up_to_date -> halt(0); error -> halt(1) end."

