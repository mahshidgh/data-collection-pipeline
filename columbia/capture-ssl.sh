#!/bin/bash

source constants.sh

# Argument 1 should be the base filename for the pcaps

# -W flag specifies the maximum number of files before rotation/reusing (helps us avoid cleanup, and set a max number of data being used at a time)

# -C flag specifies the max size of a single file

# -W * -C values multiplied together should be equal to the amount of data we have dedicated to storage for these pcaps on a single server


IFACE="eno2"

if [ -z $1 ]
then
    mkdir -p /tmp/test/ssl
    SSL_FILENAME="/tmp/test/test.pcapng"
else
    SSL_FILENAME=$1
fi

echo "Starting packet capture to $SSL_FILENAME"
tcpdump -i $IFACE -w $SSL_FILENAME -W $MAX_SSL_FILES -C $MAX_SSL_FILESIZE_STR



