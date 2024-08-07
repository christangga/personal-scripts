# MongoDB
docker run \
    -d \
    --name some-mongo \
    --network some-network \
    -p 27017:27017 \
    -e MONGO_INITDB_ROOT_USERNAME=mongo \
    -e MONGO_INITDB_ROOT_PASSWORD=mongo \
    -v mongo_data:/data/db \
    mongo:6.0

# Zookeeper
docker run -d --name zookeeper -p 2181:2181 zookeeper

# Kafka Single Server
docker run \
    -d \
    --name some-kafka \
    -p 9092:9092 \
    --link zookeeper:zookeeper \
    confluentinc/cp-kafka:7.7.0

# Kafka Cluster
docker run \
    -d \
    --name kafka \
    -p 9092:9092 \
    --link zookeeper:zookeeper \
    -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
    -e KAFKA_BROKER_ID=1 \
    confluentinc/cp-kafka:7.7.0

# Kafka Producer
docker run \
    -it \
    --rm \
    --network kafka_default \
    confluentinc/cp-kafka:7.7.0 \
    /bin/kafka-console-producer \
    --bootstrap-server localhost:9092 \
    --topic 'xxx'

# SonarQube (port 9000 is used in Windows 11)
docker run \
    -d \
    --name sonarqube \
    -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
    -p 9090:9000 \
    sonarqube:9.9-community

# Redis Open Source
docker run \
    -d \
    --name some-redis \
    -p 6379:6379 \
    --network some-network \
    redis:7.4 \
    redis-server --save 60 1 \
    --loglevel warning

# redis-cli
docker run \
    -it \
    --rm \
    --network some-network \
    redis:7.4 \
    redis-cli \
    -h some-redis

# PostgreSQL
docker run \
    -d \
    --name some-postgres \
    -p 5432:5432 \
    --network some-network \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e POSTGRES_DB=postgres \
    -v postgres_data:/var/lib/postgresql/data \
    postgres:16.3

# psql
docker run \
    -it \
    --rm \
    --network some-network \
    postgres:16.3 \
    psql \
    -h some-postgres \
    -U postgres


# Notes:
# default mountpoint: /var/lib/docker/volumes/<volume_name>/_data
