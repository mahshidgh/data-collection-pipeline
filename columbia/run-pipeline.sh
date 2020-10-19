#!/bin/bash

source constants.sh

trap "kill 0" EXIT

# TODO: find out why, need to prefix capture in /tmp directory
#       - have to use chmod 1777 on directory for it to work

if [ -z $1 ]
then
    mkdir -p /tmp/test
    chmod 1777 /tmp/test
    mkdir -p testlogs
    rm -rf /tmp/test/*
    rm -rf testlogs/*
    FILENAME="/tmp/test/test.pcapng"
    ./capture.sh $FILENAME &> testlogs/capturelog.txt &
    ./export.sh $FILENAME &> testlogs/exportlog.txt &
    ./upload.sh /tmp/test &> testlogs/uploadlog.txt &
else
    BASENAME=$1

    current_time=$(date "+%Y-%m-%d-%H%M")
    DIRNAME=$BASENAME-$current_time

    # TODO: create a random prefix every X hours and restart the scripts for new anonymization
    #       keep the same time started for the script, even though the script is changing
    PREFIX=""
    
    mkdir -p /tmp/pcaps/$DIRNAME
    chmod 1777 /tmp/pcaps/$DIRNAME
    mkdir -p logs
    ./capture.sh /tmp/pcaps/$DIRNAME/$DIRNAME.pcapng &> logs/$DIRNAME-capturelog.txt &
    ./export.sh /tmp/pcaps/$DIRNAME/$DIRNAME.pcapng &> logs/$DIRNAME-exportlog.txt &
    ./upload.sh /tmp/pcaps/$DIRNAME &> logs/$DIRNAME-uploadlog.txt &
fi

wait
