#!/bin/bash
R="-s 10.65.4.58 -d 10.65.4.82 -p tcp -j DNAT --to-destination 10.65.3.194"
iptables -t nat -C PREROUTING $R 2>/dev/null || iptables -t nat -A PREROUTING $R