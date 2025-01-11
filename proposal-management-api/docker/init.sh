docker compose up -d --build kong-database-dev
docker compose up -d --build kong-gateway-dev

sleep 5

docker compose up -d --build rabbitmq-dev
docker compose up -d --build database-dev

docker compose up -d --build keycloak-database-dev
docker compose up -d --build keycloak-dev

docker compose rm -f deck && docker compose up --force-recreate deck