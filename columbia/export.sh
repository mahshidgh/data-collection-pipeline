#!/bin/bash

source constants.sh

eval `ssh-agent`
ssh-add /home/sanjay/.ssh/sanjay_rsa

while true; do
    for f in $1*
    do
	FILESIZE=$(stat -c%s "$f")
	echo "Looking at file $f"
	if [ $FILESIZE -ge $MAX_FILESIZE ]
	then
	    if [[ "$(lsof "$f") > /dev/null" ]]
	    then
	       current_time=$(date "+%Y-%m-%d-%H%M")
	       filename=$(basename "$f" | sed 's/\(.*\)\..*/\1/')
	       echo "Got a basename of $filename"
	       directoryname=$(dirname $f)
	       mkdir -p $directoryname/uploads
	       nf="$directoryname/uploads/"$filename"_"$current_time".pcapng"
	       echo "Set $f as ready for upload as: $nf"
#  SCP   CMD  ## scp $nf sanjay@128.59.65.80:/home/sanjay/test/$uploadname # if using 2 servers #
	       mv $f $nf
	    else
		echo "file '$f' has not been closed yet"
	    fi
	else
	    echo "file '$f' still being written to"
	fi
    done
    sleep 10
done
