#!/bin/bash
if [ $UID = 0 ]
then 
	echo "This script should not be run as root!"
	exit
fi

output=~/research/sys_info.txt

# if research dir not there, create it
if [ ! -d $HOME/research ]
then
	mkdir $HOME/research 2> /dev/null
fi

#if output file doesn't exist, creat it
if [ ! -f $output ]
then
	touch $output
fi


echo -e "System Information" > $output


echo -e "Date: $(date)"  >> $output


echo "Machine Type Info:" >> $output


echo $MACHTYPE >> $output


echo -e "Uname info: $(uname -a) \n" >> $output

#Network Info

ip=$(ip addr | head -9| tail -1)

echo -e "IP Address: $(hostname -I |awk '{print $1}')" >> $output

echo -e "IP INFO: $ip \n" >> $output

echo -e "Hostname: $(hostname)" >> $output


echo -e "DNS Info: $(cat /etc/resolv.conf | grep -v '#')" >> $output

#System Hardware info

free >> $output


lscpu >> $output


df -h | head -n 8 >> $output


who >> $output

executables=$(find /home -type f -perm 777)_

echo "Executable Files: \m$executables" >> $output
