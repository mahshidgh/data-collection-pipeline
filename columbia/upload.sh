#!/bin/bash

source constants.sh

while true; do
    for f in $1/uploads/*
    do
	FILESIZE=$(stat -c%s "$f")
    
	if [ $FILESIZE -ge $MAX_FILESIZE ]; then

	    # run offline anonymization on this file
	    echo "Attempting to anonymize $f"
	    ./anonymize-offline.sh $f
	
	    # TODO: upload this file [$f-anonymized] to google drive

#	    gupload $f-anonymized -c columbia
	    echo "Attempting to upload $f-anonymized (NOT ACTUALLY!)"	
	
	    rm -f $f
	    rm -f $f-anonymized
	fi
    done
    sleep 10
done
