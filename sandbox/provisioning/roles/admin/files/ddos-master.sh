#!/bin/bash

MYARG=$1

if [ $MYARG = "ping-test" ]
then
	ssh vagrant@10.10.20.10 ping -c 20 10.10.10.10
elif [ $MYARG = "w3m-test" ]
then
	ssh vagrant@10.10.20.10 w3m 10.10.10.10
else
	ssh botmaster@10.10.30.10 /home/botmaster/bot-controller.sh $MYARG &
fi