# Proposal Processor API

### Resumo

O **Proposal Processor API** é um projeto destinado ao tratamento e processamento de propostas. O sistema é responsável por consumir dados de propostas a partir de uma fila, processá-las, e definir seu status como "processada" ou "erro". Além disso, após o processamento, os dados são enviados para uma fila que lida com a geração de relatórios.

### Funcionalidades

- Consumo de dados de propostas via filas RabbitMQ.
- Processamento de propostas com validação e controle de status.
- Suporte a execução via **Docker Compose**.

### Pré-requisitos

- **Docker** e **Docker Compose** instalados.

### Como testar usando Docker

Para rodar o projeto completo usando o Docker, siga os passos abaixo:

```bash
docker compose up
```

### Como executar localmente

Se você deseja rodar o banco de dados e o RabbitMQ localmente, sem a aplicação principal, execute os seguintes comandos:

1. Para iniciar apenas o banco de dados:

    ```bash
    docker compose up database
    ```

2. Para iniciar o RabbitMQ:

    ```bash
    docker compose up rabbitmq
    ```

Com isso, o banco de dados e o RabbitMQ estarão rodando em seus respectivos containers e você poderá executar a aplicação em sua máquina localmente, se necessário.
