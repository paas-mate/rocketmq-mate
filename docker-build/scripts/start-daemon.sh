#!/bin/bash

mkdir -p $ROCKETMQ_HOME/logs

sed -i 's#\${user.home}/logs/rocketmqlogs#/opt/rocketmq/logs#g' $ROCKETMQ_HOME/conf/logback*.xml

NAMESRV_ADDR=${ROCKETMQ_NAMESRV_ADDR}

if [ -z "${REDIS_HOST}" ]
then
    NAMESRV_ADDR="localhost:9876"
elif [ -z "${NAMESRV_INTRERFACE}" ]; then
    NAMESRV_ADDR=$(ip addr show ${NAMESRV_INTRERFACE} | grep inet | grep -v inet6 | grep '/24' | awk '{print $2}' | awk -F '/' '{print $1}')
fi

if [ "$CLUSTER_ROLE" == "NAMESRV" ]; then
  ${$ROCKETMQ_HOME}/bin/mqnamesrv &
elif [ "$CLUSTER_ROLE" == "MQBROKER" ]; then
  ${ROCKETMQ_HOME}/bin/mqbroker -n $NAMESRV_ADDR &
else
  ${ROCKETMQ_HOME}/bin/mqnamesrv &
  sleep 15s
  ${ROCKETMQ_HOME}/bin/mqbroker -n $NAMESRV_ADDR &
fi
