## PR Review

Revisão sistemática de Pull Request para garantir qualidade do código e sanidade da arquitetura.

### Como usar

```bash
# Revisão abrangente de PR
gh pr view 123 --comments
"Revise sistematicamente este PR e forneça feedback dos pontos de vista de qualidade de código, segurança e arquitetura"

# Revisão focada em segurança
gh pr diff 123
"Revise com foco em riscos de segurança e vulnerabilidades"

# Revisão do ponto de vista da arquitetura
gh pr checkout 123 && find . -name "*.js" | head -10
"Avalie a arquitetura dos pontos de vista de separação de camadas, dependências e princípios SOLID"
```

### Exemplos Básicos

```bash
# Avaliação numérica da qualidade do código
find . -name "*.js" -exec wc -l {} + | sort -rn | head -5
"Avalie a complexidade do código, tamanho das funções e grau de duplicação e aponte pontos de melhoria"

# Verificação de vulnerabilidades de segurança
grep -r "password\|secret\|token" . --include="*.js" | head -10
"Verifique riscos de vazamento de informações confidenciais, hardcoding e bypass de autenticação"

# Detecção de violações de arquitetura
grep -r "import.*from.*\.\./\.\." . --include="*.js"
"Avalie problemas de violação de camadas, dependências circulares e acoplamento"
```

### Sistema de Classificação de Comentários

```
🔴 critical.must: Problemas críticos
├─ Vulnerabilidades de segurança
├─ Problemas de integridade de dados
└─ Risco de falha do sistema

🟡 high.imo: Melhorias de alta prioridade
├─ Risco de mau funcionamento
├─ Problemas de performance
└─ Grande redução da manutenibilidade

🟢 medium.imo: Melhorias de prioridade média
├─ Melhoria da legibilidade
├─ Melhoria da estrutura do código
└─ Melhoria da qualidade dos testes

🟢 low.nits: Observações menores
├─ Padronização de estilo
├─ Correção de typos
└─ Adição de comentários

🔵 info.q: Perguntas e Fornecimento de informações
├─ Confirmação de intenção da implementação
├─ Contexto de decisões de design
└─ Compartilhamento de melhores práticas
```

### Pontos de Vista da Revisão

#### 1. Precisão do Código

- **Erros lógicos**: Valores limite, verificação Null, tratamento de exceções
- **Integridade de dados**: Segurança de tipo, validação
- **Tratamento de erros**: Abrangência, processamento adequado

#### 2. Segurança

- **Autenticação e Autorização**: Verificação adequada, gestão de permissões
- **Validação de entrada**: Contramedidas SQL injection, XSS
- **Informações confidenciais**: Proibição de output em logs, criptografia

#### 3. Performance

- **Algoritmos**: Complexidade temporal, eficiência de memória
- **Banco de dados**: Consultas N+1, otimização de índices
- **Recursos**: Vazamentos de memória, utilização de cache

#### 4. Arquitetura

- **Separação de camadas**: Direção de dependência, separação adequada
- **Grau de acoplamento**: Baixo acoplamento, utilização de interfaces
- **Princípios SOLID**: Responsabilidade única, aberto-fechado, inversão de dependência

### Fluxo de Revisão

1. **Verificação prévia**: Informações do PR, diferenças de mudanças, Issues relacionadas
2. **Verificação sistemática**: Segurança → Precisão → Performance → Arquitetura
3. **Feedback construtivo**: Propostas de melhoria específicas e exemplos de código
4. **Follow-up**: Confirmação de correções, estado do CI, aprovação final

### Exemplos de Comentários Eficazes

**Problemas de Segurança**

```markdown
**critical.must.** Senha está sendo armazenada em texto plano

```javascript
// Proposta de correção
const bcrypt = require('bcrypt');
const hashedPassword = await bcrypt.hash(password, 12);
```

Hashing é obrigatório para prevenir riscos de segurança.

```

**Melhoria de Performance**
```markdown
**high.imo.** Problema de consulta N+1 irá ocorrer

```javascript
// Proposta de melhoria: Eager Loading
const users = await User.findAll({ include: [Post] });
```

Pode reduzir drasticamente o número de consultas.

```

**Violação de Arquitetura**
```markdown
**high.must.** Violação de camada está ocorrendo

A camada de domínio está dependendo diretamente da camada de infraestrutura.
Introduza interfaces com o princípio de inversão de dependência.
```

### Observações

- **Tom construtivo**: Comunicação colaborativa, não agressiva
- **Propostas específicas**: Apresentar soluções, não apenas apontar problemas
- **Priorização**: Responder na ordem Critical → High → Medium → Low
- **Melhoria contínua**: Transformar resultados de revisão em base de conhecimento
