#!/bin/bash

mkdir -p /tmp/sample_captures/

echo "Starting packet captures!"

IFACE="enp3s0f0"
FILENAME="/tmp/sample_captures/sample_default_cap_3_5_0800.pcapng"
SSL_FILENAME="/tmp/sample_captures/sample_ssl_cap_3_5_0800.pcapng"
DNS_FILENAME="/tmp/sample_captures/sample_dns_cap_3_5_0800.pcapng"

tcpdump -i $IFACE -w $FILENAME &
tcpdump -i $IFACE -s 1500 '(tcp[((tcp[12:1] & 0xf0) >> 2)+5:1] = 0x01) and (tcp[((tcp[12:1] & 0xf0) >> 2):1] = 0x16)' -w $SSL_FILENAME &
tcpdump -i $IFACE -s 1500 'port 53' -w $DNS_FILENAME &



