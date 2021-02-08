#!/bin/bash


xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Input"'] -v $1 pktanon_xml/from_capture.xml > pktanon_xml/temp.xml
xmlstarlet ed -u /triggerconf/module/submodule/configitem[@name='"Output"'] -v $1-anonymized pktanon_xml/temp.xml > pktanon_xml/curr.xml
rm pktanon_xml/temp.xml

pktanon pktanon_xml/curr.xml


