#!/bin/sh

rebar -j 3 compile

F_APP_SRC="./src/server.app.src"
F_APP="./ebin/server.app"

rm -rf $F_APP_SRC
rm -rf $F_APP


map()
{
	echo map_to_record
	cd ebin
	erl +P 1024000 -smp disable -name kyfg_tool@127.0.0.1 -s map_to_data start
	cd ..
}

if [ "$1" = "" ];then
    echo "exit\n";
else
    map
fi





