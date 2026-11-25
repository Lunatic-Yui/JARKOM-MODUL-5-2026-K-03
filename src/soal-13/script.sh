#!/bin/sh
# ============================================================
# K-03 - SOAL 13: Brankas Balthasar (TCP 5000 & 5001 Whitelist + REJECT)
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 13: Brankas Balthasar (Casper & Pilot Only)"
echo " Node : $NODE"
echo "============================================================"

case "$NODE" in
    Magi-Balthasar)
        bash /root/magi-balthasar.sh
        iptables -S
        ping -c 2 -W 2 8.8.8.8
        ;;
    Unit-01)
        echo "=== Uji nc dari Unit-01 (Pilot) ke Balthasar 5000 & 5001 [BERHASIL] ==="
        echo "Unit-01 -> Balthasar 5000" | nc -w 2 10.65.4.59 5000; echo "exit_5000=$?"
        echo "Unit-01 -> Balthasar 5001" | nc -w 2 10.65.4.59 5001; echo "exit_5001=$?"
        ;;
    Lilith|Magi-Melchior)
        echo "=== Uji nc dari $NODE ke Balthasar 5000 & 5001 [DITOLAK SEKETIKA] ==="
        time nc -w 3 10.65.4.59 5000 </dev/null; echo "exit_5000=$?"
        time nc -w 3 10.65.4.59 5001 </dev/null; echo "exit_5001=$?"
        ;;
esac
