docker network create project_net

# Keycloak
docker compose -f docker/keycloak/compose.yaml up -d --build

# Kong
docker compose -f docker/kong/compose.yaml up kong-database -d --build
sleep 10
docker compose -f docker/kong/compose.yaml up kong-gateway -d --build
sleep 10
docker compose -f docker/kong/compose.yaml up kong-deck -d --build

# RabbitMq
docker compose -f docker/rabbitmq/compose.yaml up -d --build
sleep 5

# proposal-management-api
docker compose -f proposal-management-api/compose.yaml up -d --build

# proposal-processor-api
docker compose -f proposal-processor-api/compose.yaml up -d --build

# proposal-user-agent-api
docker compose -f proposal-user-agent-api/compose.yaml up -d --build