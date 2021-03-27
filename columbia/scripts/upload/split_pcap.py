import pyshark
import os
import sys
from scapy.all import *

def save_to_pcap(cap, filename):
    new_cap = PcapWriter(filename, append=True)

    for packet in cap:
        new_cap.write(packet.get_raw_packet())

def load_pcap(filter_str, path):
    cap = pyshark.FileCapture(path, display_filter=filter_str)
    return cap

def main():
    filename = sys.argv[1]
    out_filename = sys.argv[1] + '-outgoing'
    in_filename = sys.argv[1] + '-incoming'

    subnets = [('160.39.40.128','160.39.40.255'),
               ('160.39.41.0','160.39.41.127'),
               ('160.39.41.128','160.39.41.255'),
               ('160.39.61.0','160.39.61.127'),
               ('160.39.62.128','160.39.62.191'),
               ('160.39.62.192','160.39.62.255'),
               ('160.39.61.128','160.39.61.255'),
               ('160.39.63.0','160.39.63.63'),
               ('160.39.63.64','160.39.63.127'),
               ('160.39.63.128','160.39.63.191'),
               ('160.39.62.0','160.39.62.127'),
               ('160.39.2.0','160.39.2.255')]

    subnets = [('160.39.40.128','160.39.40.255')]

    
    cap_filter = ''
    for (a,b) in subnets:
        cap_filter += '(ip.src >= {} and ip.src <= {})'.format(a,b)
        cap_filter += ' or '
    cap_filter = cap_filter[:-4]

    print "Outgoing Cap Filter: {}".format(cap_filter)
    
    cap = pyshark.FileCapture(filename, display_filter=cap_filter, output_file=out_filename)
    cap.load_packets()
    
    cap_filter = ''
    for (a,b) in subnets:
        cap_filter += '(ip.dst >= {} and ip.dst <= {})'.format(a,b)
        cap_filter += ' or '
    cap_filter = cap_filter[:-4]

    print "Incoming Cap Filter: {}".format(cap_filter)

    cap = pyshark.FileCapture(filename, display_filter=cap_filter, output_file=in_filename)
    cap.load_packets()

main()
