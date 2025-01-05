
if [ -d "./docker/proposal-management-rabbitmq-v1" ]; then
  echo "rabbitmq ok"
else
  cd docker
  git clone https://github.com/igorcampos-dev/proposal-management-rabbitmq-v1
  cd ..
fi

docker compose up -d --build rabbitmq-dev

rm -rf docker/proposal-management-rabbitmq-v1