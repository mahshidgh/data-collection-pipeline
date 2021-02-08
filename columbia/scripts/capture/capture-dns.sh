#!/bin/bash

source constants.sh

# Argument 1 should be the base filename for the pcaps

# -W flag specifies the maximum number of files before rotation/reusing (helps us avoid cleanup, and set a max number of data being used at a time)

# -C flag specifies the max size of a single file

# -W * -C values multiplied together should be equal to the amount of data we have dedicated to storage for these pcaps on a single server


if [ -z $1 ]
then
    mkdir -p /tmp/test/dns
    DNS_FILENAME="/tmp/test/dns/dns-test.pcapng"
else
    DNS_FILENAME=$1
fi

# where 0x16 = Handshake (22) at the first byte field of the data

# and 0x01 = Client Hello (1) at the 6th byte field of the data

echo "Starting packet capture to $DNS_FILENAME"
tcpdump -i $IFACE -s 1500 '(tcp[((tcp[12:1] & 0xf0) >> 2)+5:1] = 0x01) and (tcp[((tcp[12:1] & 0xf0) >> 2):1] = 0x16)' -w $DNS_FILENAME -W $MAX_DNS_FILES -C $MAX_DNS_FILESIZE_STR



