# Explicação de Negócio Sobre o Projeto

## Visão Geral

Este projeto tem como objetivo receber, validar e processar **Contratos de Prestação de Serviços** enviados por empresas ou sistemas clientes. A arquitetura é composta por três microserviços com responsabilidades bem definidas, criando um fluxo organizado desde o envio da proposta até sua aprovação ou rejeição.

## Exemplo de Contrato Processado

```json
{
  "contractId": "CTR-2025-00421",
  "clientName": "AlphaTech Solutions",
  "clientType": "PJ",
  "serviceType": "Software Development",
  "contractValue": 150000,
  "durationMonths": 12,
  "paymentModel": "MONTHLY",
  "riskCategory": "MEDIUM",
  "requiresOnSite": false,
  "slaHours": 48
}
```

## Escopo do Projeto

### 1. proposal-management-api

Responsável por:

* Receber propostas de contrato.
* Registrar as propostas de contrato no banco de dados.
* Enviar os campos principais dessas propostas para o microserviço **proposal-processor-api** através de um tópico rabbitMq.

### 2. proposal-processor-api

Responsável por:

* Receber os dados de cada proposta de contrato via tópico.
* Regras resumidas aplicadas:
    * Verificação de valor mínimo por tipo de serviço.
    * Limite de SLA para contratos de alto risco.
    * Duração mínima para contratos que exigem atuação on-site.
    * Contratos acima de 100k devem ser apenas para clientes PJ.
    * Pagamento mensal exige duração mínima de 3 meses.
* Classificar a proposta como:
    **Aprovada**,
    **Rejeitada**
    **Necessitando de Aprovação Manual**.

### 3. proposal-user-agent-api

Responsável por:

* Simular clientes enviando propostas de contrato para o microserviço **proposal-management-api**.
* Gerar dados randômicos para iniciar o fluxo completo de processamento dos contratos.

---

## **Visão de Arquitetura**

<img src="documents/architecture-proposal.drawio.svg" alt="Visão de Arquitetura" width="1000" />

---

## Tecnologias Utilizadas

* **Java**
* **RabbitMQ**
* **Keycloak**
* **Kong Gateway**
* **Spring**
* **Microserviços**
* **PostgreSQL** (banco de dados)
* **DataFaker** (geração de dados fake)

## **Como Executar o Projeto**

1. Certifique-se de que o Docker está instalados na sua máquina.
2. Execute isso no diretório principal:
   ```bash
   sh docker/init.sh
   ```
