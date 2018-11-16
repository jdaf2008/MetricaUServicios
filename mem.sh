#!/bin/bash
USEDMEMORY=$(free -m | awk 'NR==2{printf "%.2f\t", $3*100/$2 }')
TCP_CONN=$(netstat -an | wc -l)
TCP_CONN_PORT_80=$(netstat -an | grep 80 | wc -l)
TCP_CONN_PORT_20000=$(netstat -an | grep 20000 | wc -l)
USERS=$(uptime |awk '{ print $6 }')
IO_WAIT=$(iostat | awk 'NR==4 {print $5}')
INSTANCE_ID  = $(echo '$INSTANCEID')
 
aws cloudwatch put-metric-data --metric-name memory-usage --dimensions Instance=$INSTANCE_ID  --namespace "Custom" --value $USEDMEMORY
aws cloudwatch put-metric-data --metric-name Tcp_connections --dimensions Instance=$INSTANCE_ID  --namespace "Custom" --value $TCP_CONN
aws cloudwatch put-metric-data --metric-name TCP_connection_on_port_80 --dimensions Instance=$INSTANCE_ID  --namespace "Custom" --value $TCP_CONN_PORT_80
aws cloudwatch put-metric-data --metric-name TCP_connection_on_port_20000 --dimensions Instance=$INSTANCE_ID  --namespace "Custom" --value $TCP_CONN_PORT_20000
aws cloudwatch put-metric-data --metric-name No_of_users --dimensions Instance=$INSTANCE_ID  --namespace "Custom" --value $USERS
aws cloudwatch put-metric-data --metric-name IO_WAIT --dimensions Instance=$INSTANCE_ID  --namespace "Custom" --value $IO_WAITaws 