#!/bin/bash

source constants.sh

# Argument 1 should be the base filename for the pcaps

# -W flag specifies the maximum number of files before rotation/reusing (helps us avoid cleanup, and set a max number of data being used at a time)

# -C flag specifies the max size of a single file

# -W * -C values multiplied together should be equal to the amount of data we have dedicated to storage for these pcaps on a single server

SRC_FILTER = "(src net 160.39.40.128/25) or (src net 160.39.41.0/25) or (src net 160.39.41.128/25) or (src net 160.39.61.0/25) or (src net 160.39.62.128/26) or (src net 160.39.62.192/26) or (src net 160.39.61.128/25) or (src net 160.39.63.0/26) or (src net 160.39.63.64/26) or (src net 160.39.63.128/26) or (src net 160.39.62.0/25) or (src net 160.39.2.0/24)"

DST_FILTER = ""

# Get the filename to save the capture to
FILENAME=$1

# Start the packet capture
# Starting 2 captures, one for incoming, one for outgoing connections
echo "Starting packet capture to $FILENAME"
tcpdump -i $IFACE -w $FILENAME -W $MAX_FILES -C $MAX_FILESIZE_STR &
tcpdump -i $IFACE -w $FILENAME-outgoing -W $MAX_FILES -C $MAX_FILESIZE_STR $SRC_FILTER &
tcpdump -i $IFACE -w $FILENAME-incoming -W $MAX_FILES -C $MAX_FILESIZE_STR $DST_FILTER &




