# L2TP/IPSec VPN Server autoconfig script
Only tested with Ubuntu 12.04 on Amazon EC2 t1.micro 

### How to Use
1. Set user & passwd in vpn.cfg
1. Run ./start-vpn as root(need only once, will auto started next boot).
1. Connect to vpn server use Win/MAC/IOS buildin vpn client.[howto](http://www.vpngate.net/en/howto_l2tp.aspx)
1. Happy surfing.

### What have been done
1. install openswan/xl2tpd from ubuntu official repo.
1. do some dirty work(tune kernel network config, change iptables rules, etc)
1. start L2TP/IPSec service use the user&passwd in vpn.cfg.



