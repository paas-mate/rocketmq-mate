FROM ttbb/rocketmq:nake

COPY docker-build /opt/rocketmq/mate

WORKDIR /opt/rocketmq

CMD ["/usr/bin/dumb-init", "bash", "-vx","/opt/rocketmq/mate/scripts/start.sh"]
