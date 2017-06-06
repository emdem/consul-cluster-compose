#!/bin/bash

for pid in $( ps -ef | grep consul | grep dev | awk '{print $2}' ); do
	kill -9 $pid
done
