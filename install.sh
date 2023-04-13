iptables -F
iptables -t raw -F
iptables -t nat -F
iptables -t mangle -F

echo 10000000 > /sys/module/nf_conntrack/parameters/hashsize

# iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j DROP
# iptables -t raw -A PREROUTING -p tcp -m connlimit --connlimit-above 5 -j DROP
# iptables -t raw -A PREROUTING -p tcp -m hashlimit --hashlimit-name flood_list --hashlimit-above 100/second --hashlimit-mode srcip --hashlimit-htable-expire 3000 -j DROP

iptables -t raw -A PREROUTING -p icmp -m icmp --icmp-type address-mask-request -j DROP
iptables -t raw -A PREROUTING -p icmp -m icmp --icmp-type timestamp-request -j DROP
iptables -t raw -A PREROUTING -p icmp -m icmp --icmp-type 8 -m limit --limit 1/second -j ACCEPT
