#!/bin/bash

IMAGE='diginc/pi-hole:debian'
BASE_DIR='/home/jake/webtol/config'

IP_LOOKUP="$(ip route get 8.8.8.8 | awk '{ print $NF; exit }')"  # May not work for VPN / tun0
IP="${IP:-$IP_LOOKUP}"  # use $IP, if set, otherwise IP_LOOKUP
docker run -p 53:53/tcp -p 53:53/udp -p 80:80 --cap-add=NET_ADMIN -e ServerIP="$IP" --restart=always --name pihole -d $IMAGE

