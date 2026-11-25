#!/bin/sh
# ============================================================
# K-03 - SOAL 2: Konfigurasi IP Interface Router & IP Forwarding
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 2: Setup IP Interface Router & IP Forwarding"
echo " Node : $NODE"
echo "============================================================"

set_iface() {
    ip addr flush dev "$1" 2>/dev/null || true
    ip addr add "$2" dev "$1"
    ip link set "$1" up
}

sysctl -w net.ipv4.ip_forward=1 >/dev/null

case "$NODE" in
    Gendo)
        ip link set eth0 up
        if ! ip -4 addr show dev eth0 | grep -q 'inet '; then
            /gns3/bin/udhcpc -i eth0 -s /gns3/etc/udhcpc/default.script -q -n -t 3 >/dev/null 2>&1 || true
        fi
        set_iface eth1 10.65.4.105/30
        set_iface eth2 10.65.4.113/30
        set_iface eth3 10.65.4.117/30
        set_iface eth4 10.65.4.145/30
        set_iface eth5 10.65.4.149/30
        set_iface eth6 10.65.4.157/30
        set_iface eth7 10.65.4.165/30
        set_iface eth8 10.65.4.169/30
        echo "--- Verifikasi ip -br a ---"
        ip -br -4 a
        echo "--- Uji Ping ke 7 Router Cabang di Bawah Gendo ---"
        for target in 10.65.4.114 10.65.4.118 10.65.4.146 10.65.4.150 10.65.4.158 10.65.4.166 10.65.4.170; do
            ping -c 1 -W 1 "$target" | grep -E "PING|bytes from|packet loss"
        done
        ;;
    Rei)
        set_iface eth0 10.65.4.110/30
        set_iface eth1 10.65.0.1/23
        ip -br -4 a; ping -c 1 -W 1 10.65.4.109
        ;;
    Hikari)
        set_iface eth0 10.65.4.114/30
        set_iface eth1 10.65.2.1/24
        set_iface eth2 10.65.4.129/30
        ip -br -4 a; ping -c 1 -W 1 10.65.4.113; ping -c 1 -W 1 10.65.4.130
        ;;
    Yui)
        set_iface eth0 10.65.4.118/30
        set_iface eth1 10.65.3.1/25
        set_iface eth2 10.65.4.109/30
        set_iface eth3 10.65.4.133/30
        set_iface eth4 10.65.4.137/30
        ip -br -4 a
        for target in 10.65.4.117 10.65.4.110 10.65.4.134 10.65.4.138; do
            ping -c 1 -W 1 "$target" | grep -E "PING|bytes from|packet loss"
        done
        ;;
    Kensuke)
        set_iface eth0 10.65.4.122/30
        set_iface eth1 10.65.3.129/26
        ip -br -4 a; ping -c 1 -W 1 10.65.4.121
        ;;
    Maya)
        set_iface eth0 10.65.4.126/30
        set_iface eth1 10.65.3.193/27
        ip -br -4 a; ping -c 1 -W 1 10.65.4.125
        ;;
    Kaworu)
        set_iface eth0 10.65.4.130/30
        set_iface eth1 10.65.3.225/27
        ip -br -4 a; ping -c 1 -W 1 10.65.4.129
        ;;
    Shinji)
        set_iface eth0 10.65.4.134/30
        set_iface eth1 10.65.4.1/27
        ip -br -4 a; ping -c 1 -W 1 10.65.4.133
        ;;
    Mari)
        set_iface eth0 10.65.4.138/30
        set_iface eth1 10.65.4.33/28
        ip -br -4 a; ping -c 1 -W 1 10.65.4.137
        ;;
    Ritsuko)
        set_iface eth0 10.65.4.142/30
        set_iface eth1 10.65.4.49/29
        ip -br -4 a; ping -c 1 -W 1 10.65.4.141
        ;;
    Fuyutsuki)
        set_iface eth0 10.65.4.146/30
        set_iface eth1 10.65.4.57/29
        set_iface eth2 10.65.4.125/30
        set_iface eth3 10.65.4.153/30
        ip -br -4 a
        for target in 10.65.4.145 10.65.4.126 10.65.4.154; do
            ping -c 1 -W 1 "$target" | grep -E "PING|bytes from|packet loss"
        done
        ;;
    Misato)
        set_iface eth0 10.65.4.150/30
        set_iface eth1 10.65.4.65/29
        ip -br -4 a; ping -c 1 -W 1 10.65.4.149
        ;;
    Toji)
        set_iface eth0 10.65.4.154/30
        set_iface eth1 10.65.4.73/29
        ip -br -4 a; ping -c 1 -W 1 10.65.4.153
        ;;
    Shigeru)
        set_iface eth0 10.65.4.158/30
        set_iface eth1 10.65.4.81/29
        set_iface eth2 10.65.4.161/30
        ip -br -4 a; ping -c 1 -W 1 10.65.4.157; ping -c 1 -W 1 10.65.4.162
        ;;
    Makoto)
        set_iface eth0 10.65.4.162/30
        set_iface eth1 10.65.4.89/29
        ip -br -4 a; ping -c 1 -W 1 10.65.4.161
        ;;
    Asuka)
        set_iface eth0 10.65.4.166/30
        set_iface eth1 10.65.4.97/30
        set_iface eth2 10.65.4.121/30
        set_iface eth3 10.65.4.141/30
        ip -br -4 a
        for target in 10.65.4.165 10.65.4.122 10.65.4.142; do
            ping -c 1 -W 1 "$target" | grep -E "PING|bytes from|packet loss"
        done
        ;;
    Kaji)
        set_iface eth0 10.65.4.170/30
        set_iface eth1 10.65.4.101/30
        ip -br -4 a; ping -c 1 -W 1 10.65.4.169
        ;;
    *)
        echo "[INFO] Jalankan script Soal 2 pada salah satu dari 17 router."
        ;;
esac
