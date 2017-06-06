#!/bin/bash

# Check if consul can be found via $PATH
if [ ! $(which consul) ]; then
	echo Consul is not in your \$PATH. Please install or compile it and add it to your \$PATH.
	exit 1;
fi

ipaddress=127.0.0.1
if [ "$(uname)" == "Darwin" ]; then
	ipaddress=$( ifconfig | grep 'RUNNING' -A2 | grep 'inet ' | head -n2 | tail -n1 | cut -d: -f2 | awk '{print $2}' )
elif ["$(uname)" == "Linux" ]; then
	echo Not supported yet
fi

# Start the first consul instance
# This one will have all the ports open but starting at 18300 to avoid superuser to run
( consul agent -dev -ui -node node_1 -bind $ipaddress -server -raft-protocol 3 -config-file=conf/consul_1.json ) &
# Start the second consul instance
# Only server and serf_lan offset by 10k from instance 1
( sleep 2; consul agent -dev -disable-host-node-id -node node_2 -server -join $ipaddress:18301 -config-file=conf/consul_2.json ) &
# Start the third consul instance
# Only server and serf_lan offset by 20k from instance 1
( sleep 3; consul agent -dev -disable-host-node-id -node node_3 -server -join $ipaddress:18301 -config-file=conf/consul_3.json ) &

echo We forked, so run the kill script with sudo...
echo You can browse to localhost:8500 to see the web-ui.
