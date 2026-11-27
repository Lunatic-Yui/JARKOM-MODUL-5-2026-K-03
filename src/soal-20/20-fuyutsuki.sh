NODE=$(hostname | tr 'A-Z' 'a-z')
RULES=/root/$NODE.rules

case "$1" in
  save)
    iptables-save > $RULES
    echo "tersimpan di $RULES ($(wc -l < $RULES) baris)"
    ;;
  destroy)
    iptables -P INPUT ACCEPT; iptables -P FORWARD ACCEPT; iptables -P OUTPUT ACCEPT
    iptables -F; iptables -X
    iptables -t nat -F; iptables -t nat -X
    ip route show | grep ' via ' | grep -v '192.168.122.' | while read r; do
      ip route del $r 2>/dev/null
    done
    echo "rule & rute dihancurkan"
    ;;
  restore)
    sh /root/$NODE.sh routes 2>/dev/null   
    iptables-restore < $RULES
    echo "dipulihkan"
    ;;
  count)
    echo "iptables -S       : $(iptables -S | wc -l) baris"
    echo "iptables -t nat -S: $(iptables -t nat -S | wc -l) baris"
    ip route
    ;;
esac