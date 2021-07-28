#!/bin/bash

primary=$(iw dev wlan0 scan |  sed -n '/ff\:ff\:ff\:ff\:ff\:ff/,/STA/p' |  sed -n '/primary/p' | awk '{print $4}' )
sleep 3s
primary2=$(iw dev | sed -n '/channel/p' | awk '{print $2}')
sleep 1s

while :
do 
	if [ "$primary" = "" ]
	then
		primary=$(iw dev wlan0 scan |  sed -n '/ff\:ff\:ff\:ff\:ff\:ff/,/STA/p' |  sed -n '/primary/p' | awk '{print $4}' )
		echo "The other side channel is not obtained!"
		sleep 5s
	else  
		echo "The other side device channel is $primary !"
		echo "This device channel is $primary2 !"
		break
	fi
done

if [ $primary != $primary2 ]
then
case $primary in
	1)  uci set wireless.@wifi-device[0].channel=7
	;;
	2)  uci set wireless.@wifi-device[0].channel=8
	;;
	3)  uci set wireless.@wifi-device[0].channel=9
	;;
	4)  uci set wireless.@wifi-device[0].channel=10
	;;
	5)  uci set wireless.@wifi-device[0].channel=11
	;;
	6)  uci set wireless.@wifi-device[0].channel=12
	;;
	7)  uci set wireless.@wifi-device[0].channel=13
	;;
	8)  uci set wireless.@wifi-device[0].channel=1
	;;
	9)  uci set wireless.@wifi-device[0].channel=2
	;;
	10)  uci set wireless.@wifi-device[0].channel=3
	;;
	12)  uci set wireless.@wifi-device[0].channel=4
	;;
	13)  uci set wireless.@wifi-device[0].channel=5
	;;
	*)  uci set wireless.@wifi-device[0].channel=6
	;;
esac
	uci commit    
	/etc/init.d/network restart   
	echo "Channel is changed !" 

fi
sleep 20s
primary2=$(iw dev | sed -n '/channel/p' | awk '{print $2}')
echo "This device channel is $primary2 !"
exit

