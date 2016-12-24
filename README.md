# change_identity
A script to modify hostname and mac address related to an interface.

##Prerequisite
ifconfig and hostname are nedeed.

##Usage
1) To change the hostname you can use: sudo ./change_identity -n hostname eth0 
2) To change the mac you can use: sudo ./change_identity -m mac eth0
3) To change mac and hostname you can use: sudo ./change_identity -n hostname -m mac eth0
4) To restore mac and hostname you can use the default file "config_eth0": sudo ./change_identity -r eth0
5) To restore mac and hostname you can use a specific file: sudo ./change_identity -r config_custom eth0
