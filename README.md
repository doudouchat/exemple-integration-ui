[![build](https://github.com/doudouchat/exemple-integration-docker/workflows/build/badge.svg)](https://github.com/doudouchat/exemple-integration-docker/actions)

# exemple-docker

<ol>
<li>docker build -t exemple-test .</li>
</ol>

<ol>
<li>docker-compose up -d zookeeper</li>
<li>docker container exec exemple-zookeeper /usr/local/etc/zookeeper/load_authorization.sh</li>
<li>docker-compose up -d cassandra</li>
<li>docker container exec exemple-test cqlsh --debug -f /usr/local/tmp/cassandra/schema.cql</li>
<li>docker container exec exemple-test cqlsh --debug -f /usr/local/tmp/cassandra/exec.cql</li>
<li>docker-compose up -d hazelcast</li>
</ol>
