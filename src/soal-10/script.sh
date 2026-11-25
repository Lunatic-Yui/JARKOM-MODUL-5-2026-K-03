#!/bin/sh
# ============================================================
# K-03 - SOAL 10: Sabotase & Pemulihan NAT (Misato & Gendo)
# ============================================================
NODE="$(hostname)"
ACTION="${1:-fix}"
echo "============================================================"
echo " K-03 - SOAL 10: Para Pilot Terkunci di Dalam (Misato & Gendo)"
echo " Node : $NODE | Action : $ACTION"
echo "============================================================"

case "$NODE" in
    Misato|Gendo)
        if [ "$ACTION" = "break" ] && [ -f /root/break_nat.sh ]; then
            bash /root/break_nat.sh
        fi
        echo "=== [DIAGNOSA $NODE SEBELUM PERBAIKAN] ==="
        iptables -S
        iptables -t nat -S
        if [ "$ACTION" = "fix" ]; then
            echo "=== [MENJALANKAN PERBAIKAN PADA $NODE] ==="
            iptables -t nat -F
            iptables -F
            SH_FILE="/root/$(echo "$NODE" | tr 'A-Z' 'a-z').sh"
            bash "$SH_FILE"
            iptables -S
            iptables -t nat -S
        fi
        ;;
    Unit-01|Unit-02|Unit-00|Spy)
        echo "=== Uji Ping 8.8.8.8 dari $NODE ==="
        ping -c 3 -W 2 8.8.8.8
        echo "=== Uji Ping Lilith (10.65.4.74) dari $NODE ==="
        ping -c 3 -W 2 10.65.4.74
        ;;
esac
