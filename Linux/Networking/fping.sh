#!/bin/sh
FILENAME="ips.txt"
LINES=$(cat $FILENAME)

for LINE in $LINES
	do fping -g -a "$LINE"
done
