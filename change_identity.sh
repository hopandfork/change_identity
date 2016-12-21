parameters_count=$#
config_file="config"
hostname=$(hostname)
if [ "$OSTYPE" = "linux-gnu" ]; then
	mac=$(ifconfig eth0 | grep HWaddr | cut -d " " -f 11);
elif [ "$OSTYPE" = "darwin14" ]; then
	mac=$(ifconfig en0 ether | grep ether | cut -d " " -f 2);
fi
execute=1

#Create a config file
config_file_exists=0
file_list=$(ls)
	for file in $file_list; do \
		if [ "$file" = "$config_file" ]; then
			config_file_exists=1;
		fi
	done

if [ $config_file_exists -eq 0 ]; then
	echo "hostname=$hostname" > config 
	echo "mac=$mac" >> config
fi

#Parse command line
if [ $parameters_count -eq 4 ]; then 
		if [ "$1" = "-n" ] && [ "$3" = "-m" ]; then
			hostname=$2
			mac=$4;
		elif [ "$1" = "-m" ] && [ "$3" = "-n" ]; then
			hostname=$4
			mac=$2;
		fi
elif [ $parameters_count -eq 2 ]; then 
	if [ "$1" = "-n" ]; then 
		hostname=$2;
	elif [ "$1" = "-m" ]; then
		mac=$2;
	elif [ "$1" = "-r" ]; then
		hostname=$(grep $2 -e "hostname=" | cut -d "=" -f 2)
		mac=$(grep $2 -e "mac=" | cut -d "=" -f 2);
    else
        echo "Incorrect parameter $1";
	fi
elif [ $parameters_count -eq 1 ]; then
    if [ "$1" = "--help" ]; then
        execute=0
        echo "-n hostname	Hostname to set, executed twice the settings will
		be resetted"
        echo "-m mac		Mac address"
		echo "-r restore	Restore default value of hostname and mac address,
		optionally you can specify a different config file";
	elif [ "$1" = "-r" ]; then
		hostname=$(grep $config_file -e "hostname=" | cut -d "=" -f 2)
		mac=$(grep $config_file -e "mac=" | cut -d "=" -f 2);
    else
		execute=0
        echo "Incorrect parameter $1";
	fi
fi

#Execute commands
if [ $execute -eq 1 ]; then
	hostname "$hostname"
	if [ "$OSTYPE" = "linux-gnu" ]; then
		ifconfig eth0 hw ether "$mac";
	elif [ "$OSTYPE" = "darwin14" ]; then
		ifconfig en0 ether "$mac";
	fi
fi
