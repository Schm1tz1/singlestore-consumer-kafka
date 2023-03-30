# Singlestore Consumer Kafka
This repo is based on the initial work from Vincent de Saboulin (vdesabou) in https://github.com/vdesabou/kafka-docker-playground/tree/master/connect/connect-singlestore-sink
It is intended to be used with Confluent Cloud (SASL_SSL) but you can connect to any Kafka cluster with a few modifications and assumes you are having data in a topic **test** in AVRO format that has the schema matching testdata produced by the users module of the Datagen connector. 

## How to use
- Create a file `.env` with the following variables:
  - CC_BOOTSTRAP: Confluent Cloud / Kafka Bootstrap Servers
  - CC_API_KEY: Confluent Cloud API Key / SASL_SSL Username
  - CC_API_SECRET: Confluent Cloud API Secret / SASL_SSL Password
  - SR_BOOTSTRAP: Schema Registry URL (including protocol, e.g. https://schemaregistry:8081)
  - SR_API_KEY: Schema Registry API Key / SR BASIC Username
  - SR_API_SECRET: Schema Registry API Secret / SR BASIC Password
- Start a datagen connector in your cluster, target topic **test**, AVRO format, **users** testdata !
- Wait for the connector to be up and running
- Start and run the automated test!
