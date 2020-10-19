#!/bin/bash

source constants.sh

if [ -z $1 ]
then
    mkdir -p test
    mkdir -p testlogs
    rm -rf test/*
    rm -rf testlogs/*
    FILENAME="test/test.pcapng"
    ./capture.sh $FILENAME &> testlogs/capturelog.txt
    ./export.sh $FILENAME &> testlogs/exportlog.txt
    ./upload.sh test &> testlogs/uploadlog.txt
else
    BASENAME=$1

    current_time=$(date "+%Y-%m-%d-%H%M")
    DIRNAME=$BASENAME-$current_time
    
    mkdir -p pcaps/$DIRNAME
    ./capture.sh pcaps/$DIRNAME/$DIRNAME.pcapng &> logs/$current_time-capturelog.txt
    ./export.sh pcaps/$DIRNAME/$DIRNAME.pcapng &> logs/$current_time-exportlog.txt
    ./upload.sh pcaps/$DIRNAME &> logs/$current_time-uploadlog.txt
fi

