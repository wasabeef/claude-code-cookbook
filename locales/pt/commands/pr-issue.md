## Issue List

Exibe a lista de Issues abertas do repositório atual com priorização.

### Uso

```bash
# Solicitar ao Claude
"Exibir lista de Issues abertas com priorização"
```

### Exemplo básico

```bash
# Obtém informações do repositório
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# Obtém informações de Issues abertas e solicita ao Claude
gh issue list --state open --json number,title,author,createdAt,updatedAt,labels,assignees,comments --limit 30

"Organize as Issues acima por prioridade e exiba incluindo um resumo de 2 linhas para cada Issue. Gere a URL usando o nome do repositório obtido acima"
```

### Formato de exibição

```text
Lista de Issues Abertas (ordenadas por prioridade)

### Alta Prioridade
#número Título [rótulo] | autor | tempo decorrido desde abertura | número de comentários | responsável
      ├─ 1ª linha do resumo
      └─ 2ª linha do resumo
      https://github.com/owner/repo/issues/número

### Prioridade Média
(mesmo formato)

### Baixa Prioridade
(mesmo formato)
```

### Critérios de determinação de prioridade

**Alta Prioridade**

- Issues com rótulo `bug`
- Issues com rótulo `critical` ou `urgent`
- Issues com rótulo `security`

**Prioridade Média**

- Issues com rótulo `enhancement`
- Issues com rótulo `feature`
- Issues com responsável definido

**Baixa Prioridade**

- Issues com rótulo `documentation`
- Issues com rótulo `good first issue`
- Issues com rótulo `wontfix` ou `duplicate`

### Filtragem por rótulos

```bash
# Obtém apenas Issues com rótulo específico
gh issue list --state open --label "bug" --json number,title,author,createdAt,labels,comments --limit 30

# Filtragem com múltiplos rótulos (condição AND)
gh issue list --state open --label "bug,high-priority" --json number,title,author,createdAt,labels,comments --limit 30
```

### Observações

- Requer GitHub CLI (`gh`)
- Exibe apenas Issues no estado aberto
- Exibe máximo de 30 Issues
- Tempo decorrido é desde quando a Issue foi aberta
- URL da Issue é gerada automaticamente a partir do nome real do repositório
