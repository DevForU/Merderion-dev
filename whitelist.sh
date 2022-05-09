#!/bin/bash

read -p "IP to the Whitelist (CTRL+V or just type it in) : " ip
read -p "Enter the first port number : " port
read -p "Enter hours from now to delete the rules : " hours

hours=`date -d "+$hours hour " +%R`

hour=$(awk -F:  '{print $1}' <<< $hours)
minute=$(awk -F:  '{print $2}' <<< $hours)

echo "Opening ports.."
sudo ufw  allow from $ip to any port $port
sudo ufw reload
echo "IP $ip succesfully added to the Whitelist"

sudo crontab -l > mycron
#echo new cron into cron file
echo "$minute $hour * * * sudo ufw delete allow from $ip to any port $port1 && sudo sed -i  "'"/'$minute $hour' \* \* \* sudo ufw delete allow from '$ip' to any port 1/d"'" /var/spool/cron/crontabs/root" >> mycron
#install new cron file
sudo crontab mycron