[![build](https://github.com/doudouchat/exemple-integration-docker/workflows/build/badge.svg)](https://github.com/doudouchat/exemple-integration-docker/actions)

# exemple-integration-docker

## Docker infrastructure

<ol>
<li>docker-compose up -d zookeeper</li>
<li>docker container exec exemple-zookeeper /usr/local/etc/zookeeper/load_authorization.sh</li>
<li>docker-compose up -d cassandra</li>
<li>docker container exec exemple-cassandra cqlsh --debug -f /usr/local/tmp/cassandra/service.cql</li>
<li>docker container exec exemple-cassandra cqlsh --debug -f /usr/local/tmp/cassandra/authorization.cql</li>
<li>docker container exec exemple-cassandra cqlsh --debug -f /usr/local/tmp/cassandra/exec.cql</li>
<li>docker container exec exemple-cassandra cqlsh --debug -f /usr/local/tmp/cassandra/test_service_schema.cql</li>
<li>docker-compose up -d hazelcast</li>
<li>docker-compose up -d kafka</li>
</ol>

## Docker authorization

<ol>
<li>docker-compose up -d authorization</li>
</ol>

## Docker service

<ol>
<li>docker-compose up -d service</li>
<li>dev: docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d service</li>
</ol>

## Docker gateway

<ol>
<li>docker-compose up -d gateway</li>
<li>browser: docker-compose -f docker-compose.yml -f docker-compose.browser.yml up -d gateway</li>
</ol>
