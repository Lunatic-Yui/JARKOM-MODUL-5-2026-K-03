#!/bin/sh
# ============================================================
# K-03 - MASTER SETUP RUNNER (SOAL 1 - 15)
# ============================================================
NODE="$(hostname)"
SH_FILE="/root/$(echo "$NODE" | tr 'A-Z' 'a-z').sh"
echo "============================================================"
echo " OPERATION GEOFRONT (K-03) - MASTER SETUP RUNNER"
echo " Node : $NODE"
echo "============================================================"
if [ -f "$SH_FILE" ]; then
    sh "$SH_FILE"
    echo "[OK] Konfigurasi $SH_FILE berhasil dijalankan pada $NODE."
else
    echo "[WARN] File $SH_FILE tidak ditemukan pada $NODE."
fi
