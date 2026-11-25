#!/bin/sh
# ============================================================
# K-03 - SOAL 12: Perbaikan Hardening Firewall Magi-Casper
# ============================================================
NODE="$(hostname)"
ACTION="${1:-fix}"
echo "============================================================"
echo " K-03 - SOAL 12: Teknisi yang Kelewat Semangat (Magi-Casper)"
echo " Node : $NODE | Action : $ACTION"
echo "============================================================"

if [ "$NODE" = "Magi-Casper" ]; then
    if [ "$ACTION" = "break" ] && [ -f /root/break_fw.sh ]; then
        bash /root/break_fw.sh
    fi
    echo "=== [DIAGNOSA SEBELUM PERBAIKAN] ==="
    iptables -S
    if [ "$ACTION" = "fix" ]; then
        echo "=== [MENJALANKAN PERBAIKAN HARDENING /root/magi-casper.sh] ==="
        bash /root/magi-casper.sh
        iptables -S
        echo "=== Uji ping 8.8.8.8 dan apt-get update pada Magi-Casper ==="
        ping -c 2 -W 2 8.8.8.8
        apt-get update
    fi
elif [ "$NODE" = "Unit-00" ]; then
    echo "=== Uji Koneksi TCP 5000 dari Unit-00 ke Magi-Casper ==="
    echo "Halo Casper dari Unit-00 (Soal 12)" | nc -w 2 10.65.4.58 5000; echo "exit=$?"
fi
