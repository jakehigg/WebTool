#!/bin/bash

IMAGE='diginc/pi-hole:debian'
CONF_DIR='/home/jake/webtool/config'
LOG_DIR='/home/jake/logs'

IP_LOOKUP="$(ip route get 8.8.8.8 | awk '{ print $NF; exit }')"  # May not work for VPN / tun0
IP="${IP:-$IP_LOOKUP}"  # use $IP, if set, otherwise IP_LOOKUP
touch $LOG_DIR/pihole.log
docker run -p 53:53/tcp -p 53:53/udp -p 80:80 -v $LOG_DIR/pihole.log:/var/log/pihole.log -v $CONF_DIR/pihole:/etc/pihole/ --cap-add=NET_ADMIN -e ServerIP="$IP" -e WEBPASSWORD="admin" -e DNS1="10.10.22.2" -e DNS2="10.10.21.2" --restart=always --name pihole -d $IMAGE

