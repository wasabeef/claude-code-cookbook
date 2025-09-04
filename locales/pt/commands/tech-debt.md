## Tech Debt

Analisa quantitativamente a dívida técnica do projeto e visualiza as pontuações de saúde junto com o impacto na eficiência de desenvolvimento. Acompanha melhorias mediante análise de tendências, calcula custos temporais e cria um plano de melhoria priorizado.

### Uso

```bash
# Verificar configuração do projeto para analisar dívida técnica
ls -la
"Analisar a dívida técnica deste projeto e criar um plano de melhoria"
```

### Painel de Saúde do Projeto

```
Pontuação de Saúde do Projeto: 72/100
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Pontuações por Categoria
├─ Frescor das dependências: ████████░░ 82% (Atualizadas: 45/55)
├─ Completude da documentação: ███░░░░░░░ 35% (Faltam README, docs API)
├─ Cobertura de testes: ██████░░░░ 65% (Meta: 80%)
├─ Segurança: ███████░░░ 78% (Vulnerabilidades: 2 Medium)
├─ Arquitetura: ██████░░░░ 60% (Dependências circulares: 3 lugares)
└─ Qualidade do código: ███████░░░ 70% (Complexidade alta: 12 arquivos)

📈 Tendências (últimos 30 dias)
├─ Pontuação geral: 68 → 72 (+4) ↗️
├─ Itens melhorados: 12 ✅
├─ Nova dívida: 3 ⚠️
├─ Dívida resolvida: 8 🎉
└─ Velocidade de melhoria: +0.13/dia

⏱️ Impacto temporal da dívida
├─ Desaceleração do desenvolvimento: -20% (desenvolvimento de novas funcionalidades leva 1.25x o tempo normal)
├─ Tempo de correção de bugs: +15% (tempo médio de correção 2h → 2.3h)
├─ Revisão de código: +30% (tempo adicional por complexidade)
├─ Onboarding: +50% (tempo necessário para novos membros entenderem)
└─ Tempo de atraso acumulado: Equivalente a 40 horas/semana

🎯 Efeitos esperados da melhoria (baseados em tempo)
├─ Efeito imediato: Velocidade de desenvolvimento +10% (após 1 semana)
├─ Efeito a curto prazo: Taxa de bugs -25% (após 1 mês)
├─ Efeito a médio prazo: Velocidade de desenvolvimento +30% (após 3 meses)
├─ Efeito a longo prazo: Tempo de manutenção -50% (após 6 meses)
└─ ROI: Investimento 40 horas → Recuperação 120 horas (3 meses)
```

### Exemplos Básicos

```bash
# Análise detalhada da pontuação de saúde
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Calcular a pontuação de saúde do projeto e avaliar por categorias"

# Análise de impacto de dívida de TODO/FIXME
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"Avaliar estes TODOs por impacto de dívida (tempo×importância)"

# Verificação de saúde das dependências
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"Calcular pontuação de frescor das dependências e analisar riscos e efeitos de atualizações"
```

### Colaboração com Claude

```bash
# Análise integral de dívida técnica
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"Analisar a dívida técnica deste projeto sob essas perspectivas:
1. Qualidade do código (complexidade, duplicação, manutenibilidade)
2. Saúde das dependências
3. Riscos de segurança
4. Problemas de desempenho
5. Falta de cobertura de testes"

# Análise de dívida arquitetural
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"Identificar dívida técnica no nível arquitetural e propor um plano de refatoração"

# Plano de melhoria priorizado
"Avaliar a dívida técnica segundo esses critérios e apresentar em formato de tabela:
- Impacto (Alto/Médio/Baixo)
- Custo de correção (tempo)
- Risco técnico (possibilidade de falha do sistema, perda de dados)
- Efeito de redução de tempo por melhoria
- Momento recomendado de implementação"
```

### Exemplos Detalhados

```bash
# Detecção automática do tipo de projeto e análise
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"Baseado no tipo de projeto detectado, analisar:
1. Dívida técnica específica da linguagem/framework
2. Desvios das melhores práticas
3. Oportunidades de modernização
4. Estratégia de melhoria gradual"

# Análise de métricas de qualidade do código
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"Analisar a qualidade do código do projeto e apresentar essas métricas:
- Funções com alta complexidade ciclomática
- Detecção de código duplicado
- Arquivos/funções muito longos
- Falta de tratamento de erro adequado"

# Detecção de dívida de segurança
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"Detectar dívida técnica relacionada à segurança e propor prioridade de correção e contramedidas"

# Análise de falta de testes
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"Analisar a dívida técnica de cobertura de testes e propor estratégia de testes"
```

### Matriz de Prioridades da Dívida

```
Prioridade = (Impacto × Frequência) ÷ Custo de correção
```

| Prioridade                 | Impacto no desenvolvimento | Custo de correção | Efeito de redução de tempo | Retorno do investimento       | Prazo de resposta  |
| -------------------------- | -------------------------- | ----------------- | -------------------------- | ----------------------------- | ------------------ |
| **[P0] Resposta imediata** | Alto                       | Baixo             | > 5x                       | Investimento 1h→Redução 5h+   | Imediato           |
| **[P1] Esta semana**       | Alto                       | Médio             | 2-5x                       | Investimento 1h→Redução 2-5h  | Dentro de 1 semana |
| **[P2] Este mês**          | Baixo                      | Alto              | 1-2x                       | Investimento 1h→Redução 1-2h  | Dentro de 1 mês    |
| **[P3] Este trimestre**    | Baixo                      | Baixo             | < 1x                       | Investimento=tempo de redução | Dentro de 3 meses  |

### Critérios de Avaliação por Tipo de Dívida

| Tipo de dívida                    | Método de detecção                        | Impacto no desenvolvimento                          | Tempo de correção |
| --------------------------------- | ----------------------------------------- | --------------------------------------------------- | ----------------- |
| **Dívida arquitetural**           | Dependências circulares, alto acoplamento | Grande escopo de impacto em mudanças, teste difícil | 40-80h            |
| **Dívida de segurança**           | Scan CVE, OWASP                           | Risco de vulnerabilidades, conformidade             | 8-40h             |
| **Dívida de desempenho**          | N+1, vazamentos de memória                | Aumento tempo de resposta, consumo de recursos      | 16-40h            |
| **Dívida de testes**              | Cobertura < 60%                           | Detecção tardia de bugs, qualidade instável         | 20-60h            |
| **Dívida de documentação**        | Falta README, docs API                    | Tempo de onboarding aumentado                       | 8-24h             |
| **Dívida de dependências**        | Não atualizadas por 2+ anos               | Risco de segurança, problemas de compatibilidade    | 4-16h             |
| **Dívida de qualidade do código** | Complexidade > 10                         | Tempo de compreensão/correção aumentado             | 2-8h              |

### Cálculo de Impacto da Dívida Técnica

```
Impacto = Σ(peso de cada elemento × valor medido)

📊 Indicadores de impacto mensuráveis:
├─ Impacto na velocidade de desenvolvimento
│  ├─ Tempo de compreensão do código: +X% (proporcional à complexidade)
│  ├─ Escopo de impacto em mudanças: Y arquivos (medido por acoplamento)
│  └─ Tempo de execução de testes: Z minutos (pipeline CI/CD)
│
├─ Impacto na qualidade
│  ├─ Taxa de ocorrência de bugs: +25% a cada 10 de complexidade
│  ├─ Tempo de revisão: linhas de código × coeficiente de complexidade
│  └─ Risco por falta de testes: Alto risco se cobertura < 60%
│
└─ Impacto na eficiência da equipe
   ├─ Tempo de onboarding: +100% por falta de documentação
   ├─ Concentração de conhecimento: Atenção necessária se taxa de contribuidor único >80%
   └─ Locais de correção por duplicação de código: taxa de duplicação × frequência de mudança
```

### Cálculo de ROI baseado em tempo

```
ROI = (tempo reduzido - tempo de investimento) ÷ tempo de investimento × 100

Exemplo: Resolução de dependências circulares
├─ Tempo de investimento: 16 horas (refatoração)
├─ Efeito de redução (mensal):
│  ├─ Tempo de compilação: -10 min/dia × 20 dias = 200 min
│  ├─ Tempo de debugging: -2 horas/semana × 4 semanas = 8 horas
│  └─ Adição de novas funcionalidades: -30% redução de tempo = 12 horas
├─ Tempo de redução mensal: 23.3 horas
└─ ROI em 3 meses: (70 - 16) ÷ 16 × 100 = 337%
```

### Notas

- Auto-detecta a linguagem e framework do projeto para realizar análises específicas
- Avalia a pontuação de saúde em escala de 0-100 pontos, considerando saudável 70+ pontos e necessitando melhoria <50 pontos
- Calcula custos temporais e efeitos de melhoria de forma específica, apoiando tomada de decisão baseada em dados
- Para conversão monetária, especificar separadamente o salário médio por hora da equipe ou coeficientes específicos do projeto
