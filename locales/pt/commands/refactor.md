## Refactor

Realiza refatoração segura e gradual de código, avaliando quantitativamente a aderência aos princípios SOLID. Visualiza dívida técnica e clarifica as prioridades de melhoria.

### Uso

```bash
# Identificação de código complexo e planejamento de refatoração
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"Refatorar arquivos grandes para reduzir complexidade"

# Detecção e unificação de código duplicado
grep -r "function processUser" . --include="*.js"
"Unificar funções duplicadas com Extract Method"

# Detecção de violações dos princípios SOLID
grep -r "class.*Service" . --include="*.js" | head -10
"Avaliar se essas classes seguem o princípio da responsabilidade única"
```

### Exemplos Básicos

```bash
# Detecção de métodos longos
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"Dividir métodos com mais de 50 linhas usando Extract Method"

# Complexidade de ramificação condicional
grep -r "if.*if.*if" . --include="*.js"
"Melhorar condicionais aninhadas com padrão Strategy"

# Detecção de code smells
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"Resolver comentários que se tornaram dívida técnica"
```

### Técnicas de Refatoração

#### Extract Method (Extração de Método)

```javascript
// Antes: método extenso
function processOrder(order) {
  // 50 linhas de processamento complexo
}

// Depois: separação de responsabilidades
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### Replace Conditional with Polymorphism

```javascript
// Antes: declaração switch
function getPrice(user) {
  switch (user.type) {
    case "premium":
      return basePrice * 0.8;
    case "regular":
      return basePrice;
  }
}

// Depois: padrão Strategy
class PremiumPricing {
  calculate(basePrice) {
    return basePrice * 0.8;
  }
}
```

### Pontuação dos Princípios SOLID (0-100 pontos)

#### Critérios de Avaliação e Pontuação

```text
S - Single Responsibility (20 pontos)
├─ Número de responsabilidades da classe: 1 (20 pts) | 2 (15 pts) | 3 (10 pts) | 4+ (5 pts)
├─ Número de métodos: <7 (+5 pts) | 7-15 (+3 pts) | >15 (0 pts)
├─ Clareza do motivo de mudança: Clara (+5 pts) | Ambígua (0 pts)
└─ Exemplo: UserService(autenticação+processamento de dados) = 10 pontos

O - Open/Closed (20 pontos)
├─ Pontos de extensão: Strategy/Template Method (20 pts) | Apenas herança (10 pts) | Nenhum (5 pts)
├─ Mudanças no código existente ao adicionar funcionalidades: Desnecessárias (+5 pts) | Mínimas (+3 pts) | Necessárias (0 pts)
├─ Uso de interfaces: Apropriado (+5 pts) | Parcial (+3 pts) | Nenhum (0 pts)
└─ Exemplo: PaymentProcessor(Strategy) = 20 pontos

L - Liskov Substitution (20 pontos)
├─ Aderência ao contrato das classes derivadas: Completa (20 pts) | Parcial (10 pts) | Violação (0 pts)
├─ Fortalecimento de pré-condições: Nenhum (+5 pts) | Presente (-5 pts)
├─ Enfraquecimento de pós-condições: Nenhum (+5 pts) | Presente (-5 pts)
└─ Exemplo: Square extends Rectangle = 0 pontos (violação)

I - Interface Segregation (20 pontos)
├─ Tamanho da interface: 1-3 métodos (20 pts) | 4-7 (15 pts) | 8+ (5 pts)
├─ Implementação de métodos não utilizados: Nenhum (+5 pts) | 1-2 (+2 pts) | 3+ (0 pts)
├─ Clareza do papel: Papel único (+5 pts) | Múltiplos papéis (0 pts)
└─ Exemplo: Separação Readable/Writable = 20 pontos

D - Dependency Inversion (20 pontos)
├─ Direção da dependência: Apenas abstração (20 pts) | Mista (10 pts) | Apenas concreta (5 pts)
├─ Uso de DI: Constructor Injection (+5 pts) | Setter (+3 pts) | Nenhum (0 pts)
├─ Testabilidade: Mock possível (+5 pts) | Difícil (0 pts)
└─ Exemplo: Repository Pattern = 20 pontos

Pontuação Total = S + O + L + I + D
├─ 90-100 pontos: Excellent (Aderência completa ao SOLID)
├─ 70-89 pontos: Good (Pequena margem para melhoria)
├─ 50-69 pontos: Fair (Refatoração recomendada)
├─ 30-49 pontos: Poor (Melhoria em grande escala necessária)
└─ 0-29 pontos: Critical (Revisão de design obrigatória)
```

### Quantificação da Dívida Técnica

#### Fórmula de Cálculo da Dívida

```text
Dívida Técnica (tempo) = Pontuação de Complexidade × Escopo de Impacto × Dificuldade de Correção

Pontuação de Complexidade:
├─ Complexidade ciclomática: 1-5(baixa) | 6-10(média) | 11-20(alta) | 21+(perigosa)
├─ Complexidade cognitiva: Profundidade de aninhamento × Número de ramificações condicionais
├─ Linhas de código: <50(1 pt) | 50-200(2 pts) | 200-500(3 pts) | 500+(5 pts)
└─ Taxa de duplicação: 0-10%(1 pt) | 10-30%(2 pts) | 30-50%(3 pts) | 50%+(5 pts)

Escopo de Impacto:
├─ Número de módulos dependentes: Dependência direta + Dependência indireta × 0.5
├─ Frequência de uso: Número de chamadas API/dia
├─ Importância do negócio: Critical(×3) | High(×2) | Medium(×1) | Low(×0.5)
└─ Conhecimento da equipe: 1 pessoa entende(×3) | 2-3 pessoas(×2) | 4+ pessoas(×1)

Dificuldade de Correção:
├─ Cobertura de testes: 0%(×3) | <50%(×2) | 50-80%(×1.5) | >80%(×1)
├─ Documentação: Nenhuma(×2) | Insuficiente(×1.5) | Suficiente(×1)
├─ Dependências: Acoplamento forte(×3) | Moderado(×2) | Fraco(×1)
└─ Risco de mudança: Breaking Change(×3) | Consideração de compatibilidade(×2) | Seguro(×1)

Conversão de Custo:
├─ Custo de tempo: Tempo de dívida × Salário por hora do desenvolvedor
├─ Perda de oportunidade: Dias de atraso no desenvolvimento de novas funcionalidades × Impacto na receita diária
├─ Custo de qualidade: Probabilidade de ocorrência de bug × Custo de correção × Frequência de ocorrência
└─ Custo total: Tempo + Perda de oportunidade + Custo de qualidade
```

#### Matriz de Prioridades

| Prioridade                          | Impacto | Custo de Correção | Prazo de Resposta  | Exemplo Concreto                                                        | Ação Recomendada                                               |
| ----------------------------------- | ------- | ----------------- | ------------------ | ----------------------------------------------------------------------- | -------------------------------------------------------------- |
| **Critical (Resposta Imediata)**    | Alto    | Baixo             | Dentro de 1 semana | God Object, dependências circulares                                     | Iniciar refatoração imediatamente                              |
| **Important (Resposta Planejada)**  | Alto    | Alto              | Dentro de 1 mês    | Separação de responsabilidades em grande escala, mudanças arquiteturais | Incluir no planejamento de sprint                              |
| **Watch (Objeto de Monitoramento)** | Baixo   | Alto              | Dentro de 3 meses  | Processamento interno de alta complexidade                              | Monitoramento de métricas, resposta quando houver deterioração |
| **Acceptable (Faixa Aceitável)**    | Baixo   | Baixo             | Não necessário     | Code smells menores                                                     | Resposta através de refatoração normal                         |

### Procedimento de Refatoração

1. **Análise e Medição Atual**
   - Medição de complexidade (ciclomática・cognitiva)
   - Cálculo de pontuação SOLID (0-100 pontos)
   - Quantificação de dívida técnica (tempo/custo)
   - Criação de matriz de prioridades

2. **Execução Gradual**
   - Pequenos passos (unidades de 15-30 minutos)
   - Execução de testes após cada mudança
   - Commits frequentes
   - Medição contínua de pontuação SOLID

3. **Confirmação de Qualidade**
   - Manutenção de cobertura de testes
   - Medição de desempenho
   - Confirmação de redução de dívida técnica
   - Revisão de código

### Code Smells Comuns e Pontuação de Dívida

| Code Smell              | Critério de Detecção                   | Pontuação de Dívida | Técnica de Melhoria          |
| ----------------------- | -------------------------------------- | ------------------- | ---------------------------- |
| **God Object**          | Responsabilidades >3, métodos >20      | Alta (15-20h)       | Extract Class, aplicação SRP |
| **Long Method**         | Linhas >50, complexidade >10           | Média (5-10h)       | Extract Method               |
| **Duplicate Code**      | Taxa de duplicação >30%                | Alta (10-15h)       | Extract Method/Class         |
| **Large Class**         | Linhas >300, métodos >15               | Alta (10-20h)       | Extract Class                |
| **Long Parameter List** | Parâmetros >4                          | Baixa (2-5h)        | Parameter Object             |
| **Feature Envy**        | Referências a outras classes >5        | Média (5-10h)       | Move Method                  |
| **Data Clumps**         | Repetição do mesmo grupo de argumentos | Baixa (3-5h)        | Extract Class                |
| **Primitive Obsession** | Uso excessivo de tipos primitivos      | Média (5-8h)        | Replace with Object          |
| **Switch Statements**   | case >5                                | Média (5-10h)       | Strategy Pattern             |
| **Shotgun Surgery**     | Locais de impacto na mudança >3        | Alta (10-15h)       | Move Method/Field            |

### Exemplo Prático: Avaliação de Pontuação SOLID

```javascript
// Objeto de avaliação: classe UserService
class UserService {
  constructor(db, cache, logger, emailService) { // 4 dependências
    this.db = db;
    this.cache = cache;
    this.logger = logger;
    this.emailService = emailService;
  }

  // Responsabilidade 1: autenticação
  authenticate(username, password) { /* ... */ }
  refreshToken(token) { /* ... */ }

  // Responsabilidade 2: gerenciamento de usuário
  createUser(data) { /* ... */ }
  updateUser(id, data) { /* ... */ }
  deleteUser(id) { /* ... */ }

  // Responsabilidade 3: notificação
  sendWelcomeEmail(user) { /* ... */ }
  sendPasswordReset(email) { /* ... */ }
}

// Resultado da avaliação de pontuação SOLID
S: 10 pontos (3 responsabilidades: autenticação, CRUD, notificação)
O: 5 pontos (sem pontos de extensão, implementação direta)
L: 15 pontos (sem herança, não aplicável)
I: 10 pontos (interface não segregada)
D: 10 pontos (dependência de classe concreta)
Total: 50 pontos (Fair - refatoração recomendada)

// Dívida técnica
Complexidade: 15 (7 métodos, 3 responsabilidades)
Escopo de impacto: 8 (autenticação usada em todas as funcionalidades)
Dificuldade de correção: 2 (testes existentes, documentação insuficiente)
Tempo de dívida: 15 × 8 × 2 = 240 horas
Prioridade: Critical (sistema de autenticação requer resposta imediata)
```

### Exemplo de Implementação Após Melhoria

```javascript
// Após aplicação dos princípios SOLID (Pontuação: 90 pontos)

// S: responsabilidade única (20 pontos)
class AuthenticationService {
  authenticate(credentials) { /* ... */ }
  refreshToken(token) { /* ... */ }
}

// O: aberto/fechado (20 pontos)
class UserRepository {
  constructor(storage) { // Strategy Pattern
    this.storage = storage;
  }
  save(user) { return this.storage.save(user); }
}

// I: segregação de interface (20 pontos)
interface Readable {
  find(id);
  findAll();
}
interface Writable {
  save(entity);
  delete(id);
}

// D: inversão de dependência (20 pontos)
class UserService {
  constructor(
    private auth: IAuthService,
    private repo: IUserRepository,
    private notifier: INotificationService
  ) {}
}

// Redução de dívida: 240 horas → 20 horas (redução de 92%)
```

### Suporte de Automação

```bash
# Medição de pontuação SOLID
npx solid-analyzer src/ --output report.json

# Análise de complexidade
npx complexity-report src/ --format json
sonar-scanner -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info

# Visualização de dívida técnica
npx code-debt-analyzer --config .debt.yml

# Formatação de código
npm run lint:fix
prettier --write src/

# Execução de testes e cobertura
npm test -- --coverage
npm run test:mutation  # teste de mutação
```

### Observações

- **Proibição de mudança funcional**: Não alterar comportamento externo
- **Test First**: Adicionar testes antes da refatoração
- **Abordagem gradual**: Não fazer grandes mudanças de uma só vez
- **Verificação contínua**: Execução de testes em cada etapa
