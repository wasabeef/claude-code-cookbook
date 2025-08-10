## Analisar Performance

Analisa problemas de performance da aplicação e propõe melhorias do ponto de vista da dívida técnica.

### Uso

```bash
# Análise abrangente de problemas de performance
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Identifique arquivos grandes e problemas de performance e apresente propostas de melhoria"

# Detecção de padrões de código ineficientes
grep -r "for.*await\|forEach.*await" . --include="*.js"
"Analise problemas N+1 query e gargalos de performance"

# Possibilidade de vazamento de memória
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
"Avalie riscos de vazamento de memória e contramedidas"
```

### Exemplos Básicos

```bash
# Tamanho do bundle e tempo de carregamento
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"Identifique pontos de melhoria no tamanho do bundle e otimização de assets"

# Performance do banco de dados
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"Analise pontos de otimização de consultas de banco de dados"

# Impacto das dependências na performance
npm outdated && npm audit
"Avalie o impacto de dependências antigas na performance"
```

### Perspectivas de Análise

#### 1. Problemas no Nível do Código

- **Algoritmos O(n²)**: Detecção de operações de array ineficientes
- **I/O síncrono**: Identificação de processamento bloqueante
- **Processamento duplicado**: Remoção de cálculos e requisições desnecessárias
- **Vazamento de memória**: Gestão de event listeners e timers

#### 2. Problemas no Nível da Arquitetura

- **N+1 queries**: Padrões de acesso ao banco de dados
- **Falta de cache**: Cálculos repetidos ou chamadas de API
- **Tamanho do bundle**: Bibliotecas desnecessárias ou divisão de código
- **Gestão de recursos**: Pool de conexões e uso de threads

#### 3. Impacto da Dívida Técnica

- **Código legado**: Degradação de performance devido a implementações antigas
- **Problemas de design**: Alto acoplamento devido à falta de distribuição de responsabilidades
- **Falta de testes**: Falha na detecção de regressões de performance
- **Falta de monitoramento**: Sistema de detecção precoce de problemas

### Prioridade de Melhoria

```
🔴 Crítico: Risco de falha do sistema
├─ Vazamento de memória (crash do servidor)
├─ N+1 queries (carga no banco de dados)
└─ I/O síncrono (atraso na resposta)

🟡 Alto: Impacto na experiência do usuário
├─ Tamanho do bundle (tempo de carregamento inicial)
├─ Otimização de imagens (velocidade de exibição)
└─ Estratégia de cache (velocidade de resposta)

🟢 Médio: Eficiência operacional
├─ Atualização de dependências (segurança)
├─ Duplicação de código (manutenibilidade)
└─ Fortalecimento do monitoramento (carga operacional)
```

### Medição e Ferramentas

#### Node.js / JavaScript

```bash
# Profiling
node --prof app.js
clinic doctor -- node app.js

# Análise de bundle
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### Banco de Dados

```sql
-- Análise de queries
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```

#### Frontend

```bash
# Performance React
grep -r "useMemo\|useCallback" . --include="*.jsx"

# Análise de recursos
find ./src -name "*.png" -o -name "*.jpg" | xargs ls -lh
```

### Melhoria Contínua

- **Auditoria regular**: Execução semanal de testes de performance
- **Coleta de métricas**: Acompanhamento de tempo de resposta e uso de memória
- **Configuração de alertas**: Notificação automática ao ultrapassar limites
- **Compartilhamento com a equipe**: Documentação de casos de melhoria e antipadrões
