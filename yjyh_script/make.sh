#!/bin/sh

cd ..
mkdir ebin

cp map\lib_map_pos_data.beam ebin 
cp map\lib_map_safe_data.beam ebin
cp temp\temp_bin\*.beam ebin

erl -make


