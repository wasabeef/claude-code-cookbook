## Semantic Commit

Divide grandes mudanças em unidades mínimas significativas e faz commits sequenciais com mensagens de commit semânticas. Usa apenas comandos padrão do git, sem depender de ferramentas externas.

### Como usar

```bash
/semantic-commit [opções]
```

### Opções

- `--dry-run` : Mostra apenas as divisões de commit propostas sem fazer commits reais
- `--lang <idioma>` : Força especificação do idioma das mensagens de commit (en, pt)
- `--max-commits <número>` : Especifica o número máximo de commits (padrão: 10)

### Exemplos Básicos

```bash
# Analisa mudanças atuais e faz commits por unidade lógica
/semantic-commit

# Confirma apenas propostas de divisão (sem commits reais)
/semantic-commit --dry-run

# Gera mensagens de commit em inglês
/semantic-commit --lang en

# Gera mensagens de commit em português
/semantic-commit --lang pt

# Divide em no máximo 5 commits
/semantic-commit --max-commits 5
```

### Fluxo de Operação

1. **Análise de mudanças**: Obtém todas as mudanças com `git diff HEAD`
2. **Classificação de arquivos**: Agrupa logicamente os arquivos modificados
3. **Proposta de commits**: Gera mensagens de commit semânticas para cada grupo
4. **Execução sequencial**: Executa commits sequenciais de cada grupo após confirmação do usuário

### Funcionalidade Central de Divisão de Mudanças

#### Detecção de "Grandes Mudanças"

Detecta como grande mudança sob as seguintes condições:

1. **Número de arquivos modificados**: Mudanças em 5 ou mais arquivos
2. **Número de linhas modificadas**: Mudanças de 100 ou mais linhas
3. **Múltiplas funcionalidades**: Mudanças que abrangem 2 ou mais áreas funcionais
4. **Padrão misto**: Mistura de feat + fix + docs

```bash
# Análise da escala de mudanças
CHANGED_FILES=$(git diff HEAD --name-only | wc -l)
CHANGED_LINES=$(git diff HEAD --stat | tail -1 | grep -o '[0-9]\+ insertions\|[0-9]\+ deletions' | awk '{sum+=$1} END {print sum}')

if [ $CHANGED_FILES -ge 5 ] || [ $CHANGED_LINES -ge 100 ]; then
  echo "Grande mudança detectada: divisão recomendada"
fi
```

#### Estratégia de Divisão em "Unidades Mínimas Significativas"

##### 1. Divisão por Fronteiras Funcionais

```bash
# Identificação de unidades funcionais a partir da estrutura de diretórios
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq
# → src/auth, src/api, components/ui, etc.
```

##### 2. Separação por Tipo de Mudança

```bash
# Arquivos novos vs modificação de arquivos existentes
git diff HEAD --name-status | grep '^A' # Arquivos novos
git diff HEAD --name-status | grep '^M' # Arquivos modificados
git diff HEAD --name-status | grep '^D' # Arquivos excluídos
```

##### 3. Análise de Dependências

```bash
# Detecção de mudanças em relacionamentos de importação
git diff HEAD | grep -E '^[+-].*import|^[+-].*require' | \
cut -d' ' -f2- | sort | uniq
```

#### Análise Detalhada por Arquivo

```bash
# Obtém lista de arquivos modificados
git diff HEAD --name-only

# Analisa individualmente o conteúdo de mudanças de cada arquivo
git diff HEAD -- <file>

# Determina o tipo de mudança do arquivo
git diff HEAD --name-status | while read status file; do
  case $status in
    A) echo "$file: novo" ;;
    M) echo "$file: modificado" ;;
    D) echo "$file: excluído" ;;
    R*) echo "$file: renomeado" ;;
  esac
done
```

#### Critérios de Agrupamento Lógico

1. **Unidade funcional**: Arquivos relacionados à mesma funcionalidade
   - Arquivos em `src/auth/` → funcionalidade de autenticação
   - Arquivos em `components/` → componentes UI

2. **Tipo de mudança**: Mesmo tipo de mudança
   - Apenas arquivos de teste → `test:`
   - Apenas documentação → `docs:`
   - Apenas arquivos de configuração → `chore:`

3. **Dependências**: Arquivos inter-relacionados
   - Modelo + migração
   - Componente + estilo

4. **Escala de mudanças**: Manutenção do tamanho adequado de commit
   - 10 arquivos ou menos por commit
   - Agrupamento de arquivos com alta correlação

### Exemplo de Saída

```bash
$ /semantic-commit

Analisando mudanças...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Mudanças detectadas:
• src/auth/login.ts (modificado)
• src/auth/register.ts (novo)
• src/auth/types.ts (modificado)
• tests/auth.test.ts (novo)
• docs/authentication.md (novo)

Divisão de commits proposta:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 1/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Mensagem: feat: implement user registration and login system
Arquivos incluídos:
  • src/auth/login.ts
  • src/auth/register.ts
  • src/auth/types.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 2/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Mensagem: test: add comprehensive tests for authentication system
Arquivos incluídos:
  • tests/auth.test.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 3/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Mensagem: docs: add authentication system documentation
Arquivos incluídos:
  • docs/authentication.md

Executar commits com esta divisão? (y/n/edit):
```

### Opções Durante a Execução

- `y` : Executa com a divisão de commits proposta
- `n` : Cancela
- `edit` : Edita mensagens de commit individualmente
- `merge <número1> <número2>` : Une os commits especificados
- `split <número>` : Divide ainda mais o commit especificado

### Modo Dry Run

```bash
$ /semantic-commit --dry-run

Analisando mudanças... (DRY RUN)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Exibição da proposta de divisão de commits]

ℹ️  Modo DRY RUN: commits reais não serão executados
💡 Para executar, re-execute sem a opção --dry-run
```

### Funcionalidade de Análise Inteligente

#### 1. Compreensão da Estrutura do Projeto

- Determina o tipo de projeto através de `package.json`, `Cargo.toml`, `pom.xml`, etc.
- Infere unidades funcionais a partir da estrutura de pastas

#### 2. Reconhecimento de Padrões de Mudança

```bash
# Detecção de padrão de correção de bugs
- Palavras-chave como "fix", "bug", "error"
- Adição de tratamento de exceções
- Modificação de ramificações condicionais

# Detecção de padrão de nova funcionalidade
- Criação de novos arquivos
- Adição de novos métodos
- Adição de endpoints de API
```

#### 3. Análise de Dependências

- Mudanças em instruções de importação
- Adição/modificação de definições de tipos
- Relacionamento com arquivos de configuração

### Implementação Técnica

#### Implementação de Commits Sequenciais por Comandos Padrão Git

##### 1. Pré-processamento: Salvar Estado Atual

```bash
# Reset mudanças não-staged se existirem
git reset HEAD
git status --porcelain > /tmp/original_state.txt

# Confirmação da branch de trabalho
CURRENT_BRANCH=$(git branch --show-current)
echo "Branch de trabalho: $CURRENT_BRANCH"
```

##### 2. Execução Sequencial de Commits por Grupo

```bash
# Carregamento do plano de divisão
while IFS= read -r commit_plan; do
  group_num=$(echo "$commit_plan" | cut -d':' -f1)
  files=$(echo "$commit_plan" | cut -d':' -f2- | tr ' ' '\n')

  echo "=== Executando Commit $group_num ==="

  # Staging apenas dos arquivos relevantes
  echo "$files" | while read file; do
    if [ -f "$file" ]; then
      git add "$file"
      echo "Staging: $file"
    fi
  done

  # Confirmação do estado de staging
  staged_files=$(git diff --staged --name-only)
  if [ -z "$staged_files" ]; then
    echo "Aviso: nenhum arquivo foi staged"
    continue
  fi

  # Geração de mensagem de commit (análise por LLM)
  commit_msg=$(generate_commit_message_for_staged_files)

  # Confirmação do usuário
  echo "Mensagem de commit proposta: $commit_msg"
  echo "Arquivos em staging:"
  echo "$staged_files"
  read -p "Executar este commit? (y/n): " confirm

  if [ "$confirm" = "y" ]; then
    # Execução do commit
    git commit -m "$commit_msg"
    echo "✅ Commit $group_num concluído"
  else
    # Cancelar staging
    git reset HEAD
    echo "❌ Commit $group_num pulado"
  fi

done < /tmp/commit_plan.txt
```

##### 3. Tratamento de Erros e Rollback

```bash
# Tratamento de falhas de pre-commit hooks
commit_with_retry() {
  local commit_msg="$1"
  local max_retries=2
  local retry_count=0

  while [ $retry_count -lt $max_retries ]; do
    if git commit -m "$commit_msg"; then
      echo "✅ Commit realizado com sucesso"
      return 0
    else
      echo "❌ Falha no commit (tentativa $((retry_count + 1))/$max_retries)"

      # Incorporar correções automáticas por pre-commit hooks
      if git diff --staged --quiet; then
        echo "Mudanças foram corrigidas automaticamente por pre-commit hooks"
        git add -u
      fi

      retry_count=$((retry_count + 1))
    fi
  done

  echo "❌ Falha no commit. Verificar manualmente."
  return 1
}

# Recuperação de interrupções
resume_from_failure() {
  echo "Processamento de commit interrompido detectado"
  echo "Estado atual de staging:"
  git status --porcelain

  read -p "Continuar processamento? (y/n): " resume
  if [ "$resume" = "y" ]; then
    # Reiniciar a partir da posição do último commit
    last_commit=$(git log --oneline -1 --pretty=format:"%s")
    echo "Último commit: $last_commit"
  else
    # Reset completo
    git reset HEAD
    echo "Processamento foi resetado"
  fi
}
```

##### 4. Verificação Pós-Conclusão

```bash
# Confirmar se todas as mudanças foram commitadas
remaining_changes=$(git status --porcelain | wc -l)
if [ $remaining_changes -eq 0 ]; then
  echo "✅ Todas as mudanças foram commitadas"
else
  echo "⚠️  Mudanças não commitadas restantes:"
  git status --short
fi

# Exibir histórico de commits
echo "Commits criados:"
git log --oneline -n 10 --graph
```

##### 5. Supressão de Push Automático

```bash
# Nota: não fazer push automático
echo "📝 Nota: push automático não será executado"
echo "Execute o push manualmente conforme necessário:"
echo "  git push origin $CURRENT_BRANCH"
```

#### Detalhes do Algoritmo de Divisão

##### Passo 1: Análise Inicial

```bash
# Obter e classificar todos os arquivos alterados
git diff HEAD --name-status | while read status file; do
  echo "$status:$file"
done > /tmp/changes.txt

# Estatísticas de mudanças por diretório funcional
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq -c
```

##### Passo 2: Agrupamento Inicial por Fronteiras Funcionais

```bash
# Agrupamento baseado em diretórios
GROUPS=$(git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq)
for group in $GROUPS; do
  echo "=== Grupo: $group ==="
  git diff HEAD --name-only | grep "^$group" | head -10
done
```

##### Passo 3: Análise de Similaridade de Conteúdo de Mudanças

```bash
# Análise do tipo de mudança para cada arquivo
git diff HEAD --name-only | while read file; do
  # Detecção de adição de novas funções/classes
  NEW_FUNCTIONS=$(git diff HEAD -- "$file" | grep -c '^+.*function\|^+.*class\|^+.*def ')

  # Detecção de padrões de correção de bugs
  BUG_FIXES=$(git diff HEAD -- "$file" | grep -c '^+.*fix\|^+.*bug\|^-.*error')

  # Determinar se é arquivo de teste
  if [[ "$file" =~ test|spec ]]; then
    echo "$file: TEST"
  elif [ $NEW_FUNCTIONS -gt 0 ]; then
    echo "$file: FEAT"
  elif [ $BUG_FIXES -gt 0 ]; then
    echo "$file: FIX"
  else
    echo "$file: REFACTOR"
  fi
done
```

##### Passo 4: Ajuste por Dependências

```bash
# Análise de relações de importação
git diff HEAD | grep -E '^[+-].*import|^[+-].*from.*import' | \
while read line; do
  echo "$line" | sed 's/^[+-]//' | awk '{print $2}'
done | sort | uniq > /tmp/imports.txt

# Agrupamento de arquivos relacionados
git diff HEAD --name-only | while read file; do
  basename=$(basename "$file" .js .ts .py)
  related=$(git diff HEAD --name-only | grep "$basename" | grep -v "^$file$")
  if [ -n "$related" ]; then
    echo "Grupo de arquivos relacionados: $file <-> $related"
  fi
done
```

##### Passo 5: Otimização do Tamanho dos Commits

```bash
# Ajuste do tamanho dos grupos
MAX_FILES_PER_COMMIT=8
current_group=1
file_count=0

git diff HEAD --name-only | while read file; do
  if [ $file_count -ge $MAX_FILES_PER_COMMIT ]; then
    current_group=$((current_group + 1))
    file_count=0
  fi
  echo "Commit $current_group: $file"
  file_count=$((file_count + 1))
done
```

##### Passo 6: Decisão Final dos Grupos

```bash
# Verificação do resultado da divisão
for group in $(seq 1 $current_group); do
  files=$(grep "Commit $group:" /tmp/commit_plan.txt | cut -d':' -f2-)
  lines=$(echo "$files" | xargs git diff HEAD -- | wc -l)
  echo "Commit $group: $(echo "$files" | wc -w) arquivos, $lines linhas alteradas"
done
```

### Conformidade com Conventional Commits

#### Formato Básico

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### Tipos Padrão

**Tipos obrigatórios**:

- `feat`: Nova funcionalidade (funcionalidade visível ao usuário)
- `fix`: Correção de bug

**Tipos opcionais**:

- `build`: Mudanças no sistema de build ou dependências externas
- `chore`: Outras mudanças (não afetam o release)
- `ci`: Mudanças em arquivos de configuração ou scripts de CI
- `docs`: Mudanças apenas na documentação
- `style`: Mudanças que não afetam o significado do código (espaços, formatação, ponto-e-vírgula, etc.)
- `refactor`: Mudanças no código que não corrigem bugs nem adicionam funcionalidades
- `perf`: Melhoria de performance
- `test`: Adição ou modificação de testes

#### Escopo (Opcional)

Indica o escopo de impacto das mudanças:

```text
feat(api): add user authentication endpoint
fix(ui): resolve button alignment issue
docs(readme): update installation instructions
```

#### Breaking Change

Em caso de mudanças que quebram a API:

```text
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

ou

```text
feat(api)!: change authentication flow
```

#### Detecção Automática de Convenções do Projeto

**Importante**: Quando existem convenções específicas do projeto, essas têm prioridade.

##### 1. Verificação de Configurações CommitLint

Detecta automaticamente configurações dos seguintes arquivos:

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- Seção `commitlint` do `package.json`

```bash
# Verificação de arquivos de configuração exemplo
cat commitlint.config.mjs
cat .commitlintrc.json
grep -A 10 '"commitlint"' package.json
```

##### 2. Detecção de Tipos Customizados

Exemplo de tipos personalizados do projeto:

```javascript
// commitlint.config.mjs
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // trabalho em progresso
        "hotfix", // correção emergencial
        "release", // release
        "deps", // atualização de dependências
        "config", // mudança de configuração
      ],
    ],
  },
};
```

##### 3. Detecção de Configurações de Idioma

```javascript
// Para projetos que usam mensagens em português
export default {
  rules: {
    "subject-case": [0], // desabilitar para suporte ao português
    "subject-max-length": [2, "always", 72], // ajustar limite de caracteres para português
  },
};
```

#### Fluxo de Análise Automática

1. **Busca por Arquivos de Configuração**

   ```bash
   find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
   ```

2. **Análise de Commits Existentes**

   ```bash
   git log --oneline -50 --pretty=format:"%s"
   ```

3. **Estatísticas de Tipos Utilizados**

   ```bash
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

#### Exemplos de Convenções de Projeto

##### Estilo Angular

```text
feat(scope): add new feature
fix(scope): fix bug
docs(scope): update documentation
```

##### Estilo com Gitmoji

```text
✨ feat: add user registration
🐛 fix: resolve login issue
📚 docs: update API docs
```

##### Projeto em Português

```text
feat: adicionar funcionalidade de registro de usuário
fix: corrigir bug no processo de login
docs: atualizar documentação da API
```

### Detecção de Idioma

Lógica de detecção de idioma completa neste comando:

1. **Configurações CommitLint** verificam configurações de idioma

   ```bash
   # Se a regra subject-case está desabilitada, detecta como português
   grep -E '"subject-case".*\[0\]|subject-case.*0' commitlint.config.*
   ```

2. **Análise do git log** para detecção automática

   ```bash
   # Analisa idioma dos últimos 20 commits
   git log --oneline -20 --pretty=format:"%s" | \
   grep -E 'ção|ões|agem|ário|ória|ência|português|brasil' | wc -l
   # Se 50% ou mais for em português, modo português
   ```

3. **Configurações de idioma dos arquivos do projeto**

   ```bash
   # Verificar idioma do README.md
   head -10 README.md | grep -E 'ção|ões|agem|ário|ória|ência|português|brasil' | wc -l

   # Verificar description do package.json
   grep -E '"description".*(ção|ões|agem|ário|ória|ência|português|brasil)' package.json
   ```

4. **Análise de comentários e strings** nos arquivos alterados

   ```bash
   # Verificar idioma dos comentários nos arquivos alterados
   git diff HEAD | grep -E '^[+-].*//.*ção|ões|agem|ário|ória|ência|português|brasil' | wc -l
   ```

#### Algoritmo de Detecção

```bash
# Cálculo de pontuação para detecção de idioma
PORTUGUESE_SCORE=0

# 1. Configuração CommitLint (+3 pontos)
if grep -q '"subject-case".*\[0\]' commitlint.config.* 2>/dev/null; then
  PORTUGUESE_SCORE=$((PORTUGUESE_SCORE + 3))
fi

# 2. Análise do git log (máximo +2 pontos)
PORTUGUESE_COMMITS=$(git log --oneline -20 --pretty=format:"%s" | \
  grep -cE '(ção|ões|agem|ário|ória|ência|português|brasil)' 2>/dev/null || echo 0)
if [ $PORTUGUESE_COMMITS -gt 10 ]; then
  PORTUGUESE_SCORE=$((PORTUGUESE_SCORE + 2))
elif [ $PORTUGUESE_COMMITS -gt 5 ]; then
  PORTUGUESE_SCORE=$((PORTUGUESE_SCORE + 1))
fi

# 3. Verificação do README.md (+1 ponto)
if head -5 README.md 2>/dev/null | grep -qE '(ção|ões|agem|ário|ória|ência|português|brasil)'; then
  PORTUGUESE_SCORE=$((PORTUGUESE_SCORE + 1))
fi

# 4. Verificação do conteúdo dos arquivos alterados (+1 ponto)
if git diff HEAD 2>/dev/null | grep -qE '^[+-].*(ção|ões|agem|ário|ória|ência|português|brasil)'; then
  PORTUGUESE_SCORE=$((PORTUGUESE_SCORE + 1))
fi

# Detecção: 3 pontos ou mais para modo português
if [ $PORTUGUESE_SCORE -ge 3 ]; then
  LANGUAGE="pt"
else
  LANGUAGE="en"
fi
```

### Carregamento Automático de Arquivos de Configuração

#### Comportamento Durante a Execução

Durante a execução do comando, as configurações são verificadas na seguinte ordem:

1. **Busca por Arquivos de Configuração CommitLint**

   ```bash
   # Busca na seguinte ordem e usa o primeiro encontrado
   commitlint.config.mjs
   commitlint.config.js
   commitlint.config.cjs
   commitlint.config.ts
   .commitlintrc.js
   .commitlintrc.json
   .commitlintrc.yml
   .commitlintrc.yaml
   package.json (seção commitlint)
   ```

2. **Análise do Conteúdo da Configuração**
   - Extrai lista de tipos disponíveis
   - Verifica se há limitações de escopo
   - Obtém limite de comprimento de mensagem
   - Confirma configurações de idioma

3. **Análise do Histórico de Commits Existentes**

   ```bash
   # Aprende padrões de uso a partir de commits recentes
   git log --oneline -100 --pretty=format:"%s" | \
   head -20
   ```

#### Análise de Exemplos de Configuração

**commitlint.config.mjs padrão**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "perf", "test", "chore"],
    ],
    "scope-enum": [2, "always", ["api", "ui", "core", "auth", "db"]],
  },
};
```

**Configuração para suporte ao português**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "subject-case": [0], // desabilitar para português
    "subject-max-length": [2, "always", 72],
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "test", "chore"],
    ],
  },
};
```

**Configuração com tipos customizados**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // Work in Progress
        "hotfix", // correção emergencial
        "release", // preparação de release
        "deps", // atualização de dependências
        "config", // mudança de configuração
      ],
    ],
  },
};
```

#### Comportamento de Fallback

Quando nenhum arquivo de configuração é encontrado:

1. **Análise do git log** para inferência automática

   ```bash
   # Extrai tipos dos últimos 100 commits
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

2. **Uso padrão do Conventional Commits**

   ```
   feat, fix, docs, style, refactor, perf, test, chore, build, ci
   ```

3. **Detecção de idioma**
   - Commits em português 50% ou mais → modo português
   - Outros → modo inglês

### Pré-requisitos

- Execução dentro de um repositório Git
- Existência de mudanças não commitadas
- Mudanças em staging serão resetadas temporariamente

### Observações

- **Sem push automático**: `git push` após commits deve ser executado manualmente
- **Sem criação de branch**: Commits na branch atual
- **Backup recomendado**: Use `git stash` para backup antes de mudanças importantes

### Prioridade das Convenções do Projeto

Prioridade ao gerar mensagens de commit:

1. **Configuração CommitLint** (prioridade máxima)
   - Configurações do arquivo `commitlint.config.*`
   - Tipos personalizados e restrições de escopo
   - Restrições de comprimento e formato de mensagem

2. **Histórico de commits existente** (segunda prioridade)
   - Estatísticas dos tipos realmente utilizados
   - Idioma das mensagens (japonês/inglês)
   - Padrões de uso de escopo

3. **Tipo de projeto** (terceira prioridade)
   - `package.json` → Projeto Node.js
   - `Cargo.toml` → Projeto Rust
   - `pom.xml` → Projeto Java

4. **Padrão Conventional Commits** (fallback)
   - Comportamento padrão quando nenhuma configuração é encontrada

#### Exemplos de Detecção de Convenções

**Detecção automática de scope em Monorepo**:

```bash
# Inferir scope a partir da pasta packages/
ls packages/ | head -10
# → api, ui, core, auth etc. propostos como scope
```

**Convenções específicas por framework**:

```javascript
// Projeto Angular
{
  'scope-enum': [2, 'always', [
    'animations', 'common', 'core', 'forms', 'http', 'platform-browser',
    'platform-server', 'router', 'service-worker', 'upgrade'
  ]]
}

// Projeto React
{
  'scope-enum': [2, 'always', [
    'components', 'hooks', 'utils', 'types', 'styles', 'api'
  ]]
}
```

**Convenções específicas de empresa/equipe**:

```javascript
// Padrão comum em empresas japonesas
{
  'type-enum': [2, 'always', [
    'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
    'wip',      // trabalho em progresso (para pull requests)
    'hotfix',   // correção emergencial
    'release'   // preparação de release
  ]],
  'subject-case': [0],  // suporte ao japonês
  'subject-max-length': [2, 'always', 72]  // configuração mais longa para japonês
}
```

### Melhores Práticas

1. **Respeitar convenções do projeto**: Seguir configurações e padrões existentes
2. **Pequenas unidades de mudança**: Um commit é uma mudança lógica
3. **Mensagens claras**: O que foi modificado deve ser claro
4. **Priorizar relacionamento**: Agrupar arquivos funcionalmente relacionados
5. **Separar testes**: Arquivos de teste em commits separados
6. **Utilizar arquivos de configuração**: Introduzir CommitLint para unificar convenções em toda a equipe

### Exemplos Reais de Divisão (Antes/Depois)

#### Exemplo 1: Adição de Sistema de Autenticação em Larga Escala

**Antes (1 commit gigante):**

```bash
# Arquivos alterados (15 arquivos, 850 linhas alteradas)
src/auth/login.js          # novo
src/auth/register.js       # novo
src/auth/password.js       # novo
src/auth/types.js          # novo
src/api/auth-routes.js     # novo
src/middleware/auth.js     # novo
src/database/migrations/001_users.sql  # novo
src/database/models/user.js            # novo
tests/auth/login.test.js   # novo
tests/auth/register.test.js # novo
tests/api/auth-routes.test.js # novo
docs/authentication.md    # novo
package.json              # adição de dependências
README.md                 # adição de instruções de uso
.env.example             # adição de exemplos de variáveis de ambiente

# Commit problemático convencional
feat: implement complete user authentication system with login, registration, password reset, API routes, database models, tests and documentation
```

**Depois (dividido em 5 commits significativos):**

```bash
# Commit 1: Base do banco de dados
feat(db): add user model and authentication schema

Arquivos incluídos:
- src/database/migrations/001_users.sql
- src/database/models/user.js
- src/auth/types.js

Razão: Estrutura do banco de dados é a base para outras funcionalidades, por isso primeiro commit

# Commit 2: Lógica de autenticação
feat(auth): implement core authentication functionality

Arquivos incluídos:
- src/auth/login.js
- src/auth/register.js
- src/auth/password.js
- src/middleware/auth.js

Razão: Lógica de negócio central da autenticação commitada em lote

# Commit 3: Endpoints da API
feat(api): add authentication API routes

Arquivos incluídos:
- src/api/auth-routes.js

Razão: Camada da API depende da lógica de autenticação, por isso commit posterior

# Commit 4: Testes abrangentes
test(auth): add comprehensive authentication tests

Arquivos incluídos:
- tests/auth/login.test.js
- tests/auth/register.test.js
- tests/api/auth-routes.test.js

Razão: Adição de testes em lote após conclusão da implementação

# Commit 5: Configuração e documentação
docs(auth): add authentication documentation and configuration

Arquivos incluídos:
- docs/authentication.md
- package.json
- README.md
- .env.example

Razão: Documentação e configuração commitadas em lote por último
```

#### Exemplo 2: Mistura de Correção de Bugs e Refatoração

**Antes (commit problemático com mistura):**

```bash
# Arquivos alterados (8 arquivos, 320 linhas alteradas)
src/user/service.js       # correção de bug + refatoração
src/user/validator.js     # novo (refatoração)
src/auth/middleware.js    # correção de bug
src/api/user-routes.js    # correção de bug + melhoria de tratamento de erros
tests/user.test.js        # adição de testes
tests/auth.test.js        # adição de testes de correção de bugs
docs/user-api.md          # atualização de documentação
package.json              # atualização de dependências

# Commit problemático
fix: resolve user validation bugs and refactor validation logic with improved error handling
```

**Depois (dividido em 3 commits por tipo):**

```bash
# Commit 1: Correção emergencial de bugs
fix: resolve user validation and authentication bugs

Arquivos incluídos:
- src/user/service.js (apenas partes de correção de bugs)
- src/auth/middleware.js
- tests/auth.test.js (apenas testes de correção de bugs)

Razão: Bugs que afetam produção são corrigidos com prioridade máxima

# Commit 2: Refatoração da lógica de validação
refactor: extract and improve user validation logic

Arquivos incluídos:
- src/user/service.js (partes de refatoração)
- src/user/validator.js
- src/api/user-routes.js
- tests/user.test.js

Razão: Melhorias estruturais commitadas por unidade funcional

# Commit 3: Atualização de documentação e dependências
chore: update documentation and dependencies

Arquivos incluídos:
- docs/user-api.md
- package.json

Razão: Manutenção do ambiente de desenvolvimento commitada por último
```

#### Exemplo 3: Desenvolvimento Simultâneo de Múltiplas Funcionalidades

**Antes (commit gigante cruzando funcionalidades):**

```bash
# Arquivos alterados (12 arquivos, 600 linhas alteradas)
src/user/profile.js       # nova funcionalidade A
src/user/avatar.js        # nova funcionalidade A
src/notification/email.js # nova funcionalidade B
src/notification/sms.js   # nova funcionalidade B
src/api/profile-routes.js # API para nova funcionalidade A
src/api/notification-routes.js # API para nova funcionalidade B
src/dashboard/widgets.js  # nova funcionalidade C
src/dashboard/charts.js   # nova funcionalidade C
tests/profile.test.js     # testes para nova funcionalidade A
tests/notification.test.js # testes para nova funcionalidade B
tests/dashboard.test.js   # testes para nova funcionalidade C
package.json              # dependências para todas as funcionalidades

# Commit problemático
feat: add user profile management, notification system and dashboard widgets
```

**Depois (dividido em 4 commits por funcionalidade):**

```bash
# Commit 1: Funcionalidade de perfil de usuário
feat(profile): add user profile management

Arquivos incluídos:
- src/user/profile.js
- src/user/avatar.js
- src/api/profile-routes.js
- tests/profile.test.js

Razão: Funcionalidade de perfil é uma unidade funcional independente

# Commit 2: Sistema de notificações
feat(notification): implement email and SMS notifications

Arquivos incluídos:
- src/notification/email.js
- src/notification/sms.js
- src/api/notification-routes.js
- tests/notification.test.js

Razão: Funcionalidade de notificação é uma unidade funcional independente

# Commit 3: Widgets do dashboard
feat(dashboard): add interactive widgets and charts

Arquivos incluídos:
- src/dashboard/widgets.js
- src/dashboard/charts.js
- tests/dashboard.test.js

Razão: Funcionalidade de dashboard é uma unidade funcional independente

# Commit 4: Atualização de dependências e infraestrutura
chore: update dependencies for new features

Arquivos incluídos:
- package.json

Razão: Atualizações de dependências comuns por último
```

### Comparação dos Efeitos da Divisão

| Item                         | Antes (Commit Gigante)                        | Depois (Divisão Adequada)                       |
| ---------------------------- | --------------------------------------------- | ----------------------------------------------- |
| **Revisabilidade**           | ❌ Muito difícil                              | ✅ Cada commit pequeno e revisável              |
| **Rastreamento de Bugs**     | ❌ Difícil identificar local do problema      | ✅ Identifica commit problemático imediatamente |
| **Revert**                   | ❌ Necessário reverter tudo                   | ✅ Revert pontual apenas da parte problemática  |
| **Desenvolvimento Paralelo** | ❌ Propenso a conflitos                       | ✅ Merge fácil por funcionalidade               |
| **Deploy**                   | ❌ Deploy de todas as funcionalidades em lote | ✅ Deploy gradual possível                      |

### Solução de Problemas

#### Quando o Commit Falha

- Verificação de pre-commit hooks
- Resolução de dependências
- Nova tentativa com arquivos individuais

#### Quando a Divisão Não Está Adequada

- Ajustar com opção `--max-commits`
- Usar modo `edit` manual
- Re-executar com unidades menores
