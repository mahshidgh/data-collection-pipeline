#!/bin/bash

source constants.sh

while true; do
    for f in $1/uploads/*
    do
        FILESIZE=$(stat -c%s "$f")
	if [ $FILESIZE -ge $MAX_DNS_FILESIZE ]; then

	    # TODO: split the file into incoming / outgoing
	    ./scripts/anonymization/split_columbia.py $f

	    # run offline anonymization on this file
	    echo "Attempting to anonymize $f-incoming"
	    ./scripts/anonymization/anonymize-offline.sh $f-incoming ./pktanon_xml/from_capture_dst_anon_include_payload.xml
	    echo "Attempting to anonymize $f-outgoing"
	    ./scripts/anonymization/anonymize-offline.sh $f-outgoing ./pktanon_xml/from_capture_src_anon_include_payload.xml

	    # Merge the incoming / outgoing pcaps together based on timestamp
	    mergecap -w $f-anonymized $f-incoming $f-outgoing $f
	    
	    # upload the file to google drive
	    echo "Attempting to upload $f-anonymized"	
	    gupload $f-anonymized -c columbia

	    rm -f $f
	    rm -f $f-anonymized
	fi
    done
    sleep 10
done
