---
description: "Analisar dependências do projeto e avaliar saúde arquitetural"
---

## Análise de Dependências

Analisa as dependências do projeto e avalia a saúde da arquitetura.

### Uso

```bash
/dependency-analysis [opções]
```

### Opções

- `--visual` : Exibe as dependências visualmente
- `--circular` : Detecta apenas dependências circulares
- `--depth <número>` : Especifica a profundidade da análise (padrão: 3)
- `--focus <caminho>` : Foca em um módulo/diretório específico

### Exemplos Básicos

```bash
# Análise completa das dependências do projeto
/dependency-analysis

# Detecção de dependências circulares
/dependency-analysis --circular

# Análise detalhada de um módulo específico
/dependency-analysis --focus src/core --depth 5
```

### Itens de Análise

#### 1. Matriz de Dependências

Exibe as dependências entre módulos de forma numerizada:

- Dependências diretas
- Dependências indiretas
- Profundidade das dependências
- Fan-in/Fan-out

#### 2. Detecção de Violações Arquiteturais

- Violações de camadas (camada inferior dependendo da superior)
- Dependências circulares
- Acoplamento excessivo (alta dependência)
- Módulos isolados

#### 3. Verificação de Conformidade com Clean Architecture

- Independência da camada de domínio
- Separação adequada da camada de infraestrutura
- Direção das dependências da camada de casos de uso
- Status da aplicação de interfaces

### Exemplo de Saída

```text
Relatório de Análise de Dependências
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Resumo de Métricas
├─ Total de módulos: 42
├─ Média de dependências: 3.2
├─ Profundidade máxima de dependências: 5
└─ Dependências circulares: 2 detectadas

⚠️  Violações Arquiteturais
├─ [HIGH] src/domain/user.js → src/infra/database.js
│  └─ Camada de domínio depende diretamente da camada de infraestrutura
├─ [MED] src/api/auth.js ⟲ src/services/user.js
│  └─ Dependência circular detectada
└─ [LOW] src/utils/helper.js → 12 módulos
   └─ Fan-out excessivo

✅ Ações Recomendadas
1. Introduzir interface UserRepository
2. Redesenhar as responsabilidades do serviço de autenticação
3. Dividir funções auxiliares por funcionalidade

📈 Gráfico de Dependências
[Exibe diagrama visual de dependências em ASCII art]
```

### Exemplos de Uso Avançado

```bash
# Verificação automática em pipeline CI/CD
/dependency-analysis --circular --fail-on-violation

# Definição e verificação de regras arquiteturais
/dependency-analysis --rules .architecture-rules.yml

# Rastreamento de mudanças nas dependências ao longo do tempo
/dependency-analysis --compare HEAD~10
```

### Exemplo de Arquivo de Configuração (.dependency-analysis.yml)

```yaml
rules:
  - name: "Domain Independence"
    source: "src/domain/**"
    forbidden: ["src/infra/**", "src/api/**"]

  - name: "API Layer Dependencies"
    source: "src/api/**"
    allowed: ["src/domain/**", "src/application/**"]
    forbidden: ["src/infra/**"]

thresholds:
  max_dependencies: 8
  max_depth: 4
  coupling_threshold: 0.7

ignore:
  - "**/test/**"
  - "**/mocks/**"
```

### Ferramentas de Integração

- `madge` : Visualização de dependências JavaScript/TypeScript
- `dep-cruiser` : Validação de regras de dependências
- `nx` : Gerenciamento de dependências em monorepo
- `plato` : Análise integrada de complexidade e dependências

### Integração com Claude

```bash
# Análise incluindo package.json
cat package.json
/analyze-dependencies
「Analise os problemas de dependências deste projeto」

# Combinando com código-fonte de módulo específico
ls -la src/core/
/analyze-dependencies --focus src/core
「Avalie em detalhes as dependências do módulo core」

# Comparação com documentação de arquitetura
cat docs/architecture.md
/analyze-dependencies --visual
「Verifique a divergência entre o documento de design e a implementação」
```

### Observações

- **Pré-requisitos**: Deve ser executado na raiz do projeto
- **Limitações**: Em projetos grandes, a análise pode demorar
- **Recomendação**: Se dependências circulares forem encontradas, considere ação imediata

### Melhores Práticas

1. **Análise regular**: Verifique a saúde das dependências semanalmente
2. **Formalização de regras**: Gerencie regras arquiteturais em arquivos de configuração
3. **Melhoria gradual**: Evite refatorações em larga escala, melhore progressivamente
4. **Rastreamento de métricas**: Monitore a complexidade das dependências ao longo do tempo
