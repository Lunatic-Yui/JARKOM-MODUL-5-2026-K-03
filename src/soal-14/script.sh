#!/bin/sh
# ============================================================
# K-03 - SOAL 14: Jam Kunjungan Sang Pinguin (Pen-Pen Match Time UTC)
# ============================================================
NODE="$(hostname)"
MODE="${1:-normal}"
echo "============================================================"
echo " K-03 - SOAL 14: Jam Kunjungan Sang Pinguin (Pen-Pen)"
echo " Node : $NODE | Mode : $MODE (pilihan: normal | cocok | tidak_cocok)"
echo "============================================================"

if [ "$NODE" = "Pen-Pen" ]; then
    case "$MODE" in
        cocok)
            sed -i 's/^PILOT_START=.*/PILOT_START="00:00"/' /root/pen-pen.sh
            sed -i 's/^PILOT_STOP=.*/PILOT_STOP="23:59"/' /root/pen-pen.sh
            sed -i 's/^PILOT_DAYS=.*/PILOT_DAYS="Mon,Tue,Wed,Thu,Fri,Sat,Sun"/' /root/pen-pen.sh
            sed -i 's/^STAF_START=.*/STAF_START="00:00"/' /root/pen-pen.sh
            sed -i 's/^STAF_STOP=.*/STAF_STOP="23:59"/' /root/pen-pen.sh
            ;;
        tidak_cocok)
            sed -i 's/^PILOT_START=.*/PILOT_START="23:58"/' /root/pen-pen.sh
            sed -i 's/^PILOT_STOP=.*/PILOT_STOP="23:59"/' /root/pen-pen.sh
            sed -i 's/^PILOT_DAYS=.*/PILOT_DAYS="Mon,Tue,Wed,Thu,Fri"/' /root/pen-pen.sh
            sed -i 's/^STAF_START=.*/STAF_START="23:58"/' /root/pen-pen.sh
            sed -i 's/^STAF_STOP=.*/STAF_STOP="23:59"/' /root/pen-pen.sh
            ;;
        *)
            sed -i 's/^PILOT_START=.*/PILOT_START="01:00"/' /root/pen-pen.sh
            sed -i 's/^PILOT_STOP=.*/PILOT_STOP="09:00"/' /root/pen-pen.sh
            sed -i 's/^PILOT_DAYS=.*/PILOT_DAYS="Mon,Tue,Wed,Thu,Fri"/' /root/pen-pen.sh
            sed -i 's/^STAF_START=.*/STAF_START="10:00"/' /root/pen-pen.sh
            sed -i 's/^STAF_STOP=.*/STAF_STOP="16:00"/' /root/pen-pen.sh
            ;;
    esac
    bash /root/pen-pen.sh
    date -u
    head -n 7 /root/pen-pen.sh
    iptables -S PENPEN_SCHED
else
    echo "=== Uji Ping dari $NODE ke Pen-Pen (10.65.3.194) ==="
    ping -c 2 -W 1 10.65.3.194
fi
