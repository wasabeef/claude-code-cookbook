## PR Auto Update

## Visão Geral

Comando para atualizar automaticamente a descrição e rótulos de Pull Requests. Analisa as alterações do Git para gerar e definir descrições e rótulos apropriados.

## Uso

```bash
/pr-auto-update [opções] [número do PR]
```

### Opções

- `--pr <número>` : Especifica o número do PR alvo (detecta automaticamente do branch atual se omitido)
- `--description-only` : Atualiza apenas a descrição (não altera os rótulos)
- `--labels-only` : Atualiza apenas os rótulos (não altera a descrição)
- `--dry-run` : Não executa a atualização real, apenas exibe o conteúdo que seria gerado
- `--lang <idioma>` : Especifica o idioma (ja, en)

### Exemplos Básicos

```bash
# Atualiza automaticamente o PR do branch atual
/pr-auto-update

# Atualiza um PR específico
/pr-auto-update --pr 1234

# Atualiza apenas a descrição
/pr-auto-update --description-only

# Confirmação com dry-run
/pr-auto-update --dry-run
```

## Detalhes da Funcionalidade

### 1. Detecção Automática de PR

Detecta automaticamente o PR correspondente do branch atual:

```bash
# Busca PR do branch
gh pr list --head $(git branch --show-current) --json number,title,url
```

### 2. Análise do Conteúdo das Alterações

Coleta e analisa as seguintes informações:

- **Alterações de Arquivo**: Arquivos adicionados, removidos ou modificados
- **Análise de Código**: Alterações em declarações import, definições de função e classe
- **Testes**: Presença e conteúdo de arquivos de teste
- **Documentação**: Atualizações de README e docs
- **Configuração**: Alterações em package.json, pubspec.yaml, arquivos de configuração
- **CI/CD**: Alterações em GitHub Actions e workflow

### 3. Geração Automática de Descrição

#### Prioridade do Processamento de Template

1. **Descrição de PR Existente**: **Segue completamente** o conteúdo já descrito
2. **Template do Projeto**: Obtém estrutura de `.github/PULL_REQUEST_TEMPLATE.md`
3. **Template Padrão**: Fallback caso os anteriores não existam

#### Regras de Preservação de Conteúdo Existente

**Importante**: Não altera o conteúdo existente

- Preserva seções já escritas
- Complementa apenas seções vazias
- Preserva comentários funcionais (como regras do Copilot review)

#### Uso do Template do Projeto

```bash
# Analisa a estrutura de .github/PULL_REQUEST_TEMPLATE.md
parse_template_structure() {
  local template_file="$1"
  
  if [ -f "$template_file" ]; then
    # Extrai estrutura das seções
    grep -E '^##|^###' "$template_file"
    
    # Identifica placeholders de comentário
    grep -E '<!--.*-->' "$template_file"
    
    # Segue completamente a estrutura do template existente
    cat "$template_file"
  fi
}
```

### 4. Configuração Automática de Rótulos

#### Mecanismo de Obtenção de Rótulos

**Ordem de Prioridade**:

1. **`.github/labels.yml`**: Obtém de definições de rótulos específicos do projeto
2. **GitHub API**: Obtém rótulos existentes com `gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'`

#### Regras de Determinação Automática

**Baseado em Padrões de Arquivo**:

- Documentação: `*.md`, `README`, `docs/` → rótulos contendo `documentation|docs|doc`
- Teste: `test`, `spec` → rótulos contendo `test|testing`  
- CI/CD: `.github/`, `*.yml`, `Dockerfile` → rótulos contendo `ci|build|infra|ops`
- Dependências: `package.json`, `pubspec.yaml`, `requirements.txt` → rótulos contendo `dependencies|deps`

**Baseado no Conteúdo das Alterações**:

- Correção de Bug: `fix|bug|error|crash|修正` → rótulos contendo `bug|fix`
- Nova Funcionalidade: `feat|feature|add|implement|新機能|実装` → rótulos contendo `feature|enhancement|feat`
- Refatoração: `refactor|clean|リファクタ` → rótulos contendo `refactor|cleanup|clean`
- Performance: `performance|perf|optimize|パフォーマンス` → rótulos contendo `performance|perf`
- Segurança: `security|secure|セキュリティ` → rótulos contendo `security`

#### Restrições

- **Máximo 3**: Limite superior do número de rótulos selecionados automaticamente
- **Apenas Rótulos Existentes**: Proibida a criação de novos rótulos
- **Correspondência Parcial**: Determina se palavras-chave estão contidas no nome do rótulo

#### Exemplo de Uso Real

**Quando `.github/labels.yml` existe**:

```bash
# Obtém automaticamente das definições de rótulo
grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"

# Exemplo: Usa sistema de rótulos específico do projeto
```

**Quando obtém do GitHub API**:

```bash
# Obtém lista de rótulos existentes
gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'

# Exemplo: Usa rótulos padrão como bug, enhancement, documentation
```

### 5. Fluxo de Execução

```bash
#!/bin/bash

# 1. Detecção/Obtenção de PR
detect_pr() {
  if [ -n "$PR_NUMBER" ]; then
    echo $PR_NUMBER
  else
    gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
  fi
}

# 2. Análise do conteúdo das alterações
analyze_changes() {
  local pr_number=$1
  
  # Obtém alterações de arquivo
  gh pr diff $pr_number --name-only
  
  # Análise do conteúdo
  gh pr diff $pr_number | head -1000
}

# 3. Geração de descrição
generate_description() {
  local pr_number=$1
  local changes=$2
  
  # Obtém descrição atual do PR
  local current_body=$(gh pr view $pr_number --json body --jq -r .body)
  
  # Usa conteúdo existente se houver
  if [ -n "$current_body" ]; then
    echo "$current_body"
  else
    # Gera novo do template
    local template_file=".github/PULL_REQUEST_TEMPLATE.md"
    if [ -f "$template_file" ]; then
      generate_from_template "$(cat "$template_file")" "$changes"
    else
      generate_from_template "" "$changes"
    fi
  fi
}

# Geração a partir do template
generate_from_template() {
  local template="$1"
  local changes="$2"
  
  if [ -n "$template" ]; then
    # Usa template como está (preserva comentários HTML)
    echo "$template"
  else
    # Gera com formato padrão
    echo "## What does this change?"
    echo ""
    echo "$changes"
  fi
}

# 4. Determinação de rótulos
determine_labels() {
  local changes=$1
  local file_list=$2
  local pr_number=$3
  
  # Obtém rótulos disponíveis
  local available_labels=()
  if [ -f ".github/labels.yml" ]; then
    # Extrai nomes de rótulo de labels.yml
    available_labels=($(grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"))
  else
    # Obtém rótulos do GitHub API
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    available_labels=($(gh api "repos/$owner/$repo/labels" --jq '.[].name'))
  fi
  
  local suggested_labels=()
  
  # Correspondência de padrões genérica
  analyze_change_patterns "$file_list" "$changes" available_labels suggested_labels
  
  # Limita a máximo 3
  echo "${suggested_labels[@]:0:3}"
}

# Determina rótulos a partir de padrões de alteração
analyze_change_patterns() {
  local file_list="$1"
  local changes="$2"
  local -n available_ref=$3
  local -n suggested_ref=$4
  
  # Determinação por tipo de arquivo
  if echo "$file_list" | grep -q "\.md$\|README\|docs/"; then
    add_matching_label "documentation\|docs\|doc" available_ref suggested_ref
  fi
  
  if echo "$file_list" | grep -q "test\|spec"; then
    add_matching_label "test\|testing" available_ref suggested_ref
  fi
  
  # Determinação por conteúdo das alterações
  if echo "$changes" | grep -iq "fix\|bug\|error\|crash\|修正"; then
    add_matching_label "bug\|fix" available_ref suggested_ref
  fi
  
  if echo "$changes" | grep -iq "feat\|feature\|add\|implement\|新機能\|実装"; then
    add_matching_label "feature\|enhancement\|feat" available_ref suggested_ref
  fi
}

# Adiciona rótulo correspondente
add_matching_label() {
  local pattern="$1"
  local -n available_ref=$2
  local -n suggested_ref=$3
  
  # Pula se já tem 3
  if [ ${#suggested_ref[@]} -ge 3 ]; then
    return
  fi
  
  # Adiciona primeiro rótulo que corresponde ao padrão
  for available_label in "${available_ref[@]}"; do
    if echo "$available_label" | grep -iq "$pattern"; then
      # Verifica duplicata
      local already_exists=false
      for existing in "${suggested_ref[@]}"; do
        if [ "$existing" = "$available_label" ]; then
          already_exists=true
          break
        fi
      done
      
      if [ "$already_exists" = false ]; then
        suggested_ref+=("$available_label")
        return
      fi
    fi
  done
}

# Mantém função antiga para compatibilidade
find_and_add_label() {
  add_matching_label "$@"
}

# 5. Atualização do PR
update_pr() {
  local pr_number=$1
  local description="$2"
  local labels="$3"
  
  if [ "$DRY_RUN" = "true" ]; then
    echo "=== DRY RUN ==="
    echo "Description:"
    echo "$description"
    echo "Labels: $labels"
  else
    # Obtém informações do repositório
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    
    # Atualiza corpo usando GitHub API (preserva comentários HTML)
    # Processa escape JSON adequadamente
    local escaped_body=$(echo "$description" | jq -R -s .)
    gh api \
      --method PATCH \
      "/repos/$owner/$repo/pulls/$pr_number" \
      --field body="$description"
    
    # Rótulos funcionam normalmente com comando gh
    if [ -n "$labels" ]; then
      gh pr edit $pr_number --add-label "$labels"
    fi
  fi
}
```

## Arquivo de Configuração (para expansão futura)

`~/.claude/pr-auto-update.config`:

```json
{
  "language": "ja",
  "max_labels": 3
}
```

## Padrões Comuns

### Projeto Flutter

```markdown
## What does this change?

Implementou {nome da funcionalidade}. Resolve {problema} do usuário.

### Principais alterações

- **Implementação de UI**: Criou nova {nome da tela}
- **Gerenciamento de Estado**: Adicionou provedores Riverpod
- **Integração com API**: Implementou queries e mutations GraphQL
- **Testes**: Adicionou widget tests e unit tests

### Especificações Técnicas

- **Arquitetura**: {padrão utilizado}
- **Dependências**: {pacotes adicionados}
- **Performance**: {conteúdo de otimização}
```

### Projeto Node.js

```markdown
## What does this change?

Implementou endpoint {nome da API}. Corresponde a {caso de uso}.

### Principais alterações

- **Implementação de API**: Criou novo {endpoint}
- **Validação**: Adicionou lógica de validação de requisição
- **Banco de Dados**: Implementou operações para {nome da tabela}
- **Testes**: Adicionou testes de integração e unit tests

### Segurança

- **Autenticação**: Verificação de token JWT
- **Autorização**: Controle de acesso baseado em papel
- **Validação de Entrada**: Contramedidas para injeção SQL
```

### Melhoria de CI/CD

```markdown
## What does this change?

Melhorou workflow do GitHub Actions. Realiza {efeito}.

### Conteúdo das melhorias

- **Performance**: Reduziu tempo de build em {tempo}
- **Confiabilidade**: Fortaleceu tratamento de erro
- **Segurança**: Melhorou gerenciamento de secrets

### Detalhes técnicos

- **Paralelização**: Execução paralela de {nome do job}
- **Cache**: Otimizou estratégia de cache para {alvo do cache}
- **Monitoramento**: Adicionou monitoramento de {métricas}
```

## Observações

1. **Preservação Completa do Conteúdo Existente**:
   - **Não altera nem um caractere** do conteúdo já descrito
   - Complementa apenas partes de comentários vazias e placeholders
   - Respeita conteúdo escrito intencionalmente pelo usuário

2. **Prioridade do Template**:
   - Descrição de PR existente > `.github/PULL_REQUEST_TEMPLATE.md` > Padrão
   - Segue completamente estrutura de template específica do projeto

3. **Restrições de Rótulo**:
   - Usa prioritariamente `.github/labels.yml` se existir
   - Se não existir, obtém rótulos existentes do GitHub API
   - Proibida criação de novos rótulos
   - Seleciona automaticamente até máximo de 3

4. **Atualização Segura**:
   - Recomenda confirmação prévia com `--dry-run`
   - Exibe aviso para alterações contendo informações confidenciais
   - Salva descrição original como backup

5. **Manutenção da Consistência**:
   - Adequa-se ao estilo de PR existente do projeto
   - Unifica idioma (japonês/inglês)
   - Herda regras de rotulagem

## Solução de Problemas

### Problemas Comuns

1. **PR não encontrado**: Confirme associação entre nome do branch e PR
2. **Erro de permissão**: Confirme estado de autenticação do GitHub CLI
3. **Não consegue definir rótulo**: Confirme permissões do repositório
4. **Comentários HTML são escapados**: Devido às especificações do GitHub CLI, `<!-- -->` é convertido para `&lt;!-- --&gt;`

### Problema de Escape de Comentários HTML do GitHub CLI

**Importante**: GitHub CLI (`gh pr edit`) escapa automaticamente comentários HTML. Além disso, strings inválidas como `EOF < /dev/null` podem ser misturadas devido ao processamento de redirecionamento do shell.

#### Soluções Fundamentais

1. **Uso da opção --field do GitHub API**: Usa `--field` para processamento adequado de escape
2. **Simplificação do processamento Shell**: Evita processamento complexo de redirecionamento e pipe
3. **Simplificação do processamento de template**: Elimina processamento de remoção de comentários HTML e preserva completamente
4. **Processamento adequado de escape JSON**: Processa corretamente caracteres especiais

### Opções de Debug

```bash
# Saída de log detalhado (adicionar durante implementação)
/pr-auto-update --verbose
```
