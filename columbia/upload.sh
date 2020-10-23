#!/bin/bash

source constants.sh

while true; do
    for f in $1/uploads/*
    do
	    # run offline anonymization on this file
	    echo "Attempting to anonymize $f"
	    ./anonymize-offline.sh $f

	    # TODO: upload this file [$f-anonymized] to google drive

	    echo "Attempting to upload $f-anonymized"	
	    gupload $f-anonymized -c columbia

	    rm -f $f
	    rm -f $f-anonymized
    done
    sleep 10
done
