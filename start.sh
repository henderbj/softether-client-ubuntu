#!/bin/bash
eval "cat <<EOF
$(<softether.inp)
EOF
" >softether.in 2>/dev/null
mkdir /dev/net && \
mknod /dev/net/tun c 10 200
./vpnclient start 
./vpncmd localhost /CLIENT /PASSWORD:"" /IN:softether.in
sleep 1
dhclient vpn_se

pid=$(ps -C vpnclient | head -2 | tail -1 | tr -s " "| cut -d" " -f 2)
# While is running...
while kill -0 $pid 2> /dev/null; do
    # Do stuff
    ping -c 1 $SERVER
    sleep 30
done

