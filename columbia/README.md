# Pending Tasks:
- tcpdump commands need to updated with proper filter for TCP/UDP/DNS/SSL traffic and approriate lengths for truncation
- export.sh needs an scp command that transfers file '$f' to the address of Server 2 which is doing the anonymization
- upload.sh needs a command to upload the anonymized file '$f-anonymized' to the appropriate place using google drive's API
- add any additional anonymization options (check PDF listed below)

# Installation 
Server 1
  - tcpdump
  - scp
  
Server 2
  - pktanon
  - xmlstarlet-dev
  - libxerces-c-dev

# Deplyoment:

On Server 1, run
  - ./capture.sh <base_filename>
  - ./export.sh <base_filename> 

On Server 2, run in the directory where files are exported to in export.sh:
  - ./upload.sh

Can extend anonymization in example .xml files using manual, update from_capture.xml and live_capture.xml:
http://www.tm.uka.de/software/pktanon/documentation/manual/pdf/PktAnon_Manual.pdf

