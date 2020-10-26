#!/bin/bash

source constants.sh

if [ -z $1 ]
then
    DIRECTORY="/tmp/test"
else
    DIRECTORY=$1
fi

curi=1
for f in $1/*
do
    current_time="final$curi"
    ((curi = curi + 1))
    filename=$(basename "$f" | sed 's/\(.*\)\..*/\1/')
    echo "Got a basename of $filename"
    directoryname=$(dirname $f)
    mkdir -p $directoryname/uploads
    nf="$directoryname/uploads/"$filename"_"$current_time".pcapng"
    mv $f $nf
done


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



