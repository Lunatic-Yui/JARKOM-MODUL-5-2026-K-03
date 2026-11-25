#!/bin/sh
# ============================================================
# K-03 - SOAL 5: Default Deny & Stateful Firewall di Gendo (/root/gendo.sh)
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 5: Pintu Depan Dikunci Rapat (Firewall Gendo)"
echo " Node : $NODE"
echo "============================================================"

if [ "$NODE" = "Gendo" ]; then
    bash /root/gendo.sh
    echo "=== Output iptables -S pada Gendo ==="
    iptables -S
    echo "=== Output iptables -t nat -S pada Gendo ==="
    iptables -t nat -S
elif [ "$NODE" = "Armisael" ]; then
    echo "=== Uji Ping 8.8.8.8 dari Armisael ==="
    ping -c 3 -W 2 8.8.8.8
else
    echo "[INFO] Jalankan script ini di Gendo atau Armisael."
fi
