#!/bin/bash

file="/etc/group"
if [ "$1" == "-f" ]; then
    file=$2
    gid=$3
else
    gid=$1
fi

if [ -z "$gid" ]; then
    echo "Usage: userlist [-f file] gid"
    exit 2
fi

result=$(grep -E "^[^:]+:[^:]+:${gid}:" $file)
if [ $? -eq 0 ]; then
    users=$(echo $result | cut -d: -f4 | tr ',' '\n')
    echo "$users"
    exit 0
else
    echo "No group found with the specified gid" >&2
    exit 1
fi
