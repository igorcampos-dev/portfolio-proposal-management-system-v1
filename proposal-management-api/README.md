# Proposal Management API

### Finalidade

Esse projeto trabalha a questão de **CRUD** (Criar, Ler, Atualizar, Deletar) de propostas. Para cada cadastro de propostas, o sistema envia as informações para uma fila de processamento, garantindo que todas as propostas sejam tratadas de forma eficiente e organizada.

### Como Executar

1. **Certifique-se de ter o Docker e o Docker Compose instalados.**

2. **Suba os serviços usando Docker Compose:**

   Para rodar o projeto completo:

   ```bash
   docker compose up
   ```

### Como Executar Localmente

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

