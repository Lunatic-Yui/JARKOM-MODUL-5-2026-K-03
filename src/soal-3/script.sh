#!/bin/sh
# ============================================================
# K-03 - SOAL 3: Static Routing & Peringkasan CIDR (10.65.4.80/28)
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 3: Static Routing & CIDR Summarization"
echo " Node : $NODE"
echo "============================================================"

case "$NODE" in
    Gendo)
        # Cabang Hikari
        ip route replace 10.65.2.0/24 via 10.65.4.114
        ip route replace 10.65.3.224/27 via 10.65.4.114
        ip route replace 10.65.4.128/30 via 10.65.4.114
        # Cabang Yui
        ip route replace 10.65.0.0/23 via 10.65.4.118
        ip route replace 10.65.3.0/25 via 10.65.4.118
        ip route replace 10.65.4.0/27 via 10.65.4.118
        ip route replace 10.65.4.32/28 via 10.65.4.118
        ip route replace 10.65.4.108/30 via 10.65.4.118
        ip route replace 10.65.4.132/30 via 10.65.4.118
        ip route replace 10.65.4.136/30 via 10.65.4.118
        # Cabang Fuyutsuki
        ip route replace 10.65.3.192/27 via 10.65.4.146
        ip route replace 10.65.4.56/29 via 10.65.4.146
        ip route replace 10.65.4.72/29 via 10.65.4.146
        ip route replace 10.65.4.124/30 via 10.65.4.146
        ip route replace 10.65.4.152/30 via 10.65.4.146
        # Cabang Misato
        ip route replace 10.65.4.64/29 via 10.65.4.150
        # Cabang Shigeru (Ringkasan CIDR: 10.65.4.80/29 + 10.65.4.88/29 -> 10.65.4.80/28)
        ip route del 10.65.4.80/29 2>/dev/null || true
        ip route del 10.65.4.88/29 2>/dev/null || true
        ip route replace 10.65.4.80/28 via 10.65.4.158
        ip route replace 10.65.4.160/30 via 10.65.4.158
        # Cabang Asuka
        ip route replace 10.65.3.128/26 via 10.65.4.166
        ip route replace 10.65.4.48/29 via 10.65.4.166
        ip route replace 10.65.4.96/30 via 10.65.4.166
        ip route replace 10.65.4.120/30 via 10.65.4.166
        ip route replace 10.65.4.140/30 via 10.65.4.166
        # Cabang Kaji
        ip route replace 10.65.4.100/30 via 10.65.4.170
        ip route
        ;;
    Hikari)
        ip route replace default via 10.65.4.113
        ip route replace 10.65.3.224/27 via 10.65.4.130
        ip route
        ;;
    Yui)
        ip route replace default via 10.65.4.117
        ip route replace 10.65.0.0/23 via 10.65.4.110
        ip route replace 10.65.4.0/27 via 10.65.4.134
        ip route replace 10.65.4.32/28 via 10.65.4.138
        ip route
        ;;
    Fuyutsuki)
        ip route replace default via 10.65.4.145
        ip route replace 10.65.3.192/27 via 10.65.4.126
        ip route replace 10.65.4.72/29 via 10.65.4.154
        ip route
        ;;
    Shigeru)
        ip route replace default via 10.65.4.157
        ip route replace 10.65.4.88/29 via 10.65.4.162
        ip route
        ;;
    Asuka)
        ip route replace default via 10.65.4.165
        ip route replace 10.65.3.128/26 via 10.65.4.122
        ip route replace 10.65.4.48/29 via 10.65.4.142
        ip route
        ;;
    Rei)     ip route replace default via 10.65.4.109; ip route ;;
    Kensuke) ip route replace default via 10.65.4.121; ip route ;;
    Maya)    ip route replace default via 10.65.4.125; ip route ;;
    Kaworu)  ip route replace default via 10.65.4.129; ip route ;;
    Shinji)  ip route replace default via 10.65.4.133; ip route ;;
    Mari)    ip route replace default via 10.65.4.137; ip route ;;
    Ritsuko) ip route replace default via 10.65.4.141; ip route ;;
    Misato)  ip route replace default via 10.65.4.149; ip route ;;
    Toji)    ip route replace default via 10.65.4.153; ip route ;;
    Makoto)  ip route replace default via 10.65.4.161; ip route ;;
    Kaji)    ip route replace default via 10.65.4.169; ip route ;;
    Armisael)
        ip addr flush dev eth0; ip addr add 10.65.4.83/29 dev eth0; ip link set eth0 up
        ip route replace default via 10.65.4.81
        echo "=== Uji Ping dari Armisael ke Lilith (10.65.4.74) ==="
        ping -c 3 -W 2 10.65.4.74
        echo "=== Uji Ping dari Armisael ke Sachiel (10.65.3.130) ==="
        ping -c 3 -W 2 10.65.3.130
        echo "=== Uji Ping dari Armisael ke Comm-Net (10.65.2.2) ==="
        ping -c 3 -W 2 10.65.2.2
        ;;
    Lilith)   ip addr flush dev eth0; ip addr add 10.65.4.74/29 dev eth0; ip link set eth0 up; ip route replace default via 10.65.4.73; ip -br -4 a ;;
    Sachiel)  ip addr flush dev eth0; ip addr add 10.65.3.130/26 dev eth0; ip link set eth0 up; ip route replace default via 10.65.3.129; ip -br -4 a ;;
    Comm-Net) ip addr flush dev eth0; ip addr add 10.65.2.2/24 dev eth0; ip link set eth0 up; ip route replace default via 10.65.2.1; ip -br -4 a ;;
esac
