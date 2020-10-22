# Pending Tasks:
- tcpdump commands need to updated with proper filter for TCP/UDP/DNS/SSL traffic and approriate lengths for truncation
- add any additional anonymization options (check PDF listed below)
- reanonymization between runs

# Installation 
  - tcpdump
  - scp
  - pktanon
  - xmlstarlet-dev
  - libxerces-c-dev

# Deplyoment:

On Capture Server, run
  - ./run-pipeline.sh <experiment_name>
  
After Finished, run cleanup script on last file to upload (in /tmp/pcaps/<experiment_name>\_<experiment_time>)
  - ./cleanup.sh <remaining_pcap>

Can extend anonymization in example .xml files using manual, update from_capture.xml and live_capture.xml:
http://www.tm.uka.de/software/pktanon/documentation/manual/pdf/PktAnon_Manual.pdf

