## Analyze Performance

Analisa o desempenho da aplicação sob a perspectiva da experiência do usuário e quantifica as melhorias de velocidade percebida através de otimizações. Calcula pontuações UX baseadas em Core Web Vitals e propõe estratégias de otimização priorizadas.

### Pontuação de Performance UX

```text
Pontuação de Experiência do Usuário: B+ (78/100)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏱️ Core Web Vitals
├─ LCP (carregamento): 2.3s [Bom] Meta<2.5s ✅
├─ INP (resposta): 95ms [Bom] Meta<200ms ✅
├─ CLS (estabilidade): 0.08 [Bom] Meta<0.1 ✅
├─ FCP (primeiro desenho): 1.8s [Bom] Meta<1.8s ✅
├─ TTFB (servidor): 450ms [Precisa melhorar] Meta<200ms ⚠️
└─ TTI (interativo): 3.5s [Precisa melhorar] Meta<3.8s ⚠️

📊 Velocidade Percebida pelo Usuário
├─ Exibição inicial: 2.3s [Média da indústria: 3.0s]
├─ Transição de página: 1.1s [Média da indústria: 1.5s]
├─ Exibição resultados busca: 0.8s [Média da indústria: 1.2s]
├─ Envio de formulário: 1.5s [Média da indústria: 2.0s]
└─ Carregamento de imagens: lazy loading implementado ✅

😊 Previsão de Satisfação do Usuário
├─ Previsão taxa de rejeição: 12% (média da indústria: 20%)
├─ Previsão taxa de conclusão: 78% (objetivo: 85%)
├─ NPS recomendado: +24 (média da indústria: +15)
└─ Taxa de retorno: 65% (objetivo: 70%)

📊 Impacto na Experiência do Usuário
├─ Acelerar exibição 0.5s → taxa rejeição -7%
├─ Reduzir taxa rejeição 5% → duração sessão +15%
├─ Melhorar busca → tempo permanência +15%
└─ Melhoria UX geral: +25%

🎯 Efeitos Esperados de Melhoria (ordem de prioridade)
├─ [P0] Melhoria TTFB (introduzir CDN) → LCP -0.3s = velocidade percebida +15%
├─ [P1] Otimização bundle JS → TTI -0.8s = tempo interativo -20%
├─ [P2] Otimização imagens (WebP) → volume transferência -40% = tempo carregamento -25%
└─ [P3] Estratégia cache → 50% mais rápido em visitas repetidas
```

### Uso

```bash
# Análise integral da pontuação UX
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
「Calcular pontuação de performance UX e avaliar Core Web Vitals」

# Detecção de gargalos de performance
grep -r "for.*await\|forEach.*await" . --include="*.js"
「Detectar gargalos de processamento assíncrono e analisar impacto na experiência do usuário」

# Análise de impacto na experiência do usuário
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
「Analisar o impacto de problemas de performance na experiência do usuário」
```

### Exemplos Básicos

```bash
# Tamanho de bundle e tempo de carregamento
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"Identificar pontos de melhoria no tamanho do bundle e otimização de assets"

# Performance de banco de dados
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"Analisar pontos de otimização de consultas de banco de dados"

# Impacto de performance das dependências
npm outdated && npm audit
"Avaliar o impacto de dependências desatualizadas no desempenho"
```

### Perspectivas de Análise

#### 1. Problemas no Nível de Código

- **Algoritmos O(n²)**: Detecção de operações de array ineficientes
- **I/O síncrono**: Identificação de processos bloqueantes
- **Processamento duplicado**: Remoção de cálculos e requests desnecessários
- **Vazamentos de memória**: Gestão de event listeners e timers

#### 2. Problemas no Nível de Arquitetura

- **Consultas N+1**: Padrões de acesso ao banco de dados
- **Falta de cache**: Cálculos repetidos e chamadas API
- **Tamanho de bundle**: Bibliotecas desnecessárias e divisão de código
- **Gestão de recursos**: Uso de connection pools e threads

#### 3. Impacto da Dívida Técnica

- **Código legacy**: Degradação de performance por implementações antigas
- **Problemas de design**: Alto acoplamento por falta de distribuição de responsabilidades
- **Falta de testes**: Falta de detecção de regressões de performance
- **Falta de monitoramento**: Sistema de detecção precoce de problemas

### Matriz ROI de Melhoria de Performance

```text
ROI de melhoria = (efeito redução tempo + melhoria qualidade) ÷ horas implementação
```

| Prioridade                          | Melhoria Experiência Usuário | Dificuldade Implementação | Efeito Redução Tempo | Exemplo Concreto    | Horas | Efeito            |
| ----------------------------------- | ---------------------------- | ------------------------- | -------------------- | ------------------- | ----- | ----------------- |
| **[P0] Implementar imediatamente**  | Alta                         | Baixa                     | > 50%                | Introduzir CDN      | 8h    | Resposta -60%     |
| **[P1] Implementar em breve**       | Alta                         | Média                     | 20-50%               | Otimizar imagens    | 16h   | Carregamento -30% |
| **[P2] Implementar planejadamente** | Baixa                        | Alta                      | 10-20%               | Divisão código      | 40h   | Inicial -15%      |
| **[P3] Reter/observar**             | Baixa                        | Baixa                     | < 10%                | Otimizações menores | 20h   | Parcial -5%       |

#### Critérios de Determinação de Prioridade

- **P0 (implementar imediatamente)**: Melhoria UX "Alta" × Dificuldade "Baixa" = ROI máximo
- **P1 (implementar em breve)**: Melhoria UX "Alta" × Dificuldade "Média" = ROI alto
- **P2 (planejadamente)**: Melhoria UX "Baixa" × Dificuldade "Alta" = ROI médio
- **P3 (reter)**: Melhoria UX "Baixa" × Dificuldade "Baixa" = ROI baixo

### Correlação entre Métricas de Performance e Melhoria UX

| Métrica                | Faixa Melhoria | Melhoria Velocidade Percebida | Satisfação Usuário        | Horas Implementação |
| ---------------------- | -------------- | ----------------------------- | ------------------------- | ------------------- |
| **LCP (carregamento)** | -0.5s          | +30%                          | Taxa rejeição -7%         | 16h                 |
| **INP (resposta)**     | -50ms          | +15%                          | Estresse -20%             | 8h                  |
| **CLS (estabilidade)** | -0.05          | +10%                          | Operação errônea -50%     | 4h                  |
| **TTFB (servidor)**    | -200ms         | +25%                          | Velocidade percebida +40% | 24h                 |
| **TTI (interativo)**   | -1.0s          | +35%                          | Taxa conclusão +15%       | 32h                 |
| **Tamanho bundle**     | -30%           | +20%                          | Primeira visita +25%      | 16h                 |

### Medição e Ferramentas

#### Node.js / JavaScript

```bash
# Profiling
node --prof app.js
clinic doctor -- node app.js

# Análise de bundle
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### Banco de Dados

```sql
-- Análise de consultas
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```

#### Frontend

```bash
# Performance React
grep -r "useMemo\|useCallback" . --include="*.jsx"

# Análise de recursos
find ./src -name "*.png" -o -name "*.jpg" | xargs ls -lh
```

### Melhoria Contínua

- **Auditoria regular**: Execução de testes de performance semanais
- **Coleta de métricas**: Rastreamento de tempo de resposta e uso de memória
- **Configuração de alertas**: Notificação automática quando limites são excedidos
- **Compartilhamento com equipe**: Documentação de casos de melhoria e antipadrões
