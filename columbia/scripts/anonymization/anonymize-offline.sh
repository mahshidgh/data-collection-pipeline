#!/bin/bash


XML_FILE=$2
ANON_KEY=$3

if [ -z "$3" ]
then
    echo "Need to supply anonymization key"
    exit
fi

xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Input"'] -v $1 $XML_FILE > pktanon_xml/temp.xml
xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Output"'] -v $1-anonymized pktanon_xml/temp.xml > pktanon_xml/curr.xml

sed 's/TEMPLATEKEY/$ANON_KEY/g' curr.xml > final.xml

rm pktanon_xml/temp.xml
rm pktanon_xml/curr.xml

pktanon pktanon_xml/final.xml


