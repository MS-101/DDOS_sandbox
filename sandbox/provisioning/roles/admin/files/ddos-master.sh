#!/bin/bash

MYARG=$1

if [ $MYARG = "ping-test-ip" ]
then
	ssh vagrant@10.10.20.10 ping -c 20 10.10.10.10
elif [ $MYARG = "ping-test-domain" ]
then
	ssh vagrant@10.10.20.10 ping -c 20 ddos.com
elif [ $MYARG = "w3m-test-ip" ]
then
	ssh vagrant@10.10.20.10 w3m 10.10.10.10
elif [ $MYARG = "w3m-test-domain" ]
then
	ssh vagrant@10.10.20.10 w3m ddos.com
else
	ssh botmaster@10.10.30.10 /home/botmaster/bot-controller.sh $MYARG &
fi