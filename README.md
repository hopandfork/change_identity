# change_identity
A script to modify hostname and mac address related to an interface.

##Prerequisite
"ifconfig" and "hostname" are nedeed.

##Usage
- To change the hostname you can use: ```sudo ./change_identity -n hostname eth0```
- To change the mac you can use: ```sudo ./change_identity -m mac eth0```
- To change mac and hostname you can use: ```sudo ./change_identity -n hostname -m mac eth0```
- To restore mac and hostname you can use the default file "config_eth0": ```sudo ./change_identity -r eth0```
- To restore mac and hostname you can use a specific file: ```sudo ./change_identity -r config_custom eth0```
