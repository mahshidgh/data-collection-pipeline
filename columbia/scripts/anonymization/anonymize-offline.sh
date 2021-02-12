#!/bin/bash


XML_FILE=$2

xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Input"'] -v $1 $XML_FILE > pktanon_xml/temp.xml
xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Output"'] -v $1-anonymized pktanon_xml/temp.xml > pktanon_xml/curr.xml
rm pktanon_xml/temp.xml

pktanon pktanon_xml/curr.xml


