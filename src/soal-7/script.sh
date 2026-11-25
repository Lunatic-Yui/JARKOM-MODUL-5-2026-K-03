#!/bin/sh
# ============================================================
# K-03 - SOAL 7: Membangunkan MAGI (Casper, Balthasar, Melchior)
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 7: Instalasi iptables & netcat-traditional MAGI"
echo " Node : $NODE"
echo "============================================================"

case "$NODE" in
    Magi-Casper|Magi-Balthasar|Magi-Melchior)
        SH_FILE="/root/$(echo "$NODE" | tr 'A-Z' 'a-z').sh"
        bash "$SH_FILE"
        echo "=== Isi Log Pesan Masuk pada $NODE ==="
        cat /root/log_*.txt 2>/dev/null || true
        ;;
    Lilith)
        echo "=== Mengirim Pesan Uji dari Lilith ke Ketiga MAGI ==="
        echo "Halo Magi-Casper:5000 dari Lilith"    | nc -w 2 10.65.4.58 5000; echo "exit_casper_5000=$?"
        echo "Halo Magi-Balthasar:5000 dari Lilith" | nc -w 2 10.65.4.59 5000; echo "exit_balthasar_5000=$?"
        echo "Halo Magi-Balthasar:5001 dari Lilith" | nc -w 2 10.65.4.59 5001; echo "exit_balthasar_5001=$?"
        echo "Halo Magi-Melchior:5000 dari Lilith"  | nc -w 2 10.65.4.60 5000; echo "exit_melchior_5000=$?"
        ;;
    *)
        echo "[INFO] Jalankan pada Magi-Casper, Magi-Balthasar, Magi-Melchior, atau Lilith."
        ;;
esac
