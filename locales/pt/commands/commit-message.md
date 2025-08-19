## Commit Message

Gera mensagens de commit apropriadas a partir de mudanças staged (git diff --staged). Não executa comandos git, apenas gera mensagens e copia para a área de transferência.

### Uso

```bash
/commit-message [opções]
```

### Opções

- `--format <formato>` : Especifica formato da mensagem (conventional, gitmoji, angular)
- `--lang <idioma>` : Força especificação do idioma da mensagem (en, pt)
- `--breaking` : Detecção e descrição de Breaking Change

### Exemplos Básicos

```bash
# Gerar mensagem a partir de mudanças staged (detecção automática de idioma)
# O candidato principal é automaticamente copiado para a área de transferência
/commit-message

# Forçar especificação de idioma
/commit-message --lang pt
/commit-message --lang en

# Detectar Breaking Change
/commit-message --breaking
```

### Pré-requisitos

**Importante**: Este comando analisa apenas mudanças staged. É necessário fazer staging das mudanças com `git add` previamente.

```bash
# Se não houver staging, será exibido um aviso
$ /commit-message
Não há mudanças staged. Execute git add primeiro.
```

### Função Automática de Área de Transferência

O candidato principal gerado é automaticamente copiado para a área de transferência no formato completo `git commit -m "mensagem"`. Pode ser colado diretamente no terminal para execução.

**Atenção na implementação**:

- Ao passar comando de commit para `pbcopy`, execute em processo separado da saída da mensagem
- Use `printf` em vez de `echo` para evitar quebra de linha no final

### Detecção Automática de Convenções do Projeto

**Importante**: Se existirem convenções específicas do projeto, elas têm prioridade.

#### 1. Verificação de Configuração CommitLint

Detecção automática a partir dos seguintes arquivos:

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
# Busca por arquivos de configuração
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

#### 2. Detecção de Tipos Customizados

Exemplo de tipos específicos do projeto:

```javascript
// commitlint.config.mjs
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
        'wip',      // em andamento
        'hotfix',   // correção urgente
        'release',  // release
        'deps',     // atualização de dependências
        'config'    // mudança de configuração
      ]
    ]
  }
}
```

#### 3. Detecção de Configuração de Idioma

```javascript
// Quando o projeto usa mensagens em japonês
export default {
  rules: {
    'subject-case': [0],  // Desabilitado para suporte ao japonês
    'subject-max-length': [2, 'always', 72]  // Ajuste de limite de caracteres para japonês
  }
}
```

#### 4. Análise de Histórico de Commits Existentes

```bash
# Aprendizado de padrões de uso a partir de commits recentes
git log --oneline -50 --pretty=format:"%s"

# Estatísticas de tipos utilizados
git log --oneline -100 --pretty=format:"%s" | \
grep -oE '^[a-z]+(\([^)]+\))?' | \
sort | uniq -c | sort -nr
```

### Detecção Automática de Idioma

Alternância automática entre japonês/inglês baseada nas seguintes condições:

1. Verificação de configuração de idioma nas **configurações CommitLint**
2. Julgamento automático através de **análise do git log**
3. Configurações de idioma de **arquivos do projeto**
4. Análise de comentários e strings **dentro de arquivos modificados**

O padrão é inglês. Quando identificado como projeto japonês, gera em japonês.

### Formato da Mensagem

#### Conventional Commits (padrão)

```
<type>: <description>
```

**Importante**: Sempre gera mensagem de commit de 1 linha. Não gera mensagens de múltiplas linhas.

**Nota**: Se existirem convenções específicas do projeto, elas têm prioridade.

### Tipos Padrão

**Tipos obrigatórios**:

- `feat`: Nova funcionalidade (adição de funcionalidade visível ao usuário)
- `fix`: Correção de bug

**Tipos opcionais**:

- `build`: Mudanças no sistema de build ou dependências externas
- `chore`: Outras mudanças (que não afetam o release)
- `ci`: Mudanças em arquivos de configuração ou scripts de CI
- `docs`: Mudanças apenas na documentação
- `style`: Mudanças que não afetam o significado do código (espaços, formatação, ponto e vírgula, etc.)
- `refactor`: Mudanças no código que não envolvem correção de bug ou adição de funcionalidade
- `perf`: Melhoria de performance
- `test`: Adição ou correção de testes

### Exemplo de Saída (Projeto em Inglês)

```bash
$ /commit-message

📝 Sugestão de mensagem de commit
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidato principal:
feat: implement JWT-based authentication system

📋 Alternativas:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

✅ `git commit -m "feat: implement JWT-based authentication system"` copiado para a área de transferência
```

**Exemplo de implementação (versão corrigida)**:

```bash
# Copiar comando de commit para área de transferência primeiro (sem quebra de linha)
printf 'git commit -m "%s"' "$COMMIT_MESSAGE" | pbcopy

# Depois exibir mensagem
cat << EOF
📝 Sugestão de mensagem de commit
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidato principal:
$COMMIT_MESSAGE

📋 Alternativas:
1. ...
2. ...
3. ...

✅ \`git commit -m "$COMMIT_MESSAGE"\` copiado para a área de transferência
EOF
```

### Exemplo de Saída (Projeto em Japonês)

```bash
$ /commit-message

📝 Sugestão de mensagem de commit
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidato principal:
feat: implementar sistema de autenticação JWT

📋 Alternativas:
1. feat: adicionar autenticação de usuário com token JWT
2. fix: resolver erro de validação de token no middleware de autenticação
3. docs: separar lógica de autenticação em módulo independente

✅ `git commit -m "feat: implementar sistema de autenticação JWT"` copiado para a área de transferência
```

### Visão Geral da Operação

1. **Análise**: Analisar conteúdo de `git diff --staged`
2. **Geração**: Gerar mensagem de commit apropriada
3. **Cópia**: Copiar candidato principal automaticamente para a área de transferência

**Nota**: Este comando não executa git add ou git commit. Apenas gera mensagem de commit e copia para a área de transferência.

### Funcionalidades Inteligentes

#### 1. Classificação Automática do Conteúdo das Mudanças (apenas arquivos staged)

- Adição de novo arquivo → `feat`
- Padrão de correção de erro → `fix`
- Apenas arquivos de teste → `test`
- Mudança de arquivo de configuração → `chore`
- Atualização de README/docs → `docs`

#### 2. Detecção Automática de Convenções do Projeto

- Arquivo `.gitmessage`
- Convenções dentro de `CONTRIBUTING.md`
- Padrões de histórico de commits anteriores

#### 3. Detalhes da Detecção de Idioma (apenas mudanças staged)

```bash
# Critérios de julgamento (ordem de prioridade)
1. Julgar idioma a partir do conteúdo de git diff --staged
2. Análise de comentários de arquivos staged
3. Análise de idioma de git log --oneline -20
4. Configuração de idioma principal do projeto
```

#### 4. Detalhes da Análise de Staging

Informações usadas para análise (apenas leitura):

- `git diff --staged --name-only` - Lista de arquivos modificados
- `git diff --staged` - Conteúdo real das mudanças
- `git status --porcelain` - Status dos arquivos

### Quando Breaking Change é Detectado

Se houver mudanças disruptivas na API:

**Inglês**:

```bash
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

ou

```bash
feat(api)!: change authentication flow
```

**Exemplo de Breaking Change**:

```bash
feat!: alterar formato de resposta da API de usuários

BREAKING CHANGE: A resposta agora inclui metadados adicionais
```

ou

```bash
feat(api)!: modificar fluxo de autenticação
```

### Melhores Práticas

1. **Adaptar ao projeto**: Seguir o idioma dos commits existentes
2. **Concisão**: Clara em até 50 caracteres
3. **Consistência**: Não misturar (se inglês, unificar em inglês)
4. **OSS**: Para open source, recomenda-se inglês
5. **Rigor de 1 linha**: Sempre fazer mensagem de commit de 1 linha (se necessária explicação detalhada, complementar no PR)

### Padrões Comuns

**Inglês**:

```
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

**Exemplo com múltiplas mudanças**:

```
feat: adicionar endpoint de registro de usuários
fix: resolver vazamento de memória no gerenciador de cache
docs: atualizar documentação da API
```

### Integração com Claude

```bash
# Usar em combinação com mudanças staged
git add -p  # Staging interativo
/commit-message
"Gere a mensagem de commit mais adequada"

# Analisar fazendo staging apenas de arquivos específicos
git add src/auth/*.js
/commit-message --lang en
"Gere mensagem adequada para mudanças relacionadas à autenticação"

# Detecção e tratamento de Breaking Change
git add -A
/commit-message --breaking
"Se houver mudança disruptiva, marque adequadamente"
```

### Observações

- **Pré-requisitos**: As mudanças devem ser previamente staged com `git add`
- **Limitações**: Mudanças não staged estão fora do escopo de análise
- **Recomendação**: Verifique previamente as convenções de commit existentes do projeto
