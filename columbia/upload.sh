#!/bin/bash

source constants.sh

while true; do
    for f in *
    do
	FILESIZE=$(stat -c%s "$f")
    
	if [ $FILESIZE -ge $MAX_FILESIZE ]; then

	    # run offline anonymization on this file
	    ./anonymize-offline.sh $f
	
	    # TODO: upload this file [$f-anonymized] to google drive

	
	
	    rm -f $f
	    rm -f $f-anonymized
	fi
    done
    sleep 10
done
