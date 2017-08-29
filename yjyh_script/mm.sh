#!/bin/sh

cd ..
mkdir ebin

cp map/lib_map_pos_data.beam ebin 
cp map/lib_map_safe_data.beam ebin
cp temp/temp_bin/*.beam ebin


cd script

erl -eval "case make:files([\"mmake.erl\"]) of error -> halt(1); _ -> ok end" -eval "case mmake:all(4) of up_to_date -> halt(0); error -> halt(1) end."

