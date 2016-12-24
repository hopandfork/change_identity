parameters_count=$#
interface="${!#}"
config_file="config_"$interface
execute=1

#Parse command line
if [ $parameters_count -eq 5 ]; then 
	if [ "$1" = "-n" ] && [ "$3" = "-m" ]; then
		new_hostname=$2
		new_mac=$4;
	elif [ "$1" = "-m" ] && [ "$3" = "-n" ]; then
		new_hostname=$4
		new_mac=$2;
	fi
elif [ $parameters_count -eq 3 ]; then 
	if [ "$1" = "-n" ]; then 
		new_hostname=$2;
	elif [ "$1" = "-m" ]; then
		new_mac=$2;
	elif [ "$1" = "-r" ]; then
		new_hostname=$(grep $2 -e "hostname=" | cut -d "=" -f 2)
		new_mac=$(grep $2 -e "mac=" | cut -d "=" -f 2);
    	else
        	echo "Incorrect parameter $1"
		exit 1;
	fi
elif [ $parameters_count -eq 2 ]; then
	if [ "$1" = "-r" ]; then
		new_hostname=$(grep $config_file -e "hostname=" | cut -d "=" -f 2)
		new_mac=$(grep $config_file -e "mac=" | cut -d "=" -f 2);
    	else
        	echo "Incorrect parameter $1"
		exit 1;
	fi
elif [ $parameters_count -eq 1 ]; then
    	if [ "$1" = "--help" ]; then
        	execute=0
		echo "change_identity [options] interface"
		echo "-n hostname	Hostname to set"
        	echo "-m mac		Mac address to set"
		echo "-r restore	Restore default value of hostname and 
		mac address es. change_identity -r interface,
		optionally you can specify a different config file";
	else
        	echo "Incorrect parameter $1"
		exit 1;
	fi
fi

if [ $execute -eq 1 ]; then
	#[BUG 1] ifconfig problem: eth0 -> mac_eth0 and eth -> mac_eth0 
	hostname=$(hostname)
	if [ "$OSTYPE" = "linux-gnu" ]; then
		mac=$(ifconfig $interface | grep HWaddr | cut -d " " -f 11);
	elif [ "$OSTYPE" = "darwin14" ]; then
		mac=$(ifconfig $interface ether | grep ether | cut -d " " -f 2);
	fi
	
	#Create a config file
	config_file_exists=0
	file_list=$(ls)
		for file in $file_list; do \
			if [ "$file" = "$config_file" ]; then
				config_file_exists=1;
			fi
		done
	
	if [ $config_file_exists -eq 0 ]; then
		echo "hostname=$hostname" > "$config_file" 
		echo "mac=$mac" >> "$config_file"
	fi
	
	#Execute commands
	if [ "$new_hostname" = "" ]; then
		new_hostname=$hostname;
	fi
	
	if [ "$new_mac" = "" ]; then
		new_mac=$mac;
	fi
	
	hostname "$new_hostname"
	if [ "$OSTYPE" = "linux-gnu" ]; then
		ifconfig eth0 hw ether "$new_mac";
	elif [ "$OSTYPE" = "darwin14" ]; then
		ifconfig en0 ether "$new_mac";
	fi
fi
