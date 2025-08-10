## PR Feedback

Responde eficientemente aos comentários de review de Pull Request e busca resolução fundamental através da abordagem de 3 etapas para análise de erros.

### Uso

```bash
# Obtenção e análise de comentários de review
gh pr view --comments
"Classifique os comentários de review por prioridade e crie um plano de resposta"

# Análise detalhada de comentários relacionados a erros
gh pr checks
"Analise erros de CI com abordagem de 3 etapas e identifique a causa raiz"

# Verificação de qualidade após conclusão da correção
npm test && npm run lint
"A correção foi concluída, então verifique testes de regressão e qualidade do código"
```

### Exemplos Básicos

```bash
# Execução de classificação de comentários
gh pr view 123 --comments | head -20
"Classifique os comentários de review em must/imo/nits/q e determine a ordem de resposta"

# Coleta de informações de erro
npm run build 2>&1 | tee error.log
"Identifique a causa raiz do erro de build e proponha métodos adequados de correção"

# Verificação de implementação de correção
git diff HEAD~1
"Avalie se esta correção resolve adequadamente os pontos apontados no review"
```

### Sistema de Classificação de Comentários

```
🔴 must: Correção obrigatória
├─ Problemas de segurança
├─ Bugs funcionais
├─ Violação de princípios de design
└─ Violação de convenções

🟡 imo: Propostas de melhoria
├─ Métodos de implementação melhores
├─ Melhoria de performance
├─ Melhoria de legibilidade
└─ Propostas de refatoração

🟢 nits: Pontos menores
├─ Correção de typos
├─ Ajuste de indentação
├─ Adição de comentários
└─ Pequenos ajustes de nomenclatura

🔵 q: Perguntas e confirmações
├─ Confirmação de intenção de implementação
├─ Esclarecimento de especificações
├─ Contexto de decisões de design
└─ Consideração de alternativas
```

### Abordagem de 3 Etapas para Análise de Erros

#### Etapa 1: Coleta de Informações

**Execução obrigatória**

- Obtenção completa de mensagens de erro
- Verificação de stack trace
- Identificação de condições de reprodução

**Execução recomendada**

- Coleta de informações ambientais
- Histórico de mudanças recentes
- Verificação de logs relacionados

#### Etapa 2: Análise da Causa Raiz

- Aplicação da análise 5 Whys
- Rastreamento de dependências
- Verificação de diferenças ambientais
- Criação de código de reprodução mínima

#### Etapa 3: Implementação de Soluções

- Tratamento imediato (hotfix)
- Solução fundamental (correção essencial)
- Medidas preventivas (prevenção de reincidência)

### Fluxo de Resposta

1. **Análise de comentários**: Classificação por prioridade
2. **Plano de correção**: Determinação da ordem de resposta
3. **Correção por etapas**: Critical → High → Medium → Low
4. **Verificação de qualidade**: Teste, lint, build
5. **Relatório de progresso**: Explicação específica do conteúdo das correções

### Verificação Após Correção

```bash
# Verificação básica
npm test
npm run lint
npm run build

# Teste de regressão
npm run test:e2e

# Qualidade do código
npm run test:coverage
```

### Templates de Resposta

**Relatório de Conclusão de Correção**

```markdown
@reviewer Obrigado pelo apontamento.
Correção concluída:

- [Conteúdo específico da correção]
- [Resultado do teste]
- [Método de verificação]
```

**Explicação de Decisão Técnica**

```markdown
Contexto da implementação: [motivo]
Alternativas consideradas: [opções e base de julgamento]
Vantagens da solução adotada: [méritos]
```

### Observações

- **Conformidade com prioridades**: Responder na ordem Critical → High → Medium → Low
- **Teste primeiro**: Confirmar teste de regressão antes da correção
- **Relatório claro**: Descrever especificamente conteúdo da correção e método de verificação
- **Diálogo construtivo**: Comunicação cortês baseada em fundamentos técnicos
