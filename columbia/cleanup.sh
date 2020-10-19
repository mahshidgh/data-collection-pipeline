#!/bin/bash

source constants.sh

if [ -z $1 ]
then
    FILENAME="/tmp/test/test.pcapng"
else
    FILENAME=$1
fi


current_time="final"
filename=$(basename "$1" | sed 's/\(.*\)\..*/\1/')
echo "Got a basename of $filename"
directoryname=$(dirname $1)
mkdir -p $directoryname/uploads
nf="$directoryname/uploads/"$filename"_"$current_time".pcapng"
echo "Set $f as ready for upload as: $nf"
#  SCP   CMD  ## scp $nf sanjay@128.59.65.80:/home/sanjay/test/$uploadname # if using 2 servers #
mv $f $nf
echo "Attempting to anonymize $f"
./anonymize-offline.sh $nf
echo "Attempting to upload $f-anonymized"
gupload $nf-anonymized -c columbia
rm -f $nf
rm -f $nf-anonymized
