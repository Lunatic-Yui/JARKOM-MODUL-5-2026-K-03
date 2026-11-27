#!/bin/bash
UP=eth0
TERMINAL=10.65.4.56/29

iptables -N ZONA 2>/dev/null || true
iptables -F ZONA
iptables -A ZONA -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A ZONA -s $TERMINAL -p icmp --icmp-type echo-request -j ACCEPT
iptables -A ZONA -j DROP

iptables -C FORWARD -i $UP -j ZONA 2>/dev/null || iptables -I FORWARD 1 -i $UP -j ZONA