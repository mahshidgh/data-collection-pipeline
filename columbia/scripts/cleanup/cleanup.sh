#!/bin/bash

source constants.sh

if [ -z $1 ]
then
    DIRECTORY="/tmp/test/"
else
    if [[ "$1" == */ ]]
    then
	DIRECTORY=$1
	SSL_DIRECTORY=$1ssl/
	DNS_DIRECTORY=$1dns/
    else
	DIRECTORY=$1/
	SSL_DIRECTORY=$1/ssl/
	DNS_DIRECTORY=$1/dns/
    fi
    echo "Directory is: $DIRECTORY"
fi

curi=1
for f in $DIRECTORY*
do
    if [ -f "$f" ]; then
	echo "File: $f"
	current_time="final$curi"
	((curi = curi + 1))
	filename=$(basename "$f" | sed 's/\(.*\)\..*/\1/')
	echo "Got a basename of $filename"
	directoryname=$(dirname $f)
	mkdir -p $directoryname/uploads
	nf="$directoryname/uploads/"$filename"_"$current_time".pcapng"
	mv $f $nf
	echo "Renamed to: $nf"
    fi
done


for f in "$DIRECTORY"uploads/*
do
    if [ -f "$f" ]; then
	# run offline anonymization on this file
	echo "Attempting to anonymize $f"
	../anonymization/anonymize-offline.sh $f
	
	# TODO: upload this file [$f-anonymized] to google drive
	
	echo "Attempting to upload $f-anonymized"	
	gupload $f-anonymized -c columbia
	
	rm -f $f
	rm -f $f-anonymized
    fi
done

curi=1
for f in $SSL_DIRECTORY*
do
    if [ -f "$f" ]; then
	echo "File: $f"
	current_time="final$curi"
	((curi = curi + 1))
	filename=$(basename "$f" | sed 's/\(.*\)\..*/\1/')
	echo "Got a basename of $filename"
	directoryname=$(dirname $f)
	mkdir -p $directoryname/uploads
	nf="$directoryname/uploads/"$filename"_"$current_time".pcapng"
	mv $f $nf
	echo "Renamed to: $nf"
    fi
done


for f in "$SSL_DIRECTORY"uploads/*
do
    if [ -f "$f" ]; then
	# run offline anonymization on this file
	echo "Attempting to anonymize $f"
	./anonymize-offline.sh $f
	
	# TODO: upload this file [$f-anonymized] to google drive
	
	echo "Attempting to upload $f-anonymized"	
	gupload $f-anonymized -c columbia
	
	rm -f $f
	rm -f $f-anonymized
    fi
done

curi=1
for f in $DNS_DIRECTORY*
do
    if [ -f "$f" ]; then
	echo "File: $f"
	current_time="final$curi"
	((curi = curi + 1))
	filename=$(basename "$f" | sed 's/\(.*\)\..*/\1/')
	echo "Got a basename of $filename"
	directoryname=$(dirname $f)
	mkdir -p $directoryname/uploads
	nf="$directoryname/uploads/"$filename"_"$current_time".pcapng"
	mv $f $nf
	echo "Renamed to: $nf"
    fi
done


for f in "$DNS_DIRECTORY"uploads/*
do
    if [ -f "$f" ]; then
	# run offline anonymization on this file
	echo "Attempting to anonymize $f"
	./anonymize-offline.sh $f
	
	# TODO: upload this file [$f-anonymized] to google drive
	
	echo "Attempting to upload $f-anonymized"	
	gupload $f-anonymized -c columbia
	
	rm -f $f
	rm -f $f-anonymized
    fi
done



