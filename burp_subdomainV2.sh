#!/bin/bash

function _scan(){
    rst=`curl -I -s $1 | grep 200`
    if [[ -z $rst ]]; then
	    false
    else
	echo "[+] $1 is exist"
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
