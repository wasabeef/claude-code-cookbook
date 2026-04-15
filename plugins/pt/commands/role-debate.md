# Debate multi-papel para explorar compromissos

Comando onde diferentes papéis especializados debatem, consideram trade-offs e derivam soluções ótimas.

## Uso

```bash
/role-debate <papel 1>,<papel 2> [tópico]
/role-debate <papel 1>,<papel 2>,<papel 3> [tópico]
```

## Exemplos básicos

```bash
# Trade-off entre Segurança vs Performance
/role-debate security,performance
"Sobre configuração de tempo de validade do token JWT"

# Equilíbrio entre Usabilidade vs Segurança
/role-debate frontend,security
"Sobre otimização de UX para autenticação de dois fatores"

# Discussão de seleção tecnológica
/role-debate architect,mobile
"Sobre escolha entre React Native vs Flutter"

# Debate entre 3 papéis
/role-debate architect,security,performance
"Sobre prós e contras da arquitetura de microsserviços"
```

## Princípios básicos do debate

### Fundamentos do debate construtivo

- **Respeito mútuo**: Respeitar a especialização e perspectiva de outros papéis
- **Baseado em fatos**: Debate baseado em dados e evidências, não em objeções emocionais
- **Orientado à solução**: Buscar melhores soluções, não crítica pela crítica
- **Foco na implementação**: Propostas considerando viabilidade, não apenas teorias ideais

### Requisitos qualitativos da argumentação

- **Documentação oficial**: Referência a padrões, diretrizes e documentação oficial
- **Casos de prova**: Citação específica de casos de sucesso e fracasso
- **Avaliação quantitativa**: Comparação por números e indicadores sempre que possível
- **Consideração temporal**: Avaliação de impactos de curto, médio e longo prazo

### Ética do debate

- **Honestidade**: Reconhecer também os limites da própria área de especialização
- **Abertura**: Flexibilidade para novas informações e perspectivas
- **Transparência**: Clarificação de bases de julgamento e condições prévias
- **Responsabilidade**: Mencionar também os riscos de implementação das propostas

## Processo de debate

## Fase 1: Declaração de posição inicial

Cada papel expressa opinião independentemente de perspectiva especializada

- Apresentação de proposta recomendada
- Clarificação de padrões e documentos como base
- Explicação de riscos e desafios previstos
- Definição de indicadores de sucesso

## Fase 2: Debate mútuo e refutação

Debate cruzado entre papéis

- Objeções construtivas às propostas de outros papéis
- Apontamento de perspectivas negligenciadas
- Clarificação de trade-offs
- Apresentação de alternativas

## Fase 3: Busca de pontos de compromisso

Busca por soluções implementáveis

- Avaliação de importância de cada perspectiva
- Consideração de soluções Win-Win
- Abordagem de implementação em fases
- Consideração de medidas de redução de riscos

## Fase 4: Conclusão integrada

Determinação de recomendações finais

- Solução acordada
- Roadmap de implementação
- Indicadores de sucesso e métodos de medição
- Pontos de revisão futura

## Exemplo de formato de saída

## Caso de debate entre 2 papéis

```text
Debate de Papéis: Security vs Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Tópico: Configuração de tempo de validade do token JWT

Alegação do papel Security:
"Recomendo tempo de validade curto de 15 minutos"

Base:
- Conformidade com OWASP JWT Security Cheat Sheet
- Minimização da janela de tempo de danos em caso de vazamento do token
- Limitação do tempo disponível para atacantes

Preocupações:
- Tempo de validade longo aumenta exponencialmente o risco de ataque
- Requisitos de compliance (setor financeiro) exigem tempo curto obrigatoriamente

Indicadores de sucesso:
- Taxa de ocorrência de incidentes de segurança < 0,1%
- Tempo médio de detecção de ataques < 5 minutos

Contra-argumento do papel Performance:
"Recomendo tempo de validade de 2 horas"

Base:
- Referência ao Google OAuth 2.0 Best Practices
- Evitar aumento da carga do servidor por reautenticação frequente
- Minimização da experiência do usuário (interrupção do trabalho)

Preocupações:
- Reautenticação a intervalos de 15 minutos aumenta carga da API em 8 vezes
- Desconexões frequentes em ambientes móveis

Indicadores de sucesso:
- Manter tempo de resposta da API < 200ms
- Uso de CPU do servidor < 60%

Debate mútuo:
Security → Performance:
"A perda comercial de violação de segurança é maior que a carga do servidor.
Exemplo: Incidente Equifax resultou em perda de 700 milhões de dólares"

Performance → Security:
"É possível compatibilizar ambos com mecanismo de refresh token.
Garantia de segurança sem prejudicar UX através de atualização em background"

Security → Performance:
"Refresh token também é alvo de ataque. Implementação adequada é pré-requisito"

Performance → Security:
"Proponho abordagem em fases. Operações normais 30 min, operações confidenciais 15 min"

Busca de pontos de compromisso:
Entendimento comum:
- Necessária compatibilização entre experiência do usuário e segurança
- Resposta flexível de acordo com nível de risco
- Consideração realista de custos de implementação e operação

Elementos Win-Win:
- Utilização de mecanismo de refresh token
- Introdução em fases de autenticação baseada em risco
- Complementação com função de logout automático

Conclusão integrada:
"30 min de validade + refresh token + autenticação baseada em risco"

Detalhes da implementação:
1. Access token: 30 min de validade
2. Refresh token: 7 dias de validade
3. Operações de alto risco: reautenticação forçada em 15 min
4. Logout automático após 30 min sem operação

Implementação em fases:
Semana 1-2: Implementação básica de token de 30 min
Semana 3-4: Adição de mecanismo de refresh token
Mês 2: Introdução de autenticação baseada em risco

Indicadores de sucesso:
- Segurança: Taxa de ocorrência de incidentes < 0,1%
- Performance: Taxa de aumento de carga da API < 20%
- UX: Satisfação do usuário > 85%

Revisão futura:
- Após 3 meses: Avaliar padrões de ataque reais e situação de carga
- Após 6 meses: Considerar migração para autenticação baseada em risco mais refinada
```

## Caso de debate entre 3 papéis

```text
Debate de Papéis: Architect vs Security vs Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Tópico: Prós e contras da arquitetura de microsserviços

Alegação do papel Architect:
"Recomendo microsserviços em fases"
Base: Clarificação de fronteiras de domínio, deploy independente, liberdade de escolha tecnológica

Preocupação do papel Security:
"Complexificação da segurança da comunicação entre serviços"
Base: Custos de gerenciamento de API Gateway, mTLS, autenticação distribuída

Preocupação do papel Performance:
"Aumento de latência por comunicação de rede"
Base: Problema N+1 por chamadas de API internas, transações distribuídas

Debate entre 3 papéis:
Architect → Security: "Possível controle por gerenciamento centralizado com API Gateway"
Security → Architect: "Risco de se tornar ponto único de falha"
Performance → Architect: "Importante a granularidade da divisão de serviços"
...(continuação do debate)

Conclusão integrada:
"Divisão em fases por Domain-Driven Design + design security-first"
```

## Padrões de debate eficazes

## Seleção tecnológica

```bash
/role-debate architect,performance
"Escolha de banco de dados: PostgreSQL vs MongoDB"

/role-debate frontend,mobile
"Framework de UI: React vs Vue"

/role-debate security,architect
"Método de autenticação: JWT vs Session Cookie"
```

## Decisões de design

```bash
/role-debate security,frontend
"Design de UX para autenticação de usuário"

/role-debate performance,mobile
"Otimização de estratégia de sincronização de dados"

/role-debate architect,qa
"Estratégia de teste e design de arquitetura"
```

## Problemas de trade-off

```bash
/role-debate security,performance
"Nível de criptografia vs velocidade de processamento"

/role-debate frontend,performance
"UI rica vs velocidade de carregamento da página"

/role-debate mobile,security
"Conveniência vs nível de proteção de dados"
```

## Características de debate por papel

### 🔒 Papel Security

```yaml
Postura de debate:
  - Abordagem conservadora (minimização de riscos)
  - Foco em conformidade com regras (cauteloso com desvios de padrões)
  - Suposição de pior caso (perspectiva do atacante)
  - Foco em impacto de longo prazo (segurança como dívida técnica)

Pontos típicos:
  - Trade-off "segurança vs conveniência"
  - "Cumprimento obrigatório de requisitos de compliance"
  - "Comparação custo de ataque vs custo de defesa"
  - "Proteção completa de privacidade"

Fontes de argumentação:
  - Diretrizes OWASP
  - Framework NIST
  - Padrões da indústria (ISO 27001, SOC 2)
  - Casos e estatísticas de ataques reais

Pontos fortes no debate:
  - Precisão na avaliação de riscos
  - Conhecimento de requisitos regulamentares
  - Entendimento de métodos de ataque

Preconceitos a serem observados:
  - Conservadorismo excessivo (obstáculo à inovação)
  - Falta de consideração pela UX
  - Subestimação de custos de implementação
```

### ⚡ Papel Performance

```yaml
Postura de debate:
  - Decisões orientadas por dados (baseadas em medições)
  - Foco em eficiência (otimização custo-benefício)
  - Prioridade na experiência do usuário (foco na velocidade percebida)
  - Melhoria contínua (otimização em fases)

Pontos típicos:
  - "Performance vs segurança"
  - "ROI do custo vs efeito da otimização"
  - "Escalabilidade atual vs futura"
  - "Experiência do usuário vs eficiência do sistema"

Fontes de argumentação:
  - Métricas Core Web Vitals
  - Resultados de benchmark e estatísticas
  - Dados de impacto no comportamento do usuário
  - Padrões de performance da indústria

Pontos fortes no debate:
  - Capacidade de avaliação quantitativa
  - Identificação de gargalos
  - Conhecimento de técnicas de otimização

Preconceitos a serem observados:
  - Subestimação da segurança
  - Falta de consideração pela manutenibilidade
  - Otimização prematura
```

### 🏗️ Papel Architect

```yaml
Postura de debate:
  - Foco na perspectiva de longo prazo (consideração da evolução do sistema)
  - Busca de equilíbrio (otimização global)
  - Mudanças graduais (gestão de riscos)
  - Conformidade com padrões (prioridade de padrões testados)

Pontos típicos:
  - "Eficiência de curto prazo vs manutenibilidade de longo prazo"
  - "Dívida técnica vs velocidade de desenvolvimento"
  - "Microsserviços vs monólito"
  - "Adoção de novas tecnologias vs estabilidade"

Fontes de argumentação:
  - Coleção de padrões de arquitetura
  - Princípios de design (SOLID, DDD)
  - Casos de sistemas de grande escala
  - Tendências de evolução tecnológica

Pontos fortes no debate:
  - Capacidade de visão global
  - Conhecimento de padrões de design
  - Previsão de impactos de longo prazo

Preconceitos a serem observados:
  - Generalização excessiva
  - Conservadorismo com novas tecnologias
  - Falta de compreensão de detalhes de implementação
```

### 🎨 Papel Frontend

```yaml
Postura de debate:
  - Design centrado no usuário (prioridade máxima na UX)
  - Abordagem inclusiva (consideração da diversidade)
  - Foco na intuitividade (minimização do custo de aprendizado)
  - Padrões de acessibilidade (conformidade WCAG)

Pontos típicos:
  - "Usabilidade vs segurança"
  - "Unificação de design vs otimização de plataforma"
  - "Funcionalidade vs simplicidade"
  - "Performance vs experiência rica"

Fontes de argumentação:
  - Resultados de pesquisa UX e testes de usabilidade
  - Diretrizes de acessibilidade
  - Padrões de sistema de design
  - Dados de comportamento do usuário

Pontos fortes no debate:
  - Defesa da perspectiva do usuário
  - Conhecimento de princípios de design
  - Requisitos de acessibilidade

Preconceitos a serem observados:
  - Falta de compreensão de restrições técnicas
  - Subestimação de requisitos de segurança
  - Subestimação do impacto na performance
```

### 📱 Papel Mobile

```yaml
Postura de debate:
  - Especialização em plataforma (consideração de diferenças iOS/Android)
  - Adaptação contextual (uso em movimento, operação com uma mão)
  - Restrições de recursos (bateria, memória, comunicação)
  - Conformidade com lojas (diretrizes de revisão)

Pontos típicos:
  - "Nativo vs multiplataforma"
  - "Suporte offline vs sincronização em tempo real"
  - "Eficiência da bateria vs funcionalidade"
  - "Unificação vs otimização de plataforma"

Fontes de argumentação:
  - iOS HIG / Android Material Design
  - Diretrizes App Store / Google Play
  - Pesquisa UX móvel
  - Estatísticas de performance de dispositivos

Pontos fortes no debate:
  - Compreensão de restrições específicas móveis
  - Conhecimento de diferenças de plataforma
  - Design de interface touch

Preconceitos a serem observados:
  - Falta de compreensão de plataformas web
  - Subestimação de restrições do lado servidor
  - Falta de consideração por ambientes desktop
```

### 🔍 Papel Analyzer

```yaml
Postura de debate:
  - Foco em evidências (data-first)
  - Verificação de hipóteses (abordagem científica)
  - Pensamento estrutural (pensamento sistêmico)
  - Remoção de vieses (busca de objetividade)

Pontos típicos:
  - "Correlação vs causalidade"
  - "Tratamento sintomático vs solução fundamental"
  - "Distinção entre hipótese vs fato"
  - "Sintomas de curto prazo vs problemas estruturais"

Fontes de argumentação:
  - Dados de medição real e análise de logs
  - Métodos estatísticos e resultados de análise
  - Teoria do pensamento sistêmico
  - Pesquisa sobre vieses cognitivos

Pontos fortes no debate:
  - Capacidade de análise lógica
  - Objetividade na avaliação de evidências
  - Descoberta de problemas estruturais

Preconceitos a serem observados:
  - Paralisia analítica (falta de capacidade de ação)
  - Perfeccionismo (subestimação da praticidade)
  - Supremacia dos dados
```

## Template de condução do debate

### Template da Fase 1: Declaração de posição

```text
Proposta recomendada do 【Nome do Papel】:
"[proposta específica]"

Base:
- [referência a documentos/padrões oficiais]
- [casos de prova/dados]
- [princípios da área especializada]

Efeitos esperados:
- [efeitos de curto prazo]
- [efeitos de médio a longo prazo]

Preocupações/Riscos:
- [riscos de implementação]
- [riscos operacionais]
- [impactos em outras áreas]

Indicadores de sucesso:
- [indicador mensurável 1]
- [indicador mensurável 2]
```

### Template da Fase 2: Refutação

```text
Contra-argumento para [Papel Alvo]:
"[contra-argumento específico à proposta alvo]"

Base da refutação:
- [perspectiva negligenciada]
- [evidências/casos conflitantes]
- [preocupações da área especializada]

Proposta alternativa:
"[proposta melhorada]"

Pontos de possível compromisso:
- [condições aceitáveis]
- [possibilidade de implementação em fases]
```

### Template da Fase 3: Solução integrada

```text
Proposta de solução integrada:
"[proposta final considerando preocupações de cada papel]"

Considerações para cada papel:
- [Security]: [método de satisfação dos requisitos de segurança]
- [Performance]: [método de satisfação dos requisitos de performance]
- [Outros]: [método de satisfação de outros requisitos]

Roadmap de implementação:
- Fase 1 (imediato): [itens de resposta urgente]
- Fase 2 (curto prazo): [implementação básica]
- Fase 3 (médio prazo): [implementação completa]

Indicadores de sucesso/Métodos de medição:
- [indicadores integrados de sucesso]
- [métodos/frequência de medição]
- [timing de revisão]
```

## Checklist de qualidade do debate

### Qualidade da argumentação

- [ ] Há referência a documentos/padrões oficiais
- [ ] Casos específicos e dados são apresentados
- [ ] Suposições e fatos são claramente distinguidos
- [ ] Fontes de informação são especificadas

### Construtividade do debate

- [ ] Compreende corretamente a proposta do oponente
- [ ] Contra-argumentos lógicos, não emocionais
- [ ] Também apresenta propostas alternativas
- [ ] Busca possibilidades Win-Win

### Viabilidade de implementação

- [ ] Considera viabilidade técnica
- [ ] Estima custos e prazos de implementação
- [ ] Considera possibilidade de implementação em fases
- [ ] Apresenta medidas de redução de riscos

### Integração

- [ ] Considera impactos em outras áreas
- [ ] Busca otimização global
- [ ] Inclui perspectiva de longo prazo
- [ ] Define indicadores de sucesso mensuráveis

## Integração com Claude

```bash
# Debate baseado em documentos de design
cat system-design.md
/role-debate architect,security
"Debata sobre questões de segurança neste design"

# Debate de soluções baseado em problemas
cat performance-issues.md
/role-debate performance,architect
"Debata sobre soluções fundamentais para problemas de performance"

# Debate de seleção tecnológica baseado em requisitos
/role-debate mobile,frontend
"Debata sobre estratégia de UI unificada para iOS, Android e Web"
```

## Observações

- Debates podem levar tempo (tópicos complexos levam mais tempo)
- Com 3 ou mais papéis, o debate pode se dispersar
- A decisão final deve ser tomada pelo usuário com base nos resultados do debate
- Para problemas de alta urgência, considere primeiro single role ou multi-role
