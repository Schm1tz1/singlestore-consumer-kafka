#!/bin/bash
set -e

singlestore-wait-start() {
  echo -n "Waiting for SingleStore to start..."
  while true; do
      if docker exec singlestore memsql -u root -proot -e "select 1" >/dev/null 2>/dev/null; then
          break
      fi
      sleep 1
  done
  echo "Ok!"
}

echo -n "Starting singlestore instance..."
docker-compose up -d
singlestore-wait-start

echo "Wait for 5 seconds..."
sleep 5

echo "Create Kafka pipeline..."
source .env
echo -e "$(eval "echo -e \"`<pipeline.sql.template`\"")" | docker exec -i singlestore memsql -u root -proot

echo "Test pipeline..."
docker exec singlestore memsql -u root -proot -e "USE test; TEST PIPELINE test_kafka LIMIT 1;"

echo "Start pipeline and wait 5 seconds..."
docker exec singlestore memsql -u root -proot -e "USE test; START PIPELINE test_kafka FOREGROUND LIMIT 1 BATCHES;"

sleep 5

echo "Query table and show 20 newest results..."
docker exec -i singlestore memsql -u root -proot -e "use test; select * from test order by registertime desc limit 20;"
