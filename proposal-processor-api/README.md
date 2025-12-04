# Proposal Processor API

### Resumo

O **Proposal Processor API** é um projeto destinado ao tratamento e processamento de propostas. O sistema é responsável por consumir dados de propostas a partir de uma fila, processá-las, e definir seu status como "processada" ou "erro". Além disso, após o processamento, os dados são enviados para uma fila que lida com a geração de relatórios.

### Funcionalidades

- Consumo de dados de propostas via filas RabbitMQ.
- Processamento de propostas com validação e controle de status.
- Suporte a execução via **Docker Compose**.

### Como Executar

1. **Na raiz principal do repositório, execute:**

   ```bash
   sh docker/init.sh
   ```