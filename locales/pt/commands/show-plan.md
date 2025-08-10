## Show Plan

Exibe planos em execução ou executados na sessão atual.

### Como usar

```bash
/show-plan
```

### Exemplos Básicos

```bash
# Confirmar plano atual
/show-plan
"Exibir plano em execução"

# Quando não há plano
/show-plan
"Não há planos na sessão atual"
```

### Funcionalidades

- Detecta planos criados com exit_plan_mode
- Explora títulos que contêm palavras-chave como plano de implementação, conteúdo de implementação, plano, etc.
- Formata e exibe o conteúdo do plano
- Notifica claramente quando não há planos

### Integração com Claude

```bash
# Confirmar plano durante implementação
"O que estava implementando mesmo?"
/show-plan

# Durante execução de múltiplas tarefas
"Deixe-me confirmar o plano atual novamente"
/show-plan

# Retrospectiva após execução do plano
"Mostre o conteúdo do plano que executei há pouco"
/show-plan
```

### Padrões de Detecção

Baseado no formato de planos gerados pelo exit_plan_mode, detecta os seguintes padrões:

- Títulos começando com `##` (contendo plano, Plan, etc.)
- `### Conteúdo das mudanças`
- `### Conteúdo da implementação`
- `### Plano de implementação`
- `### 1.` e outros títulos numerados

### Observações

- Exibe apenas planos da sessão atual (não inclui sessões passadas)
- Prioriza a exibição do plano mais recente
