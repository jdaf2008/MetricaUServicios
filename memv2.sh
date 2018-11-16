#!/bin/bash
USEDMEMORY=$(free -m | awk 'NR==2{printf "%.2f\t", $3*100/$2 }')
TCP_CONN=$(netstat -an | wc -l)
TCP_CONN_PORT_80=$(netstat -an | grep 80 | wc -l)
TCP_CONN_PORT_20000=$(netstat -an | grep 20000 | wc -l)
INSTANCE_ID  = $(echo '$INSTANCEID')
 
aws cloudwatch put-metric-data --metric-name memory-usage --dimensions Instance=$INSTANCE_ID  --namespace Maestria --value $USEDMEMORY
aws cloudwatch put-metric-data --metric-name Tcp_connections --dimensions Instance=$INSTANCE_ID  --namespace Maestria --value $TCP_CONN
aws cloudwatch put-metric-data --metric-name TCP_connection_on_port_80 --dimensions Instance=$INSTANCE_ID  --namespace Maestria --value $TCP_CONN_PORT_80
aws cloudwatch put-metric-data --metric-name TCP_connection_on_port_20000 --dimensions Instance=$INSTANCE_ID  --namespace Maestria --value $TCP_CONN_PORT_20000 