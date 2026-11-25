#!/bin/sh
# ============================================================
# K-03 - SOAL 11: Casper Harus Jadi Hantu (Anti-Ping di Casper)
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 11: Casper Harus Jadi Hantu"
echo " Node : $NODE"
echo "============================================================"

case "$NODE" in
    Magi-Casper)
        iptables -D INPUT -p icmp --icmp-type echo-request -j DROP 2>/dev/null || true
        iptables -I INPUT 1 -p icmp --icmp-type echo-request -j DROP
        iptables -S INPUT
        echo "=== Uji Ping dari Casper ke Balthasar (10.65.4.59) & Lilith (10.65.4.74) ==="
        ping -c 2 -W 2 10.65.4.59
        ping -c 2 -W 2 10.65.4.74
        ;;
    Magi-Balthasar|Lilith)
        echo "=== Uji Ping dari $NODE ke Casper (10.65.4.58) [Harus GAGAL] ==="
        ping -c 2 -W 1 10.65.4.58
        ;;
esac
