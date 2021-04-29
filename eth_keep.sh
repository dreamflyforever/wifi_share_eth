#! /system/bin/sh

echo $1
network=0
while true
do
    ps -ef | grep -w $1 | grep -v "grep"
    if [ "$?" -eq 1 ]
        then
        $1 #start your application
        echo "process has been restarted!"
    else
        echo "process already started!"
    fi
    #check the eth link
    eth_link=$(cat /sys/class/net/eth0/carrier)
    if [ 0 -eq $eth_link ]
    then
    	echo "link down"
	network=1
    else
    	if [ 1 -eq $network ]
	then
		datename=$(date +%Y%m%d-%H%M%S)
		echo ${datename} >> /data/sum
    		echo "link up"
		/data/ip.sh
		network=0
	fi
    fi
    sleep 5
    if [ ! -e "/data/onlyonce" ]; then
	echo "onlyonce, dont delete it" > /data/onlyonce
	reboot
    fi
done
