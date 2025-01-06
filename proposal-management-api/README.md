# Proposal Management API

### Finalidade

Esse projeto trabalha a manipulação de propostas. Para cada cadastro de propostas, o sistema envia as informações para uma fila de processamento, garantindo que todas as propostas sejam tratadas de forma eficiente e organizada.

### Como Executar

1. **Certifique-se de ter o Docker e o Docker Compose instalados.**

2. **Suba os serviços usando Docker Compose:**

   Para rodar o projeto completo:

   ```bash
   sh ./docker/init.sh
   ```
3. **Execute finalmente:**

   ```bash
   docker compose up proposal-management-api
   ```

### Como Executar Localmente

1. **Para executar local, use:**

    ```bash
    sh ./docker/init.sh
    ```

2. **Finalmente, execute o projeto na sua IDE preferida.**
