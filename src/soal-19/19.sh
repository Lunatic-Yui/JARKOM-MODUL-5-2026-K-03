#!/bin/bash
# pakai: sh 19.sh listen   (di Armisael, Zeruel, Lilith, Spy)
#        sh 19.sh test     (di Armisael dan Zeruel)
SPY=10.65.4.102
ZERUEL=10.65.4.82
LILITH=10.65.4.74
NODE=$(hostname)

if command -v nc.traditional >/dev/null; then
  LISTEN="nc.traditional -l -p"
else
  LISTEN="nc -l"
fi

check() {  # $1=nama $2=ip $3=port
  if ping -c 2 -W 2 $2 >/dev/null 2>&1; then P=BERHASIL; else P=GAGAL; fi
  if nc -z -w 3 $2 $3 >/dev/null 2>&1; then N=BERHASIL; else N=GAGAL; fi
  echo "$NODE -> $1 ($2): ping=$P  nc:$3=$N"
}

case "$1" in
  listen)
    case "$NODE" in
      Spy|spy) PORT=53 ;;
      *)       PORT=9000 ;;
    esac
    pkill -f "while true; do $LISTEN $PORT" 2>/dev/null
    nohup sh -c "while true; do $LISTEN $PORT >/dev/null 2>&1; sleep 0.2; done" >/dev/null 2>&1 &
    echo "listener $PORT aktif di $NODE"
    ;;
  test)
    case "$NODE" in
      Armisael|armisael)
        check Spy    $SPY    53
        check Zeruel $ZERUEL 9000
        check Lilith $LILITH 9000 ;;
      Zeruel|zeruel)
        check Spy    $SPY    53
        check Lilith $LILITH 9000 ;;
    esac ;;
esac