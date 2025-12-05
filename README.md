# **Portfolio Proposal Management System v1**

## **Visão Geral**

Este projeto demonstra conhecimentos em diversas ferramentas e tecnologias, incluindo:  
**Java**, **RabbitMQ**, **Keycloak**, **Kong Gateway**, **Spring**, e **Microserviços**.

---

## **Sobre o Projeto**

O sistema consiste em dois microserviços que se comunicam utilizando o conceito de filas e mensageria:

- **`proposal-management-api`**  
  Responsável por receber propostas, cadastrá-las no banco de dados e enviar dados ao microserviço `proposal-processor-api` para processamento.

- **`proposal-processor-api`**  
  Processa as propostas recebidas da fila, seguindo regras definidas. Após o processamento, envia os resultados de volta para a fila. O microserviço `proposal-management-api` consome esses resultados e atualiza os dados no banco.

- **`proposal-user-agent-api`**
  Simula a interação de um usuário com o fluxo geral do sistema de processamento de propostas, envia mensagens pro Kong, que faz o redirecionamento para o projeto: `proposal-management-api`.

---

## **Visão de Arquitetura**

<img src="documents/architecture-proposal.drawio.svg" alt="Visão de Arquitetura" width="1000" />

---

## **Tecnologias Utilizadas**

- **Java 21+**
- **Spring Boot**
- **RabbitMQ**
- **Keycloak** (autenticação e autorização)
- **Kong Gateway** (API Gateway)
- **Docker** (containers para orquestração)
- **PostgreSQL** (banco de dados)
- **DataFaker**

---

## **Como Executar o Projeto**

1. Certifique-se de que o Docker e o Docker Compose estão instalados na sua máquina.
2. Execute isso no diretório principal:
   ```bash
   sh docker/init.sh
   ```
