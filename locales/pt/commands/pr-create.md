## PR Create

Criação automática de PR baseada em análise de mudanças Git para um workflow eficiente de Pull Request.

### Como usar

```bash
# Criação automática de PR por análise de mudanças
git add . && git commit -m "feat: implementação da funcionalidade de autenticação do usuário"
"Analise o conteúdo das mudanças e crie um Draft PR com descrições e rótulos apropriados"

# Atualização mantendo template existente
cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
"Mantenha completamente a estrutura do template e complemente o conteúdo das mudanças"

# Melhoria gradual da qualidade
gh pr ready
"Após confirmação da qualidade, altere para Ready for Review"
```

### Exemplos Básicos

```bash
# 1. Criação de branch e commit
git checkout main && git pull
git checkout -b feat-user-profile
git add . && git commit -m "feat: implementação da funcionalidade de perfil do usuário"
git push -u origin feat-user-profile

# 2. Criação de PR
"Crie um PR seguindo os seguintes passos:
1. Confirme o conteúdo das mudanças com git diff --cached
2. Crie a descrição usando .github/PULL_REQUEST_TEMPLATE.md
3. Selecione até 3 rótulos apropriados baseados no conteúdo das mudanças
4. Crie como Draft PR (mantenha comentários HTML)"

# 3. Tornar Ready após confirmação do CI
"Quando o CI passar, altere o PR para Ready for Review"
```

### Procedimento de Execução

#### 1. Criação de Branch

```bash
# Regras de nomenclatura seguindo diretrizes: {type}-{subject}
git checkout main
git pull
git checkout -b feat-user-authentication

# Confirmação de branch (exibe o nome da branch atual)
git branch --show-current
```

#### 2. Commit

```bash
# Stage das mudanças
git add .

# Mensagem de commit seguindo diretrizes
git commit -m "feat: implementação da API de autenticação do usuário"
```

#### 3. Push para Remote

```bash
# Push inicial (configuração upstream)
git push -u origin feat-user-authentication

# A partir da segunda vez
git push
```

#### 4. Criação de Draft PR por Análise Automática

**Step 1: Análise do Conteúdo das Mudanças**

```bash
# Obtenção de mudanças nos arquivos (confirma mudanças em stage)
git diff --cached --name-only

# Análise de conteúdo (máximo 1000 linhas)
git diff --cached | head -1000
```

**Step 2: Geração Automática de Descrição**

```bash
# Ordem de prioridade no processamento de templates
# 1. Descrição de PR existente (manter completamente)
# 2. .github/PULL_REQUEST_TEMPLATE.md
# 3. Template padrão

cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
# Complementar apenas seções vazias mantendo comentários HTML e linhas separadoras
```

**Step 3: Seleção Automática de Rótulos**

```bash
# Obtenção de rótulos disponíveis (não interativo)
"Obtenha os rótulos disponíveis de .github/labels.yml ou do repositório GitHub e selecione automaticamente rótulos apropriados baseados no conteúdo das mudanças"

# Seleção automática por correspondência de padrão (máximo 3)
# - Documentação: *.md, docs/ → documentation|docs
# - Teste: test, spec → test|testing
# - Correção de bug: fix|bug → bug|fix
# - Nova funcionalidade: feat|feature → feature|enhancement
```

**Step 4: Criação de PR com GitHub API (Mantendo Comentários HTML)**

```bash
# Criação de PR
"Crie um Draft PR com as seguintes informações:
- Título: geração automática a partir da mensagem de commit
- Descrição: use .github/PULL_REQUEST_TEMPLATE.md e preencha adequadamente
- Rótulos: seleção automática baseada no conteúdo das mudanças (máximo 3)
- Branch base: main
- Mantenha completamente os comentários HTML"
```

**Método B: GitHub MCP (Fallback)**

```javascript
// Criação de PR mantendo comentários HTML
mcp_github_create_pull_request({
  owner: "organization",
  repo: "repository",
  base: "main",
  head: "feat-user-authentication",
  title: "feat: implementação da autenticação do usuário",
  body: prBodyContent, // conteúdo completo incluindo comentários HTML
  draft: true,
  maintainer_can_modify: true,
});
```

### Sistema de Seleção Automática de Rótulos

#### Determinação Baseada em Padrão de Arquivos

- **Documentação**: `*.md`, `README`, `docs/` → `documentation|docs|doc`
- **Teste**: `test`, `spec` → `test|testing`
- **CI/CD**: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`
- **Dependências**: `package.json`, `pubspec.yaml` → `dependencies|deps`

#### Determinação Baseada em Conteúdo das Mudanças

- **Correção de bug**: `fix|bug|error|crash|corrigir` → `bug|fix`
- **Nova funcionalidade**: `feat|feature|add|implement|novo|adicionar` → `feature|enhancement|feat`
- **Refatoração**: `refactor|clean|refatorar|limpar` → `refactor|cleanup|clean`
- **Performance**: `performance|perf|optimize` → `performance|perf`
- **Segurança**: `security|secure` → `security`

#### Restrições

- **Máximo 3**: limite superior da seleção automática
- **Apenas rótulos existentes**: criação de novos proibida
- **Correspondência parcial**: determinação por inclusão de palavras-chave

### Diretrizes do Projeto

#### Postura Básica

1. **Sempre iniciar como Draft**: todos os PRs são criados no estado Draft
2. **Melhoria gradual da qualidade**: Fase 1 (implementação básica) → Fase 2 (adição de testes) → Fase 3 (atualização de documentação)
3. **Rótulos apropriados**: sempre adicionar até 3 tipos de rótulos
4. **Uso de template**: sempre usar `.github/PULL_REQUEST_TEMPLATE.md`
5. **Espaços em japonês**: sempre espaço em branco entre japonês e caracteres alfanuméricos

#### Regras de Nomenclatura de Branch

```text
{type}-{subject}

Exemplos:
- feat-user-profile
- fix-login-error
- refactor-api-client
```

#### Mensagem de Commit

```text
{type}: {description}

Exemplos:
- feat: implementação da API de autenticação do usuário
- fix: correção do erro de login
- docs: atualização do README
```

### Sistema de Processamento de Template

#### Ordem de Prioridade de Processamento

1. **Descrição de PR existente**: **seguir completamente** o conteúdo já descrito
2. **Template do projeto**: manter estrutura `.github/PULL_REQUEST_TEMPLATE.md`
3. **Template padrão**: quando os acima não existem

#### Regras de Manutenção de Conteúdo Existente

- **Não alterar nem um caractere**: conteúdo já descrito
- **Complementar apenas seções vazias**: preencher partes de placeholder com conteúdo das mudanças
- **Manter comentários funcionais**: manter `<!-- Copilot review rule -->`, etc.
- **Manter comentários HTML**: manter completamente `<!-- ... -->`
- **Manter linhas separadoras**: manter estruturas como `---`

#### Método para Manutenção de Comentários HTML

**Importante**: O GitHub CLI (`gh pr edit`) faz escape automático de comentários HTML, podendo resultar em strings inválidas como `EOF < /dev/null` durante o processamento do shell.

**Soluções fundamentais**:

1. **Usar opção --field da GitHub API**: manter comentários HTML com processamento de escape adequado
2. **Simplificar processamento de template**: evitar processamento complexo de pipe e redirecionamento
3. **Abordagem de manutenção completa**: abolir processamento de remoção de comentários HTML e manter template completamente

### Resposta a Comentários de Revisão

```bash
# Re-commit após mudanças
git add .
git commit -m "fix: correções baseadas no feedback da revisão"
git push
```

### Observações

#### Importância da Manutenção de Comentários HTML

- **Limitações do GitHub CLI**: `gh pr edit` faz escape de comentários HTML, mistura strings inválidas
- **Solução fundamental**: processamento de escape adequado com opção `--field` da GitHub API
- **Manutenção completa do template**: abolir processamento de remoção de comentários HTML e manter estrutura completamente

#### Restrições da Automação

- **Proibição de novos rótulos**: não é possível criar rótulos fora da definição `.github/labels.yml`
- **Máximo 3 rótulos**: limite superior da seleção automática
- **Prioridade do conteúdo existente**: não alterar absolutamente nada do conteúdo escrito manualmente

#### Melhoria Gradual da Qualidade

- **Draft obrigatório**: todos os PRs iniciam como Draft
- **Confirmação do CI**: confirmar estado com `gh pr checks`
- **Transição para Ready**: `gh pr ready` após confirmação da qualidade
- **Conformidade completa com template**: manter estrutura específica do projeto
