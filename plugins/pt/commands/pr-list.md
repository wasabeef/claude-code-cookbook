## PR List

Exibe a lista de PRs abertos do repositório atual com priorização.

### Uso

```bash
# Solicitar ao Claude
"Exibir lista de PRs abertos com priorização"
```

### Exemplo básico

```bash
# Obtém informações do repositório
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# Obtém informações de PRs abertos e solicita ao Claude
gh pr list --state open --draft=false --json number,title,author,createdAt,additions,deletions,reviews --limit 30

"Organize os PRs acima por prioridade e exiba incluindo um resumo de 2 linhas para cada PR. Gere a URL usando o nome do repositório obtido acima"
```

### Formato de exibição

```text
Lista de PRs Abertos (ordenados por prioridade)

### Alta Prioridade
#número Título [Draft/DNM] | autor | tempo decorrido desde abertura | número de Approved | +adições/-remoções
      ├─ 1ª linha do resumo
      └─ 2ª linha do resumo
      https://github.com/owner/repo/pull/número

### Prioridade Média
(mesmo formato)

### Baixa Prioridade
(mesmo formato)
```

### Critérios de determinação de prioridade

**Alta Prioridade**

- `fix:` Correção de bug
- `release:` Trabalho de release

**Prioridade Média**

- `feat:` Nova funcionalidade
- `update:` Melhoria de funcionalidade
- Outros PRs normais

**Baixa Prioridade**

- PRs contendo DO NOT MERGE
- Draft com PRs de `test:`, `build:`, `perf:`

### Observações

- Requer GitHub CLI (`gh`)
- Exibe apenas PRs no estado aberto (exclui Draft)
- Exibe máximo de 30 PRs
- Tempo decorrido é desde quando o PR foi aberto
- URL do PR é gerada automaticamente a partir do nome real do repositório
