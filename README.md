# change_identity
A script to modify hostname and mac address related to an interface.

##Prerequisite
ifconfig and hostname are nedeed.
Obtain the superuser permissions using "su" command.

##Usage


1) To change the hostname you can use: ./change_identity -n hostname eth0 
2) To change the mac you can use: ./change_identity -m mac eth0
3) To change mac and hostname you can use: ./change_identity -n hostname -m mac eth0
4) To restore mac and hostname you can use the default file "config_eth0": ./change_identity -r eth0
5) To restore mac and hostname you can use a specific file: ./change_identity -r config_custom eth0
