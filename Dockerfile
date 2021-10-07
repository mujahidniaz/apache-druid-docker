FROM openjdk:8

ENV DRUID_VERSION 0.21.1
ENV ZOOKEEPER_VERSION 3.4.14

# Get Druid
RUN mkdir -p /tmp \
    && cd /tmp/ \
    && curl -fsLS "https://mirror.softaculous.com/apache/druid/0.21.1/apache-druid-0.21.1-bin.tar.gz" | tar xvz \
    && mv apache-druid-$DRUID_VERSION /opt/druid

WORKDIR /opt/druid/

# Zookeeper
#RUN curl -fsLS "https://www.apache.org/dyn/closer.cgi?filename=/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz&action=download" | tar xvz \
#    && mv zookeeper-$ZOOKEEPER_VERSION zk

ADD config/common.runtime.properties conf/druid/single-server/micro-quickstart/_common/common.runtime.properties
RUN sed -i 's/!p10 zk bin\/run-zk conf/  /g' ./conf/supervise/single-server/micro-quickstart.conf
RUN bash -c "./bin/start-micro-quickstart &"
ENV DRUID_SKIP_PORT_CHECK 1
# Expose ports:
# - 8888: HTTP (router)
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 8090: HTTP (overlord)
# - 2181 2888 3888: ZooKeeper
EXPOSE 8888
EXPOSE 8081
EXPOSE 8082
EXPOSE 8083
EXPOSE 8090
EXPOSE 2181 2888 3888

ENTRYPOINT ./bin/start-micro-quickstart
