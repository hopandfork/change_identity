# change_identity
A script to modify hostname and mac address related to an interface.

## Prerequisite
"ifconfig" and "hostname" are nedeed.
Obtain the superuser permissions using "su" command before.

## Usage
- To change the hostname you can use: ```./change_identity -n hostname eth0``` 
- To change the mac you can use: ```./change_identity -m mac eth0```
- To change mac and hostname you can use: ```./change_identity -n hostname -m mac eth0```
- To restore mac and hostname you can use the default file "config_eth0": ```./change_identity -r eth0```
- To restore mac and hostname you can use a specific file: ```./change_identity -r config_custom eth0```
