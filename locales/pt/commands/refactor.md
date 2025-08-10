## Refactor

Implementa refatoração segura e gradual de código e avalia o estado de conformidade com os princípios SOLID.

### Como usar

```bash
# Identificação de código complexo e planejamento de refatoração
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"Refatore arquivos grandes para reduzir a complexidade"

# Detecção e integração de código duplicado
grep -r "function processUser" . --include="*.js"
"Unifique funções duplicadas usando Extract Method"

# Detecção de violações dos princípios SOLID
grep -r "class.*Service" . --include="*.js" | head -10
"Avalie se essas classes seguem o princípio da responsabilidade única"
```

### Exemplos Básicos

```bash
# Detecção de métodos longos
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"Divida métodos com mais de 50 linhas usando Extract Method"

# Complexidade de ramificação condicional
grep -r "if.*if.*if" . --include="*.js"
"Melhore instruções condicionais aninhadas usando padrão Strategy"

# Detecção de code smells
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"Resolva comentários que se tornaram débito técnico"
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
// Antes: instrução switch
function getPrice(user) {
  switch (user.type) {
    case 'premium': return basPrice * 0.8;
    case 'regular': return basePrice;
  }
}

// Depois: padrão Strategy
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### Verificação dos Princípios SOLID

```
S - Single Responsibility (Responsabilidade Única)
├─ Cada classe tem uma única responsabilidade
├─ Razão para mudança limitada a uma
└─ Fronteiras de responsabilidade claras

O - Open/Closed (Aberto/Fechado)
├─ Aberto para extensão
├─ Fechado para modificação
└─ Proteção do código existente ao adicionar novas funcionalidades

L - Liskov Substitution (Substituição de Liskov)
├─ Possibilidade de substituição de classes derivadas
├─ Conformidade com contratos
└─ Manutenção do comportamento esperado

I - Interface Segregation (Segregação de Interface)
├─ Interfaces com granularidade adequada
├─ Evitar dependência de métodos não utilizados
└─ Definição de interfaces por função

D - Dependency Inversion (Inversão de Dependência)
├─ Dependência de abstrações
├─ Separação de implementações concretas
└─ Utilização de injeção de dependência
```

### Procedimento de Refatoração

1. **Análise da Situação Atual**
   - Medição de complexidade (complexidade ciclomática)
   - Detecção de código duplicado
   - Análise de dependências

2. **Execução Gradual**
   - Pequenos passos (unidades de 15-30 minutos)
   - Execução de testes após cada mudança
   - Commits frequentes

3. **Confirmação de Qualidade**
   - Manutenção da cobertura de testes
   - Medição de performance
   - Revisão de código

### Code Smells Comuns

- **God Object**: Classe com responsabilidades excessivas
- **Long Method**: Método longo com mais de 50 linhas
- **Duplicate Code**: Duplicação da mesma lógica
- **Large Class**: Classe grande com mais de 300 linhas
- **Long Parameter List**: 4 ou mais parâmetros

### Suporte à Automação

```bash
# Análise estática
npx complexity-report src/
sonar-scanner

# Formatação de código
npm run lint:fix
prettier --write src/

# Execução de testes
npm test
npm run test:coverage
```

### Observações

- **Proibição de mudanças funcionais**: Não alterar o comportamento externo
- **Test-First**: Adicionar testes antes da refatoração
- **Abordagem gradual**: Não fazer grandes mudanças de uma só vez
- **Verificação contínua**: Executar testes em cada etapa
