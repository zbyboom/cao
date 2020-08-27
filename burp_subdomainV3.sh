#!/bin/bash

pid=$$
function _scan(){
    curl -I -s --connect-timeout 3 -m 1 $1 | grep 200 > /dev/null 2>/dev/null
    rst1=$?
    ping -c 1 $1 > /dev/null 2>/dev/null
    rst2=$?

    if [[ $rst1 = 0 || $rst2 = 0 ]]; then
	echo "[+] $1 is exist"
    else
        false
    fi
}

domain=$1
if [ $domain = "-h" ];then
    echo "./burp_subdir.sh url dic.txt"
else
    for l in `cat $2`; do
        _scan $l.$domain &
    done
    wait
fi

kill -9 $$
