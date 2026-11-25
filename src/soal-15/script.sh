#!/bin/sh
# ============================================================
# K-03 - SOAL 15: Banjir Ping di Pusat Komando (Tokyo3-Core Rate Limit)
# ============================================================
NODE="$(hostname)"
MODE="${1:-rapid}"
echo "============================================================"
echo " K-03 - SOAL 15: Pembatasan Ping Tokyo3-Core (5 ping/detik)"
echo " Node : $NODE"
echo "============================================================"

if [ "$NODE" = "Tokyo3-Core" ]; then
    bash /root/tokyo3-core.sh
    iptables -S INPUT
    iptables -L INPUT -n -v --line-numbers
elif [ "$NODE" = "Lilith" ]; then
    if [ "$MODE" = "normal" ]; then
        echo "=== Uji Ping Biasa dengan Jeda 3 Detik (Semuanya Berhasil) ==="
        ping -i 3 -c 4 10.65.4.106
    else
        echo "=== Uji Ping Rapat (ping -i 0.1 -c 50) [Sebagian Hilang/Terbuang] ==="
        ping -i 0.1 -c 50 10.65.4.106
    fi
fi
