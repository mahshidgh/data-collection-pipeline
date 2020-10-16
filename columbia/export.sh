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
	       echo "SCPing file '$f' to Anonymization Server"
	       # TODO: scp file to other server
	       current_time=$(date "+%Y.%m.%d-%H.%M.%S")

	       filename=$(basename $f)
	       scp $f sanjay@128.59.65.80:/home/sanjay/test/$filename.$current_time.pcapng
	
	       rm -f $f
	    else
		echo "file '$f' still being written to"
	    fi
	       
		   
	fi
    done
    sleep 10
done
