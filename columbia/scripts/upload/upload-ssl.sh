#!/bin/bash

source constants.sh

while true; do
    for f in $1/uploads/*
    do
        FILESIZE=$(stat -c%s "$f")
	if [ $FILESIZE -ge $MAX_SSL_FILESIZE ]; then

	    # TODO: split the file into incoming / outgoing
	    # TODO: anonymize based on the right xml file	    

	    # run offline anonymization on this file
	    echo "Attempting to anonymize $f"
	    ./scripts/anonymization/anonymize-offline.sh $f

	    # upload the file to google drive
	    echo "Attempting to upload $f-anonymized"	
	    gupload $f-anonymized -c columbia

	    rm -f $f
	    rm -f $f-anonymized
	fi
    done
    sleep 10
done
