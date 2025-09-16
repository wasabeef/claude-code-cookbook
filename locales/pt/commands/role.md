## Role

Alterna para uma função (role) específica para executar análises e trabalhos especializados.

### Como usar

```bash
/role <nome_do_role> [--agent|-a]
```

### Opções

- `--agent` ou `-a` : Execução independente como subagente (recomendado para análises em larga escala)
  - Quando esta opção é usada, caso a descrição do role contenha frases de promoção de delegação automática (como "use PROACTIVELY"), uma delegação automática mais agressiva será habilitada

### Roles Disponíveis

#### Roles de Análise Especializada (Integração Evidence-First)

- `security` : Especialista em auditoria de segurança (OWASP Top 10, Modelagem de ameaças, Princípios Zero Trust e Correspondência CVE)
- `performance` : Especialista em otimização de performance (Core Web Vitals, Modelo RAIL, Otimização gradual e Análise ROI)
- `analyzer` : Especialista em análise de causa raiz (5 Whys, Pensamento sistêmico, Orientação por hipóteses e Contramedidas para vieses cognitivos)
- `frontend` : Especialista em Frontend/UI/UX (WCAG 2.1, Design System e Design centrado no usuário)

#### Roles de Suporte ao Desenvolvimento

- `reviewer` : Especialista em revisão de código (Legibilidade, Manutenibilidade, Performance e Propostas de refatoração)
- `architect` : Arquiteto de sistemas (Design Evidence-First, Análise MECE e Arquitetura evolutiva)
- `qa` : Engenheiro de testes (Cobertura de testes, Estratégia E2E/integração/unitária e Propostas de automação)
- `mobile` : Especialista em desenvolvimento mobile (iOS HIG, Android Material Design e Estratégia multiplataforma)

### Exemplos Básicos

```bash
# Alternar para modo de auditoria de segurança (normal)
/role security
"Verifique as vulnerabilidades de segurança deste projeto"

# Executar auditoria de segurança com subagente (análise em larga escala)
/role security --agent
"Execute uma auditoria de segurança de todo o projeto"

# Alternar para modo de revisão de código
/role reviewer
"Revise as mudanças recentes e aponte pontos de melhoria"

# Alternar para modo de otimização de performance
/role performance
"Analise os gargalos da aplicação"

# Alternar para modo de análise de causa raiz
/role analyzer
"Investigue a causa raiz desta falha"

# Alternar para modo especializado em frontend
/role frontend
"Avalie os pontos de melhoria de UI/UX"

# Alternar para modo especializado em desenvolvimento mobile
/role mobile
"Avalie a otimização mobile desta aplicação"

# Voltar ao modo normal
/role default
"Retornando ao Claude normal"
```

### Integração com Claude

```bash
# Análise especializada em segurança
/role security
cat app.js
"Analise detalhadamente os riscos potenciais de segurança neste código"

# Avaliação do ponto de vista da arquitetura
/role architect
ls -la src/
"Apresente os problemas da estrutura atual e propostas de melhoria"

# Elaboração de estratégia de testes
/role qa
"Proponha a estratégia de testes ideal para este projeto"
```

### Exemplos Detalhados

```bash
# Análise com múltiplos roles
/role security
"Primeiro, verificação do ponto de vista de segurança"
git diff HEAD~1

/role reviewer
"Em seguida, revisão da qualidade geral do código"

/role architect
"Por último, avaliação do ponto de vista da arquitetura"

# Formato de saída específico do role
/role security
Resultado da análise de segurança
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Vulnerabilidade: SQL Injection
Gravidade: High
Local aplicável: db.js:42
Proposta de correção: Usar queries parametrizadas
```

### Funcionalidade de Integração Evidence-First

#### Filosofia Central

Cada role adota a abordagem **Evidence-First (baseada em evidências)** e realiza análises e propostas baseadas em **métodos comprovados, diretrizes oficiais e dados objetivos** em vez de especulações.

#### Características Comuns

- **Conformidade com documentação oficial**: Referência prioritária a diretrizes oficiais autoritativas de cada área
- **Análise MECE**: Decomposição sistemática de problemas sem lacunas nem sobreposições
- **Avaliação multifacetada**: Múltiplas perspectivas: técnica, negócios, operacional e usuário
- **Contramedidas para vieses cognitivos**: Mecanismo de eliminação de viés de confirmação, etc.
- **Características de discussão**: Postura de discussão especializada específica do role

### Detalhes dos Roles de Análise Especializada

#### security (Especialista em auditoria de segurança)

**Auditoria de segurança baseada em evidências**

- Avaliação sistemática por OWASP Top 10, Testing Guide e SAMM
- Verificação de vulnerabilidades conhecidas por correspondência com banco de dados CVE e NVD
- Modelagem de ameaças por STRIDE, Attack Tree e PASTA
- Avaliação de design por princípios Zero Trust e privilégios mínimos

**Formato de relatório especializado**

```text
Resultado da auditoria de segurança baseada em evidências
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Conformidade OWASP Top 10: XX% / Correspondência CVE: Concluída
Modelagem de ameaças: Análise STRIDE concluída
```

#### performance (Especialista em otimização de performance)

**Otimização de performance Evidence-First**

- Conformidade com Core Web Vitals (LCP, FID e CLS) e modelo RAIL
- Implementação de recomendações do Google PageSpeed Insights
- Processo de otimização gradual (medição → análise → priorização → implementação)
- Avaliação quantitativa do custo-benefício por análise ROI

**Formato de relatório especializado**

```text
Análise de performance Evidence-First
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Core Web Vitals: LCP[XXXms] FID[XXXms] CLS[X.XX]
Performance Budget: XX% / Análise ROI: XX% previsão de melhoria
```

#### analyzer (Especialista em análise de causa raiz)

**Análise de causa raiz Evidence-First**

- Método 5 Whys + α (incluindo consideração de contraprovas)
- Análise estrutural por pensamento sistêmico (princípios de Peter Senge)
- Contramedidas para vieses cognitivos (eliminação de viés de confirmação, ancoragem, etc.)
- Análise orientada por hipóteses rigorosa (verificação paralela de múltiplas hipóteses)

**Formato de relatório especializado**

```text
Análise de causa raiz Evidence-First
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Confiabilidade da análise: Alta / Contramedidas para viés: Implementadas
Matriz de verificação de hipóteses: XX% de confiança
```

#### frontend (Especialista em Frontend/UI/UX)

**Desenvolvimento frontend Evidence-First**

- Conformidade com acessibilidade WCAG 2.1
- Conformidade com diretrizes oficiais Material Design e iOS HIG
- Aplicação de padrões de design centrado no usuário e design system
- Verificação por testes A/B e análise de comportamento do usuário

### Detalhes dos Roles de Suporte ao Desenvolvimento

#### reviewer (Especialista em revisão de código)

- Avaliação multifacetada de legibilidade, manutenibilidade e performance
- Verificação de conformidade com convenções de codificação e propostas de refatoração
- Confirmação transversal de segurança e acessibilidade

#### architect (Arquiteto de sistemas)

- Princípios de design Evidence-First e pensamento gradual por análise MECE
- Arquitetura evolutiva e avaliação de múltiplas perspectivas (técnica, negócios, operacional e usuário)
- Referência a padrões arquiteturais oficiais e melhores práticas

#### qa (Engenheiro de testes)

- Análise de cobertura de testes e estratégia de testes E2E/integração/unitários
- Propostas de automação de testes e design de métricas de qualidade

#### mobile (Especialista em desenvolvimento mobile)

- Conformidade com diretrizes oficiais iOS HIG e Android Material Design
- Estratégia multiplataforma e design Touch-First
- Diretrizes de revisão da loja e otimização de UX específica para mobile

### Características de Discussão Específicas dos Roles

Cada role possui postura de discussão única, fonte de argumentos e pontos fortes de acordo com sua área de especialização.

#### Características de discussão do role security

- **Postura**: Abordagem conservadora, priorização da minimização de riscos e suposição do pior caso
- **Argumentos**: Diretrizes OWASP, framework NIST e casos reais de ataques
- **Pontos fortes**: Precisão na avaliação de riscos, conhecimento profundo dos requisitos regulamentares e compreensão abrangente de métodos de ataque
- **Cuidados**: Conservadorismo excessivo, falta de consideração com UX e subestimação dos custos de implementação

#### Características de discussão do role performance

- **Postura**: Decisões orientadas por dados, priorização da eficiência, priorização da experiência do usuário e melhoria contínua
- **Argumentos**: Core Web Vitals, resultados de benchmark, dados de comportamento do usuário e padrões da indústria
- **Pontos fortes**: Capacidade de avaliação quantitativa, precisão na identificação de gargalos e análise ROI
- **Cuidados**: Subestimação da segurança, falta de consideração com manutenibilidade e foco excessivo em medições

#### Características de discussão do role analyzer

- **Postura**: Priorização de evidências, verificação de hipóteses, pensamento estrutural e eliminação de vieses
- **Argumentos**: Dados de medição real, métodos estatísticos, teoria do pensamento sistêmico e pesquisa sobre vieses cognitivos
- **Pontos fortes**: Capacidade de análise lógica, objetividade na avaliação de evidências e capacidade de descobrir problemas estruturais
- **Cuidados**: Paralisia de análise, perfeccionismo, onipotência dos dados e ceticismo excessivo

#### Características de discussão do role frontend

- **Postura**: Centrado no usuário, priorização da acessibilidade, conformidade com princípios de design e priorização do valor da experiência
- **Argumentos**: Pesquisa UX, padrões de acessibilidade, design system e testes de usabilidade
- **Pontos fortes**: Perspectiva do usuário, princípios de design, acessibilidade e design de experiência
- **Cuidados**: Subestimação de restrições técnicas, falta de consideração com performance e complexidade de implementação

### Efeitos da Colaboração Multi-Role

A combinação de roles com diferentes características de discussão permite análise equilibrada:

#### Padrões Típicos de Colaboração

- **security + frontend**: Equilíbrio entre segurança e usabilidade
- **performance + security**: Compatibilidade entre velocidade e segurança
- **analyzer + architect**: Integração de análise de problemas e design estrutural
- **reviewer + qa**: Colaboração entre qualidade de código e estratégia de testes

## Funcionalidades Avançadas dos Roles

### Seleção Inteligente de Roles

- `/smart-review` : Proposta automática de roles por análise do projeto
- `/role-help` : Guia de seleção do role ideal conforme a situação

### Colaboração Multi-Role

- `/multi-role <role1>,<role2>` : Análise simultânea de múltiplos roles
- `/role-debate <role1>,<role2>` : Discussão entre roles

### Exemplos de Uso

#### Proposta Automática de Role

```bash
/smart-review
→ Analisa a situação atual e propõe o role ideal

/smart-review src/auth/
→ Recomenda role security a partir de arquivos relacionados à autenticação
```

#### Análise com Múltiplos Roles

```bash
/multi-role security,performance
"Avalie esta API de múltiplas perspectivas"
→ Análise integrada dos pontos de vista de segurança e performance

/role-debate frontend,security
"Discutam sobre UX da autenticação de dois fatores"
→ Discussão dos pontos de vista de usabilidade e segurança
```

#### Quando em Dúvida na Seleção de Role

```bash
/role-help "API está lenta e também há preocupações com segurança"
→ Propõe abordagem apropriada (multi-role ou debate)

/role-help compare frontend,mobile
→ Diferenças e uso adequado dos roles frontend e mobile
```

## Observações

### Sobre o Comportamento dos Roles

- Ao alternar roles, o **comportamento, prioridades, métodos de análise e formato de relatório** do Claude se especializa
- Cada role adota **abordagem Evidence-First** aplicando prioritariamente diretrizes oficiais e métodos comprovados
- Use `default` para retornar ao modo normal (especialização do role é cancelada)
- Os roles são válidos apenas dentro da sessão atual

### Métodos de Utilização Eficaz

- **Problemas simples**: Análise especializada com role único é suficiente
- **Problemas complexos**: multi-role ou role-debate são eficazes para análise multifacetada
- **Em caso de dúvida**: Utilize smart-review ou role-help
- **Melhoria contínua**: Mesmo com o mesmo role, a precisão da análise melhora com novas evidências e métodos

### Funcionalidade de Subagente (opção --agent)

Quando análises em larga escala ou processamento especializado independente são necessários, você pode executar roles como subagentes usando a opção `--agent`.

#### Vantagens

- **Contexto independente**: Não interfere na conversa principal
- **Execução paralela**: Possível executar múltiplas análises simultaneamente
- **Especialização**: Análises mais profundas e relatórios detalhados
- **Promoção da delegação automática**: Quando a descrição do role contém "use PROACTIVELY" ou "MUST BE USED", uma delegação automática mais agressiva é habilitada

#### Cenários de Uso Recomendados

```bash
# Segurança: Verificação de todos os itens OWASP, correspondência CVE
/role security --agent
"Auditoria de segurança de toda a base de código"

# Analisador: Análise de causa raiz de logs volumosos
/role analyzer --agent
"Analise os logs de erro da última semana"

# Revisor: Revisão detalhada de PR em larga escala
/role reviewer --agent
"Revise as 1000 linhas de mudanças do PR #500"
```

#### Role Normal vs Subagente

| Situação                | Recomendado | Comando                  |
| ----------------------- | ----------- | ------------------------ |
| Verificação simples     | Role normal | `/role security`         |
| Análise em larga escala | Subagente   | `/role security --agent` |
| Trabalho interativo     | Role normal | `/role frontend`         |
| Auditoria independente  | Subagente   | `/role qa --agent`       |

### Detalhes da Configuração dos Roles

- Configurações detalhadas, conhecimento especializado e características de discussão de cada role são definidas no diretório `.claude/agents/roles/`
- Inclui métodos Evidence-First e contramedidas para vieses cognitivos
- Modo especializado é ativado automaticamente por frases-gatilho específicas do role
- Os arquivos reais dos roles são compostos por conteúdo especializado de mais de 200 linhas
