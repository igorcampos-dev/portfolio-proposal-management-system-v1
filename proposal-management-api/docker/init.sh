
if [ -d "./docker/proposal-management-keycloak-v1" ]; then
  echo "keycloak ok"
else
  cd docker
  git clone https://github.com/igorcampos-dev/proposal-management-keycloak-v1
  cd ..
fi

if [ -d "./docker/proposal-management-rabbitmq-v1" ]; then
  echo "rabbitmq ok"
else
  cd docker
  git clone https://github.com/igorcampos-dev/proposal-management-rabbitmq-v1
  cd ..
fi

if [ -d "./docker/proposal-management-kong-v1" ]; then
  echo "rabbitmq ok"
else
  cd docker
  git clone https://github.com/igorcampos-dev/proposal-management-kong-v1
  cd ..
fi

docker compose up -d --build kong-database-dev
docker compose up -d --build kong-gateway-dev

sleep 5

docker compose up -d --build rabbitmq-dev
docker compose up -d --build database-dev

docker compose up -d --build keycloak-database-dev
docker compose up -d --build keycloak-dev

docker compose rm -f deck && docker compose up --force-recreate deck

rm -rf docker/proposal-management-rabbitmq-v1
rm -rf docker/proposal-management-keycloak-v1
rm -rf docker/proposal-management-kong-v1