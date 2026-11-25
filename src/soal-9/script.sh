#!/bin/sh
# ============================================================
# K-03 - SOAL 9: Sabotase & Pemulihan Routing Shigeru
# ============================================================
NODE="$(hostname)"
ACTION="${1:-fix}"
echo "============================================================"
echo " K-03 - SOAL 9: Jalur Belakang Diutak-Atik (Shigeru)"
echo " Node : $NODE | Action : $ACTION"
echo "============================================================"

if [ "$NODE" = "Shigeru" ]; then
    if [ "$ACTION" = "break" ] && [ -f /root/break_routing.sh ]; then
        bash /root/break_routing.sh
    fi
    echo "=== [DIAGNOSA SEBELUM PERBAIKAN] ==="
    sysctl net.ipv4.ip_forward
    ip -br -4 a
    ip route
    iptables -S
    if [ "$ACTION" = "fix" ]; then
        echo "=== [MENJALANKAN PERBAIKAN /root/shigeru.sh] ==="
        bash /root/shigeru.sh
        sysctl net.ipv4.ip_forward
        ip -br -4 a
        ip route
        iptables -S
    fi
elif [ "$NODE" = "Lilith" ]; then
    ping -c 3 -W 2 10.65.4.83
elif [ "$NODE" = "Armisael" ]; then
    ping -c 3 -W 2 10.65.4.81
fi
