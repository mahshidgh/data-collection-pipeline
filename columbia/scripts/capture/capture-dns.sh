#!/bin/bash

source constants.sh

# Argument 1 should be the base filename for the pcaps

# -W flag specifies the maximum number of files before rotation/reusing (helps us avoid cleanup, and set a max number of data being used at a time)

# -C flag specifies the max size of a single file

# -W * -C values multiplied together should be equal to the amount of data we have dedicated to storage for these pcaps on a single server

# Get the filename
DNS_FILENAME=$1

# Start the packet capture with a DNS filter
# capture udp traffic on port 53
echo "Starting packet capture to $DNS_FILENAME"
tcpdump -i $IFACE -s 1500 'udp port 53' -w $DNS_FILENAME -W $MAX_DNS_FILES -C $MAX_DNS_FILESIZE_STR



