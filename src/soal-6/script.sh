#!/bin/sh
# ============================================================
# K-03 - SOAL 6: Konfigurasi IP Statis Permanen Seluruh Host Non-Router
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 6: Konfigurasi IP Statis & Gateway Permanen"
echo " Node : $NODE"
echo "============================================================"

setup_host() {
    IP="$1"; PREF="$2"; MASK="$3"; GW="$4"
    cat > /etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address $IP
    netmask $MASK
    gateway $GW
    up echo nameserver 8.8.8.8 > /etc/resolv.conf
EOF
    echo "nameserver 8.8.8.8" > /etc/resolv.conf
    ip addr flush dev eth0
    ip addr add "$IP/$PREF" dev eth0
    ip link set eth0 up
    ip route replace default via "$GW"
    echo "=== ip -br a pada $NODE ==="
    ip -br -4 a
    echo "=== Uji Ping ke Gateway ($GW) ==="
    ping -c 3 -W 2 "$GW"
}

case "$NODE" in
    Quarters)       setup_host 10.65.0.2   23 255.255.254.0   10.65.0.1   ;;
    Comm-Net)       setup_host 10.65.2.2   24 255.255.255.0   10.65.2.1   ;;
    Hangar-Crew)    setup_host 10.65.3.2   25 255.255.255.128 10.65.3.1   ;;
    Sachiel)        setup_host 10.65.3.130 26 255.255.255.192 10.65.3.129 ;;
    Pen-Pen)        setup_host 10.65.3.194 27 255.255.255.224 10.65.3.193 ;;
    Medic-Bay)      setup_host 10.65.3.195 27 255.255.255.224 10.65.3.193 ;;
    Relay-Node)     setup_host 10.65.3.226 27 255.255.255.224 10.65.3.225 ;;
    Garden-Staff)   setup_host 10.65.4.2   27 255.255.255.224 10.65.4.1   ;;
    Dock-Crew)      setup_host 10.65.4.34  28 255.255.255.240 10.65.4.33  ;;
    Entry-Plug)     setup_host 10.65.4.50  29 255.255.255.248 10.65.4.49  ;;
    Dummy-Plug)     setup_host 10.65.4.51  29 255.255.255.248 10.65.4.49  ;;
    Magi-Casper)    setup_host 10.65.4.58  29 255.255.255.248 10.65.4.57  ;;
    Magi-Balthasar) setup_host 10.65.4.59  29 255.255.255.248 10.65.4.57  ;;
    Magi-Melchior)  setup_host 10.65.4.60  29 255.255.255.248 10.65.4.57  ;;
    Unit-01)        setup_host 10.65.4.66  29 255.255.255.248 10.65.4.65  ;;
    Unit-02)        setup_host 10.65.4.67  29 255.255.255.248 10.65.4.65  ;;
    Unit-00)        setup_host 10.65.4.68  29 255.255.255.248 10.65.4.65  ;;
    Lilith)         setup_host 10.65.4.74  29 255.255.255.248 10.65.4.73  ;;
    Adam)           setup_host 10.65.4.75  29 255.255.255.248 10.65.4.73  ;;
    Zeruel)         setup_host 10.65.4.82  29 255.255.255.248 10.65.4.81  ;;
    Armisael)       setup_host 10.65.4.83  29 255.255.255.248 10.65.4.81  ;;
    Radar-Array)    setup_host 10.65.4.90  29 255.255.255.248 10.65.4.89  ;;
    Archive-Vault)  setup_host 10.65.4.98  30 255.255.255.252 10.65.4.97  ;;
    Spy)            setup_host 10.65.4.102 30 255.255.255.252 10.65.4.101 ;;
    Tokyo3-Core)    setup_host 10.65.4.106 30 255.255.255.252 10.65.4.105 ;;
    *)              echo "[INFO] Node $NODE adalah router." ;;
esac
