# Proposal User Agent Api
   
### Resumo

O **Proposal User Agent Api** é um projeto destinado a simular a interação de um usuário com o fluxo geral do sistema de processamento de propostas. O agente atua como um cliente que envia requests de criação de propostas para o Kong, o qual redireciona esses requests para o ecossistema (filas e serviços). Serve para testar e validar o fluxo de ponta a ponta: envio, consumo, processamento e geração de relatórios, além de permitir simulações de diferentes cenários de cliente (payloads, retries, tempos de espera).

### Funcionalidades

- Envio de requests de criação de proposta via Kong, simulando um cliente da API.
- Simulação de comportamento de usuário (retries, variação de payloads, tempos de espera).

### Como Executar

1. **Na raiz principal do repositório, execute:**

```bash
sh docker/init.sh
```
 