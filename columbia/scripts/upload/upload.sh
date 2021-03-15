#!/bin/bash

source constants.sh

while true; do
    for f in $1/uploads/*
    do
        FILESIZE=$(stat -c%s "$f")
	if [ $FILESIZE -ge $MAX_FILESIZE ]; then
	    # run offline anonymization on this file
	    echo "Attempting to anonymize $f"
	    ./scripts/anonymization/anonymize-offline.sh $f

	    # TODO: upload this file [$f-anonymized] to google drive

	    echo "Attempting to upload $f-anonymized"	
	    sudo /root/.google-drive-upload/bin/gupload $f-anonymized -c columbia

	    rm -f $f
	    rm -f $f-anonymized
	fi
    done
    sleep 10
done
