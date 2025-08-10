## Plan

Inicia o modo de planejamento pré-implementação para estabelecer estratégias detalhadas de implementação. Apoia desenvolvimento eficiente através do estabelecimento de planos estruturados antes da implementação do código.

### Uso

```bash
# Solicitar Plan Mode ao Claude
"Faça um plano de implementação para [conteúdo da implementação]"
```

### Exemplos Básicos

```bash
# Plano de implementação de nova funcionalidade
"Faça um plano de implementação para funcionalidade de autenticação de usuário"

# Plano de design de sistema
"Faça um plano de implementação para divisão em microsserviços"

# Plano de refatoração
"Faça um plano de refatoração do código legado"
```

### Integração com Claude

```bash
# Implementação de funcionalidade complexa
"Faça um plano de implementação para funcionalidade de chat. Incluindo WebSocket, notificações em tempo real e gestão de histórico"

# Design de banco de dados
"Faça um plano de design de banco de dados para site de e-commerce. Incluindo gestão de produtos, pedidos e usuários"

# Design de API
"Faça um plano de implementação de API GraphQL. Incluindo autenticação, cache e limitação de taxa"

# Design de infraestrutura
"Faça um plano de implementação de dockerização. Incluindo ambiente de desenvolvimento, ambiente de produção e CI/CD"
```

### Características do Plan Mode

**Inicialização Automática**

- Plan Mode inicia automaticamente ao detectar tarefas de implementação
- Pode ser iniciado explicitamente com palavras-chave como "faça plano de implementação"

**Especificação Estruturada**

- Definição de requisitos (User Stories e critérios de aceitação)
- Documentos de design (arquitetura, design de dados, design de UI)
- Plano de implementação (decomposição de tarefas, acompanhamento de progresso, garantia de qualidade)
- Análise e contramedidas de riscos

**Processo de Aprovação**

- Apresentação do plano com ferramenta `exit_plan_mode`
- **Importante**: Sempre aguardar aprovação explícita do usuário, independentemente do valor de retorno da ferramenta
- É proibido iniciar implementação sem aprovação
- É possível corrigir e ajustar o plano
- Iniciar gestão de tarefas com TodoWrite apenas após aprovação

### Exemplos Detalhados

```bash
# Implementação de sistema complexo
"Faça um plano de implementação de sistema de pagamento online. Incluindo integração com Stripe, segurança e tratamento de erros"

# Implementação de frontend
"Faça um plano de implementação de dashboard React. Incluindo gestão de estado, design de componentes e testes"

# Implementação de backend
"Faça um plano de implementação de RESTful API. Incluindo autenticação, validação e registro de logs"

# Implementação DevOps
"Faça um plano de implementação de pipeline CI/CD. Incluindo automação de testes, deployment e monitoramento"
```

### Workflow de 3 Fases

#### Fase 1: Requirements (Definição de Requisitos)

- **User Stories**: Clarificar propósito e valor das funcionalidades
- **Critérios de Aceitação**: Definir condições de conclusão e padrões de qualidade
- **Restrições e Pré-condições**: Organizar restrições técnicas e temporais
- **Priorização**: Classificação em Must-have/Nice-to-have

#### Fase 2: Design

- **Design de Arquitetura**: Configuração do sistema e seleção de tecnologias
- **Design de Dados**: Schema, especificações de API, fluxo de dados
- **Design de UI/UX**: Configuração de telas e fluxo de operações
- **Análise de Riscos**: Problemas potenciais e contramedidas

#### Fase 3: Implementation (Implementação)

- **Decomposição de Tarefas**: Subdivisão em unidades implementáveis
- **Acompanhamento de Progresso**: Gestão de estado através de TodoWrite
- **Garantia de Qualidade**: Estratégia de testes e métodos de verificação
- **Processo de Aprovação**: Apresentação do plano com exit_plan_mode e espera por aprovação explícita

### Observações

**Escopo de Aplicação**

- Plan Mode é otimizado para tarefas complexas de implementação
- Para correções simples ou mudanças de pequena escala, usar formato de implementação normal
- Recomendado para trabalhos de 3 passos ou mais, ou desenvolvimento de novas funcionalidades

**Restrições Técnicas**

- Não confiar no valor de retorno da ferramenta `exit_plan_mode`
- Julgamento do processo de aprovação pela manifestação explícita da vontade do usuário
- Funcionalidade diferente do plan mode da CLI

**Atenção na Execução**

- Rigorosamente proibido iniciar implementação antes da aprovação
- Sempre aguardar resposta do usuário após apresentação do plano
- Apresentar meios alternativos em caso de erro

### Exemplo de Execução

```bash
# Exemplo de uso
"Faça um plano de implementação do sistema de gestão de usuários"

# Comportamento esperado
# 1. Plan Mode inicia automaticamente
# 2. Análise de requisitos e seleção de tecnologia
# 3. Estruturação dos passos de implementação
# 4. Apresentação do plano com exit_plan_mode
# 5. Iniciar implementação após aprovação
```
