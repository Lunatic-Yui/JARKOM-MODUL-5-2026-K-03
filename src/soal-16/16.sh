#!/bin/bash
DP=10.65.4.51

iptables -N SCAN 2>/dev/null || true
iptables -F SCAN
iptables -A SCAN -p tcp -m multiport --dports 22,23,3306 \
  -j LOG --log-prefix "SCAN-NERV: " --log-level 4
iptables -A SCAN -p tcp -m multiport --dports 22,23,3306 \
  -j REJECT --reject-with tcp-reset

iptables -C INPUT -s $DP -p tcp -j SCAN 2>/dev/null || \
  iptables -I INPUT 1 -s $DP -p tcp -j SCAN