## Design Patterns

Propõe padrões de design aplicáveis à base de código e avalia a conformidade com os princípios SOLID.

### Uso

```bash
/design-patterns [alvo-de-análise] [opções]
```

### Opções

- `--suggest` : Propor padrões aplicáveis (padrão)
- `--analyze` : Analisar uso de padrões existentes
- `--refactor` : Gerar propostas de refatoração
- `--solid` : Verificar conformidade com princípios SOLID
- `--anti-patterns` : Detectar antipadrões

### Exemplos Básicos

```bash
# Análise de padrões de todo o projeto
/design-patterns

# Proposta de padrões para arquivo específico
/design-patterns src/services/user.js --suggest

# Verificação de princípios SOLID
/design-patterns --solid

# Detecção de antipadrões
/design-patterns --anti-patterns
```

### Categorias de Análise

#### 1. Padrões de Criação

- **Factory Pattern**: Abstração da criação de objetos
- **Builder Pattern**: Construção gradual de objetos complexos
- **Singleton Pattern**: Garantia de unicidade de instância
- **Prototype Pattern**: Geração de clones de objetos

#### 2. Padrões Estruturais

- **Adapter Pattern**: Conversão de interfaces
- **Decorator Pattern**: Adição dinâmica de funcionalidades
- **Facade Pattern**: Simplificação de subsistemas complexos
- **Proxy Pattern**: Controle de acesso a objetos

#### 3. Padrões Comportamentais

- **Observer Pattern**: Implementação de notificação de eventos
- **Strategy Pattern**: Alternância de algoritmos
- **Command Pattern**: Encapsulamento de operações
- **Iterator Pattern**: Percorrer coleções

### Itens de Verificação dos Princípios SOLID

```
S - Single Responsibility Principle (Princípio da Responsabilidade Única)
O - Open/Closed Principle (Princípio Aberto/Fechado)
L - Liskov Substitution Principle (Princípio da Substituição de Liskov)
I - Interface Segregation Principle (Princípio da Segregação de Interface)
D - Dependency Inversion Principle (Princípio da Inversão de Dependência)
```

### Exemplo de Saída

```
Relatório de Análise de Design Patterns
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Padrões Atualmente em Uso
├─ Observer Pattern: EventEmitter (12 locais)
├─ Factory Pattern: UserFactory (3 locais)
├─ Singleton Pattern: DatabaseConnection (1 local)
└─ Strategy Pattern: PaymentProcessor (5 locais)

Padrões Recomendados
├─ [HIGH] Repository Pattern
│  └─ Alvo: src/models/*.js
│  └─ Motivo: Separação da lógica de acesso a dados
│  └─ Exemplo:
│      class UserRepository {
│        async findById(id) { ... }
│        async save(user) { ... }
│      }
│
├─ [MED] Command Pattern
│  └─ Alvo: src/api/handlers/*.js
│  └─ Motivo: Unificação do processamento de requisições
│
└─ [LOW] Decorator Pattern
   └─ Alvo: src/middleware/*.js
   └─ Motivo: Melhoria da combinação de funcionalidades

Violações dos Princípios SOLID
├─ [S] UserService: responsável tanto por autenticação quanto gerenciamento de permissões
├─ [O] PaymentGateway: necessária modificação ao adicionar novos métodos de pagamento
├─ [D] EmailService: depende diretamente de classes concretas
└─ [I] IDataStore: contém métodos não utilizados

Propostas de Refatoração
1. Dividir UserService em autenticação e gerenciamento de permissões
2. Introduzir interface PaymentStrategy
3. Definir interface EmailService
4. Separar IDataStore por uso
```

### Exemplos de Uso Avançado

```bash
# Análise de impacto da aplicação de padrões
/design-patterns --impact-analysis Repository

# Geração de exemplo de implementação de padrão específico
/design-patterns --generate Factory --for src/models/Product.js

# Proposta de combinação de padrões
/design-patterns --combine --context "API with caching"

# Avaliação de padrões arquiteturais
/design-patterns --architecture MVC
```

### Exemplo de Aplicação de Padrão

#### Antes (código problemático)

```javascript
class OrderService {
  processOrder(order, paymentType) {
    if (paymentType === "credit") {
      // Processamento de cartão de crédito
    } else if (paymentType === "paypal") {
      // Processamento PayPal
    }
    // Outros métodos de pagamento...
  }
}
```

#### Depois (aplicação do Strategy Pattern)

```javascript
// Interface de estratégia
class PaymentStrategy {
  process(amount) {
    throw new Error("Must implement process method");
  }
}

// Estratégia concreta
class CreditCardPayment extends PaymentStrategy {
  process(amount) {
    /* implementação */
  }
}

// Contexto
class OrderService {
  constructor(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  processOrder(order) {
    this.paymentStrategy.process(order.total);
  }
}
```

### Detecção de Antipadrões

- **God Object**: Classe com responsabilidades excessivas
- **Spaghetti Code**: Código com fluxo de controle complexamente entrelaçado
- **Copy-Paste Programming**: Uso excessivo de código duplicado
- **Magic Numbers**: Constantes hardcoded
- **Callback Hell**: Callbacks profundamente aninhados

### Melhores Práticas

1. **Aplicação gradual**: Não aplicar muitos padrões de uma vez
2. **Verificação de necessidade**: Padrões são meios para resolver problemas, não fins
3. **Consenso da equipe**: Discutir em equipe antes de aplicar padrões
4. **Documentação**: Registrar a intenção dos padrões aplicados
