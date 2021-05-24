#! /system/bin/sh

while [ 1 ]
do
     ipaddr=` ifconfig eth0 | grep "inet addr" | busybox awk '{ print $2}' | busybox awk -F: '{print $2}' `
     if [ ! -n "$ipaddr" ]
     then
          echo "NO IP Addr"
	  ip.sh
     fi 
        sleep 3
done
