cd proposal-management-api

sh docker/init.sh
docker compose up -d --build proposal-management-api-dev

cd ..

cd proposal-processor-api

docker compose up -d --build proposal-processor-api
