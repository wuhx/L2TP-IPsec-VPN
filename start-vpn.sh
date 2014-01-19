#!/bin/bash
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this tool!\n"
    exit 1
fi
clear
#install packages
apt-get install -y openswan xl2tpd ppp

#patch configure file
source vpn.cfg
echo "VPN user: $vuser"
echo "VPN pass: $vpass"

cd etc
IP=$(ifconfig eth0|grep "inet addr"| awk '{print $(2)}'|cut -d ':' -f2)
echo "Local IP addr is: $IP"
sed "s/x.x.x.x/$IP/g" ipsec.conf.sample > ipsec.conf
sed -e "s/x.x.x.x/$IP/g" -e "s/vpass/$vpass/g" ipsec.secrets.sample > ipsec.secrets
sed -e "s/vuser/$vuser/g" -e "s/vpass/$vpass/g" ppp/chap-secrets.sample > ppp/chap-secrets
cp * /etc -fr

sysctl -p

#TODO iptables port 500 4500 1701
iptables -F
iptables --table nat --append POSTROUTING --jump MASQUERADE
iptables-save > /etc/iptables.rules

# Start IPSec
service xl2tpd stop
service ipsec stop
service ipsec start
service xl2tpd start
sleep 3
ipsec verify

