#!/bin/bash

source constants.sh

ANON_KEY=$2

while true; do
    for f in $1/uploads/*
    do
        FILESIZE=$(stat -c%s "$f")
	if [ $FILESIZE -ge $MAX_FILESIZE ]; then

	    # TODO: split the file into incoming / outgoing
	    ./scripts/anonymization/split_columbia.py $f

	    # run offline anonymization on this file
	    echo "Attempting to anonymize $f-incoming"
	    ./scripts/anonymization/anonymize-offline.sh $f-incoming ./pktanon_xml/from_capture_dst_anon.xml $ANON_KEY
	    echo "Attempting to anonymize $f-outgoing"
	    ./scripts/anonymization/anonymize-offline.sh $f-outgoing ./pktanon_xml/from_capture_src_anon.xml $ANON_KEY

	    # Merge the incoming / outgoing pcaps together based on timestamp
	    mergecap -w $f-anonymized $f-incoming $f-outgoing $f
	    
	    # upload the file to google drive
	    echo "Attempting to upload $f-anonymized"	
	    sudo /root/.google-drive-upload/bin/gupload $f-anonymized-$ANON_KEY -c columbia

	    rm -f $f
	    rm -f $f-incoming
	    rm -f $f-outgoing
	    rm -f $f-anonymized
	    rm -f $f-incoming-anonymized
	    rm -f $f-outgoing-anonymized
	fi
    done
    sleep 10
done
