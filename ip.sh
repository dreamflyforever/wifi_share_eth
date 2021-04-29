echo 0 > /proc/sys/net/ipv4/ip_forward
iptables -F
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
/system/bin/iptables -t nat -A natctrl_nat_POSTROUTING -o wlan0 -j MASQUERADE
/system/bin/iptables -A natctrl_FORWARD -i wlan0 -o eth0 -m state --state ESTABLISHED,RELATED -g natctrl_tether_counters
/system/bin/iptables -A natctrl_FORWARD -i eth0 -o wlan0 -m state --state INVALID -j DROP
/system/bin/iptables -A natctrl_FORWARD -i eth0 -o wlan0 -g natctrl_tether_counters
/system/bin/iptables -A natctrl_tether_counters -i eth0 -o wlan0 -j RETURN
/system/bin/iptables -A natctrl_tether_counters -i wlan0 -o eth0 -j RETURN
/system/bin/iptables -D natctrl_FORWARD -j DROP
/system/bin/iptables -A natctrl_FORWARD -j DROP
echo 1 > /proc/sys/net/ipv4/ip_forward

ip route add 10.10.11.0/24 dev eth0 table local_network proto static scope link
ifconfig eth0 10.10.11.3
