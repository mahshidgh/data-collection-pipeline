#!/bin/bash

source constants.sh

while true; do
    for f in $1*
    do
	FILESIZE=$(stat -c%s "$f")
	
	if [ $FILESIZE -ge $MAX_FILESIZE ]
	then
	    if [[ "$(lsof "$f") > /dev/null" ]]
	    then
	       echo "SCPing file '$f' to Anonymization Server"
	       # TODO: scp file to other server
	       
	       
	
	       rm -f $f
	    else
		echo "file '$f' still being written to"
	    fi
	       
		   
	fi
    done
    sleep 10
done
