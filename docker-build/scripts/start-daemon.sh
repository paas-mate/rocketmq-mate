#!/bin/bash

mkdir -p $ROCKETMQ_HOME/logs

if [ "$CLUSTER_ROLE" == "NAMESRV" ]; then
        ${$ROCKETMQ_HOME}/bin/mqnamesrv &
elif [ "$CLUSTER_ROLE" == "MQBROKER" ]; then
        ${ROCKETMQ_HOME}/bin/mqbroker -n ${BROKER_ADDR:="localhost:9876"} &
else
        ${ROCKETMQ_HOME}/bin/mqnamesrv &
        sleep 15s 
        ${ROCKETMQ_HOME}/bin/mqbroker/mqbroker -n ${BROKER_ADDR:="localhost:9876"} &
fi
