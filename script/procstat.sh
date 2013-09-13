#!/bin/bash

NumTcpExt=`cat /proc/net/netstat | awk '/TcpExt:/{if (NR%2) print NF}'`
NumIpExt=`cat /proc/net/netstat | awk '/IpExt:/{if (NR%2) print NF}'`
#echo $NumTcpExt
for (( i = 2; i <= $NumTcpExt ; i++ ))
  do
     cat /proc/net/netstat | awk '/TcpExt:/{print $'$i'}' | awk 'NR%2{printf $0"=";next;}1'
done

#echo $NumIpExt
for (( i = 2; i <= $NumIpExt ; i++ ))
  do
     cat /proc/net/netstat | awk '/IpExt:/{print $'$i'}' | awk 'NR%2{printf $0"=";next;}1'
done

echo QDiscBacklogBytes=`tc -s qdisc ls dev eth0 | awk 'NR==3{print $5}' | sed 's/b$//'`
echo QDiscBacklogPackets=`tc -s qdisc ls dev eth0 | awk 'NR==3{print $6}' | sed 's/p$//'`
echo QDiscRequeues=`tc -s qdisc ls dev eth0 | awk 'NR==3{print $8}'`
echo QDiscDropped=`tc -s qdisc ls dev eth0 | awk 'NR==2{print $7}' | sed 's/,$//'`
echo QDiscOverlimits=`tc -s qdisc ls dev eth0 | awk 'NR==2{print $9}'`
