## Task

Inicia um agente especializado para executar autonomamente tarefas complexas de pesquisa, investigação e análise. Processamento de informações em larga escala combinando múltiplas ferramentas, priorizando eficiência contextual.

### Como usar

```bash
# Solicitar Task ao Claude
"Investigue [problema] usando Task"
```

### Características do Task

**Execução Autônoma**

- Execução automática combinando múltiplas ferramentas
- Coleta e análise de informações em etapas
- Integração de resultados e relatórios estruturados

**Processamento Eficiente de Informações**

- Otimização do consumo de contexto
- Busca e análise de arquivos em larga escala
- Coleta de dados de fontes externas

**Garantia de Qualidade**

- Verificação da confiabilidade das fontes de informação
- Validação de múltiplas perspectivas
- Complementação automática de informações ausentes

### Exemplos Básicos

```bash
# Investigação de codebase complexo
"Investigue em quais arquivos esta funcionalidade está implementada usando Task"

# Busca em larga escala de arquivos
"Identifique inconsistências nos arquivos de configuração usando Task"

# Coleta de informações externas
"Investigue as tendências mais recentes de tecnologia IA usando Task"
```

### Integração com Claude

```bash
# Análise de problemas complexos
"Analise a causa do vazamento de memória usando Task. Inclua resultados de profiling e logs"

# Investigação de dependências
"Investigue vulnerabilidades neste pacote npm usando Task"

# Análise competitiva
"Investigue as especificações da API de serviços concorrentes usando Task"

# Análise de arquitetura
"Analise as dependências deste microsserviço usando Task"
```

### Diferenciação de Outros Comandos

#### Task vs Outros Comandos

| Comando             | Uso Principal                         | Método de Execução     | Coleta de Informações              |
| ------------------- | ------------------------------------- | ---------------------- | ---------------------------------- |
| **Task**            | Investigação, Análise e Busca         | Execução autônoma      | Múltiplas fontes                   |
| ultrathink          | Pensamento e Julgamento profundo      | Pensamento estruturado | Centrado em conhecimento existente |
| sequential-thinking | Resolução de problemas e Design       | Pensamento por etapas  | Conforme necessário                |
| plan                | Elaboração de planos de implementação | Processo de aprovação  | Análise de requisitos              |

#### Fluxograma de Decisão

```text
Coleta de informações necessária?
├─ Sim → Múltiplas fontes / Larga escala?
│          ├─ Sim → **Task**
│          └─ Não → Pergunta normal
└─ Não → Pensamento profundo necessário?
          ├─ Sim → ultrathink/sequential-thinking
          └─ Não → Pergunta normal
```

### Casos Efetivos e Casos Desnecessários

**Casos Efetivos**

- Investigação de codebase complexo (dependências, análise de arquitetura)
- Busca de arquivos em larga escala (padrões de implementação específicos, arquivos de configuração)
- Coleta e organização de informações externas (tendências tecnológicas, investigação de bibliotecas)
- Integração de informações de múltiplas fontes (análise de logs, análise de métricas)
- Trabalho de investigação iterativo (auditoria de segurança, investigação de débito técnico)
- Análise em larga escala evitando consumo de contexto

**Casos Desnecessários**

- Perguntas simples ou conteúdo que pode ser respondido com conhecimento existente
- Trabalho pontual que se completa em pouco tempo
- Trabalho que requer confirmação ou consulta interativa
- Julgamento de implementação ou design (apropriado usar plan ou comandos de pensamento)

### Exemplos Detalhados por Categoria

#### Análise e Investigação de Sistema

```bash
# Análise complexa de sistema
"Identifique gargalos do site de e-commerce usando Task. Investigue todo o conjunto: banco de dados, API, frontend"

# Análise de arquitetura
"Analise as dependências deste microsserviço usando Task. Inclua comunicação API e fluxo de dados"

# Investigação de débito técnico
"Analise o débito técnico do código legado usando Task. Inclua prioridade de refatoração"
```

#### Segurança e Conformidade

```bash
# Auditoria de segurança
"Investigue vulnerabilidades desta aplicação usando Task. Base no OWASP Top 10"

# Investigação de licenças
"Investigue problemas de licença das dependências do projeto usando Task"

# Auditoria de arquivos de configuração
"Identifique inconsistências nas configurações de segurança usando Task. Inclua diferenças entre ambientes"
```

#### Performance e Otimização

```bash
# Análise de performance
"Identifique queries pesadas da aplicação usando Task. Inclua plano de execução e propostas de otimização"

# Investigação de uso de recursos
"Investigue a causa do vazamento de memória usando Task. Inclua resultados de profiling e análise de código"

# Análise de tamanho de bundle
"Investigue problemas de tamanho de bundle do frontend usando Task. Inclua propostas de otimização"
```

#### Coleta de Informações Externas

```bash
# Investigação de tendências tecnológicas
"Investigue as tendências de frameworks JavaScript de 2024 usando Task"

# Análise competitiva
"Investigue especificações da API de serviços concorrentes usando Task. Inclua tabela de comparação de funcionalidades"

# Avaliação de bibliotecas
"Compare bibliotecas de gerenciamento de estado usando Task. Inclua performance e custo de aprendizado"
```

### Fluxo de Execução e Garantia de Qualidade

#### Fluxo de Execução do Task

```text
1. Análise inicial
   ├─ Decomposição do problema e identificação do escopo da investigação
   ├─ Seleção de ferramentas e fontes de informação necessárias
   └─ Elaboração do plano de execução

2. Coleta de informações
   ├─ Busca de arquivos e Análise de código
   ├─ Coleta de informações externas
   └─ Estruturação de dados

3. Análise e Integração
   ├─ Análise de correlação das informações coletadas
   ├─ Identificação de padrões e pontos problemáticos
   └─ Verificação de hipóteses

4. Relatório e Propostas
   ├─ Estruturação de resultados
   ├─ Criação de propostas de melhoria
   └─ Apresentação das próximas ações
```

#### Garantia de Qualidade

- **Verificação de Confiabilidade das Fontes**: Verificação de fatos com múltiplas fontes
- **Confirmação de Abrangência**: Verificação se não há lacunas no objeto de investigação
- **Verificação de Consistência**: Confirmação de consistência de informações contraditórias
- **Avaliação de Praticidade**: Avaliação da viabilidade e efetividade das propostas

### Tratamento de Erros e Restrições

#### Restrições Comuns

- **Limitações de uso de API externa**: Limitações de taxa ou erros de autenticação
- **Limitações de processamento de arquivos de grande capacidade**: Restrições de memória ou timeout
- **Problemas de permissão de acesso**: Restrições de acesso a arquivos ou diretórios

#### Tratamento em Caso de Erro

- **Relatório de resultados parciais**: Análise apenas com informações que puderam ser obtidas
- **Proposta de métodos alternativos**: Métodos de investigação alternativos sob restrições
- **Execução em etapas**: Execução dividida de tarefas de larga escala

### Observações

- Task é ideal para tarefas de investigação e análise complexas e autônomas
- Para perguntas simples ou quando respostas imediatas são necessárias, use o formato de pergunta normal
- Trate os resultados da investigação como informações de referência e sempre verifique julgamentos importantes
- Ao coletar informações externas, preste atenção à atualidade e precisão das informações

### Exemplo de Execução

```bash
# Exemplo de uso
"Investigue problemas do esquema GraphQL usando Task"

# Comportamento esperado
# 1. Agente especializado é iniciado
# 2. Busca de arquivos relacionados ao GraphQL
# 3. Análise de definições de esquema
# 4. Comparação com melhores práticas
# 5. Identificação de problemas e propostas de melhoria
# 6. Criação de relatório estruturado
```
