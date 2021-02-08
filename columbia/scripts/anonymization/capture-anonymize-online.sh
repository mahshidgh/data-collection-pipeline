#!/bin/bash

source constants.sh

xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Output"'] -v $1 pktanon_xml/temp.xml > pktanon_xml/curr.xml
rm pktanon_xml/temp.xml

# -W flag specifies the maximum number of files before rotation/reusing (helps us avoid cleanup, and set a max number of data being used at a time)

# -C flag specifies the max size of a single file

# -W * -C values multiplied together should be equal to the amount of data we have dedicated to storage for these pcaps on a single server

tcpdump -i enp0s25 -W $MAX_FILES -C $MAX_FILESIZE_STR -w - | pktanon pktanon_xml/curr.xml

