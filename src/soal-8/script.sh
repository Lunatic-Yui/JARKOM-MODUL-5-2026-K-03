#!/bin/sh
# ============================================================
# K-03 - SOAL 8: Mengenali Kondisi Normal (Pen-Pen & Tokyo3-Core)
# ============================================================
NODE="$(hostname)"
echo "============================================================"
echo " K-03 - SOAL 8: Listener Normal Pen-Pen & Tokyo3-Core"
echo " Node : $NODE"
echo "============================================================"

case "$NODE" in
    Pen-Pen|Tokyo3-Core)
        SH_FILE="/root/$(echo "$NODE" | tr 'A-Z' 'a-z').sh"
        bash "$SH_FILE"
        echo "[OK] Listener $NODE aktif."
        ;;
    Lilith)
        echo "=== 1. Koneksi ke Pen-Pen (10.65.3.194:80) ==="
        nc -w 3 10.65.3.194 80 </dev/null; echo "exit=$?"
        echo "=== 2. Koneksi ke Tokyo3-Core (10.65.4.106:80) ==="
        nc -w 3 10.65.4.106 80 </dev/null; echo "exit=$?"
        echo "=== 3. Koneksi ke Tokyo3-Core (10.65.4.106:8080) ==="
        nc -w 3 10.65.4.106 8080 </dev/null; echo "exit=$?"
        echo "=== 4. Koneksi ke Port Tidak Dilayani (Port 22 - Langsung Gagal/Refused) ==="
        time nc -w 3 10.65.3.194 22 </dev/null; echo "exit=$?"
        time nc -w 3 10.65.4.106 22 </dev/null; echo "exit=$?"
        ;;
    *)
        echo "[INFO] Jalankan pada Pen-Pen, Tokyo3-Core, atau Lilith."
        ;;
esac
