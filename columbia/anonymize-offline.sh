#!/bin/bash


xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Input"'] -v $1 from_capture.xml > temp.xml
xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Output"'] -v $1-anonymized temp.xml > curr.xml
rm temp.xml

pktanon curr.xml


