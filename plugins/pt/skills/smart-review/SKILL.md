---
description: "Sugerir automaticamente papel e abordagem ideais"
---

## Smart Review

Comando que analisa a situação atual e sugere automaticamente o papel e abordagem ideais.

### Uso

```bash
/smart-review                    # Analisa diretório atual
/smart-review <arquivo/diretório> # Analisa alvo específico
```

### Lógica de determinação automática

### Determinação por extensão de arquivo

- `package.json`, `*.tsx`, `*.jsx`, `*.css`, `*.scss` → **frontend**
- `Dockerfile`, `docker-compose.yml`, `*.yaml` → **architect**
- `*.test.js`, `*.spec.ts`, `test/`, `__tests__/` → **qa**
- `*.rs`, `Cargo.toml`, `performance/` → **performance**

### Detecção de arquivos relacionados à segurança

- `auth.js`, `security.yml`, `.env`, `config/auth/` → **security**
- `login.tsx`, `signup.js`, `jwt.js` → **security + frontend**
- `api/auth/`, `middleware/auth/` → **security + architect**

### Padrões de determinação complexa

- `mobile/` + `*.swift`, `*.kt`, `react-native/` → **mobile**
- `webpack.config.js`, `vite.config.js`, `large-dataset/` → **performance**
- `components/` + `responsive.css` → **frontend + mobile**
- `api/` + `auth/` → **security + architect**

### Análise de erros e problemas

- Stack trace, `error.log`, `crash.log` → **analyzer**
- `memory leak`, `high CPU`, `slow query` → **performance + analyzer**
- `SQL injection`, `XSS`, `CSRF` → **security + analyzer**

### Padrões de sugestão

### Sugestão de papel único

```bash
$ /smart-review src/auth/login.js
→ "Arquivo de autenticação detectado"
→ "Recomenda-se análise com papel security"
→ "Executar? [y]es / [n]o / [m]ore options"
```

### Sugestão de múltiplos papéis

```bash
$ /smart-review src/mobile/components/
→ "📱🎨 Elementos mobile + frontend detectados"
→ "Abordagem recomendada:"
→ "[1] Papel mobile individual"
→ "[2] Papel frontend individual"
→ "[3] multi-role mobile,frontend"
→ "[4] role-debate mobile,frontend"
```

### Sugestão durante análise de problemas

```bash
$ /smart-review error.log
→ "⚠️ Log de erro detectado"
→ "Iniciando análise de causa raiz com papel analyzer"
→ "[Execução automática] /role analyzer"

$ /smart-review slow-api.log
→ "🐌 Problema de performance detectado"
→ "Recomendado: [1]/role performance [2]/role-debate performance,analyzer"
```

### Sugestão para decisões de design complexas

```bash
$ /smart-review architecture-design.md
→ "🏗️🔒⚡ Elementos arquitetura + segurança + performance detectados"
→ "Para decisão de design complexa, recomenda-se formato de debate"
→ "[Recomendado] /role-debate architect,security,performance"
→ "[Alternativo] /multi-role architect,security,performance"
```

### Detalhes da lógica de sugestão

### Determinação de prioridade

1. **Security** - Relacionado à autenticação, autorização, criptografia é máxima prioridade
2. **Critical Errors** - Parada do sistema, perda de dados é urgente
3. **Architecture** - Mudanças de grande escala, seleção tecnológica requer consideração cuidadosa
4. **Performance** - Conecta diretamente à experiência do usuário
5. **Frontend/Mobile** - Melhorias de UI/UX
6. **QA** - Relacionado à garantia de qualidade e testes

### Condições para recomendação de debate

- Quando 3 ou mais papéis estão relacionados
- Quando há trade-off entre segurança vs performance
- Quando inclui mudanças arquiteturais significativas
- Quando afeta tanto mobile quanto web

### Exemplos básicos

```bash
# Analisa diretório atual
/smart-review
"Sugira o papel e abordagem ideais"

# Analisa arquivo específico
/smart-review src/auth/login.js
"Sugira o método de revisão ideal para este arquivo"

# Analisa log de erro
/smart-review error.log
"Sugira a abordagem ideal para resolver este erro"
```

### Exemplos práticos

### Análise do projeto inteiro

```bash
$ /smart-review
→ "📊 Analisando projeto..."
→ "Projeto React + TypeScript detectado"
→ "Confirmada funcionalidade de autenticação + API + suporte móvel"
→ ""
→ "💡 Workflow recomendado:"
→ "1. Verificação do sistema de autenticação com security"
→ "2. Avaliação de UI/UX com frontend"
→ "3. Verificação de otimização móvel com mobile"
→ "4. Revisão do design geral com architect"
→ ""
→ "Executar automaticamente? [y]es / [s]elect role / [c]ustom"
```

### Análise de problema específico

```bash
$ /smart-review "Como configurar o tempo de validade do JWT"
→ "🤔 Decisão de design técnico detectada"
→ "É um problema que requer múltiplas perspectivas especializadas"
→ ""
→ "Abordagem recomendada:"
→ "/role-debate security,performance,frontend"
→ "Motivo: Importante o equilíbrio entre segurança, performance e UX"
```

### Integração com Claude

```bash
# Análise combinada com conteúdo do arquivo
cat src/auth/middleware.js
/smart-review
"Analise incluindo o conteúdo deste arquivo sob perspectiva de segurança"

# Análise combinada com erro
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
"Sugira método de resolução para erro de build"

# Consulta de design
/smart-review
"Debata se devemos escolher React Native ou Progressive Web App"
```

### Observações

- As sugestões são informações de referência. A decisão final deve ser tomada pelo usuário
- Para problemas complexos, recomenda-se formato de debate (role-debate)
- Para problemas simples, single role é suficiente na maioria dos casos
- Para questões relacionadas à segurança, sempre se recomenda verificação com papel especializado
