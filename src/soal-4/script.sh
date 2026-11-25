#!/bin/sh
# ============================================================
# K-03 - SOAL 4: NAT Masquerade & DNS Resolver (Gendo, Armisael, Lilith)
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 4: Akses Internet Lewat Gendo (NAT & DNS)"
echo " Node : $NODE"
echo "============================================================"

case "$NODE" in
    Gendo)
        sysctl -w net.ipv4.ip_forward=1 >/dev/null
        echo "nameserver 8.8.8.8" > /etc/resolv.conf
        iptables -t nat -F POSTROUTING
        iptables -t nat -A POSTROUTING -s 10.65.0.0/16 -o eth0 -j MASQUERADE
        echo "=== Rule NAT dan Counter pada Gendo ==="
        iptables -t nat -S POSTROUTING
        iptables -t nat -L POSTROUTING -n -v --line-numbers
        ;;
    Armisael|Lilith)
        echo "nameserver 8.8.8.8" > /etc/resolv.conf
        echo "=== Uji Ping 8.8.8.8 dari $NODE ==="
        ping -c 3 -W 2 8.8.8.8
        echo "=== Uji Ping deb.debian.org dari $NODE ==="
        ping -c 3 -W 2 deb.debian.org
        ;;
    *)
        echo "nameserver 8.8.8.8" > /etc/resolv.conf
        echo "[OK] DNS resolver 8.8.8.8 dikonfigurasi pada $NODE."
        ;;
esac
