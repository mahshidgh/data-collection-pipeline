#!/bin/bash

source constants.sh

# Argument 1 should be the base filename for the pcaps

# -W flag specifies the maximum number of files before rotation/reusing (helps us avoid cleanup, and set a max number of data being used at a time)

# -C flag specifies the max size of a single file

# -W * -C values multiplied together should be equal to the amount of data we have dedicated to storage for these pcaps on a single server

tcpdump -i enp0s25 -w $1 -W $MAX_FILES -C $MAX_FILESIZE_STR



