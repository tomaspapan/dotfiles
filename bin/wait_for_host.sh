#!/bin/bash

HOST=$1
TRIES=$2
RETURN=1

while [ $RETURN != 0 ]
do
    ping -c 3 -i 0.2 -t 1 $HOST > /dev/null 2>&1
    RETURN=$?
    TRIES=$(($TRIES - 1))
    if [ $TRIES == 0 ]; then RETURN=0; echo 'timed out.'; exit -1; fi
    sleep 1
done
