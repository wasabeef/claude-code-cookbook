## Tech Debt

Analisa o débito técnico do projeto e cria um plano de melhorias priorizadas.

### Como usar

```bash
# Confirma estrutura do projeto e analisa débito técnico
ls -la
"Analise o débito técnico deste projeto e crie um plano de melhorias"
```

### Exemplos Básicos

```bash
# Análise de comentários TODO/FIXME
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"Organize estes comentários TODO por prioridade e elabore um plano de melhorias"

# Confirmação de dependências do projeto
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"Analise as dependências do projeto e identifique as desatualizadas e riscos"

# Detecção de arquivos grandes e funções complexas
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -exec wc -l {} + | sort -rn | head -10
"Identifique arquivos muito grandes ou estruturas complexas e apresente propostas de melhoria"
```

### Integração com Claude

```bash
# Análise abrangente de débito técnico
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"Analise o débito técnico deste projeto dos seguintes pontos de vista:
1. Qualidade do código (complexidade, duplicação, manutenibilidade)
2. Sanidade das dependências
3. Riscos de segurança
4. Problemas de performance
5. Falta de cobertura de testes"

# Análise de débito arquitetural
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"Identifique o débito técnico em nível arquitetural e proponha um plano de refatoração"

# Plano de melhorias priorizadas
"Avalie o débito técnico pelos seguintes critérios e apresente em formato de tabela:
- Grau de impacto (alto/médio/baixo)
- Custo de correção (tempo)
- Risco de negócio
- Efeito da melhoria
- Período recomendado de implementação"
```

### Exemplos Detalhados

```bash
# Detecção automática de tipo de projeto e análise
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"Baseado no tipo de projeto detectado, analise o seguinte:
1. Débito técnico específico da linguagem e framework
2. Desvios das melhores práticas
3. Oportunidades de modernização
4. Estratégia de melhoria gradual"

# Análise de métricas de qualidade de código
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"Analise a qualidade do código do projeto e apresente as seguintes métricas:
- Funções com alta complexidade ciclomática
- Detecção de código duplicado
- Arquivos/funções muito longos
- Falta de tratamento adequado de erros"

# Detecção de débito de segurança
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"Detecte débito técnico relacionado à segurança e proponha prioridade de correção e contramedidas"

# Análise de falta de testes
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"Analise o débito técnico da cobertura de testes e proponha estratégia de testes"
```

### Observações

- Detecta automaticamente a linguagem e framework do projeto e realiza análises correspondentes
- O débito técnico é classificado em "problemas importantes que devem ser corrigidos imediatamente" e "itens para melhorar a longo prazo"
- Fornece planos realistas considerando o equilíbrio entre valor de negócio e melhorias técnicas
- Também leva em consideração o ROI (retorno sobre investimento) das melhorias
