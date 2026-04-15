# Guia para escolher o papel adequado

Guia de seleção e sistema de ajuda para quando não souber qual papel usar.

## Uso

```bash
/role-help                      # Guia geral de seleção de papéis
/role-help <situação/problema>   # Papel recomendado para situação específica
/role-help compare <papel 1>,<papel 2> # Comparação de papéis
```

## Exemplos básicos

```bash
# Orientação geral
/role-help
→ Exibe lista de papéis disponíveis e suas características

# Recomendação por situação
/role-help "Preocupado com a segurança da API"
→ Recomendação do papel security e modo de uso

# Comparação de papéis
/role-help compare frontend,mobile
→ Diferenças entre frontend e mobile e como usar cada um
```

## Guia de seleção de papéis por situação

## Relacionado à segurança

```text
Use o papel security quando:
✅ Implementação de login e autenticação
✅ Verificação de vulnerabilidades de segurança da API
✅ Criptografia de dados e proteção de privacidade
✅ Verificação de compliance de segurança
✅ Teste de invasão e penetração

Uso: /role security
```

## 🏗️ Arquitetura e design

```text
Use o papel architect quando:
✅ Avaliação do design do sistema geral
✅ Decisão entre microsserviços vs monólito
✅ Design de banco de dados e seleção tecnológica
✅ Considerações de escalabilidade e extensibilidade
✅ Avaliação de dívida técnica e planos de melhoria

Uso: /role architect
```

## ⚡ Problemas de performance

```text
Use o papel performance quando:
✅ Aplicação está lenta
✅ Otimização de consultas ao banco de dados
✅ Melhoria da velocidade de carregamento de páginas web
✅ Otimização do uso de memória e CPU
✅ Estratégias de scaling e balanceamento de carga

Uso: /role performance
```

## 🔍 Investigação de causas de problemas

```text
Use o papel analyzer quando:
✅ Análise da causa raiz de bugs e erros
✅ Investigação de causas de falhas do sistema
✅ Análise estrutural de problemas complexos
✅ Análise de dados e investigação estatística
✅ Esclarecimento de por que este problema ocorreu

Uso: /role analyzer
```

## 🎨 Frontend e UI/UX

```text
Use o papel frontend quando:
✅ Melhoria da interface do usuário
✅ Suporte à acessibilidade
✅ Design responsivo
✅ Melhoria da usabilidade e facilidade de uso
✅ Tecnologias gerais de frontend web

Uso: /role frontend
```

## 📱 Desenvolvimento de aplicativos móveis

```text
Use o papel mobile quando:
✅ Otimização de apps iOS e Android
✅ Design de UX específico para mobile
✅ Otimização de interface touch
✅ Suporte offline e funções de sincronização
✅ Suporte para App Store e Google Play

Uso: /role mobile
```

## 👀 Code review e qualidade

```text
Use o papel reviewer quando:
✅ Verificação da qualidade do código
✅ Avaliação de legibilidade e manutenibilidade
✅ Verificação de convenções de codificação
✅ Propostas de refatoração
✅ Review de PR e commits

Uso: /role reviewer
```

## 🧪 Testes e garantia de qualidade

```text
Use o papel qa quando:
✅ Planejamento de estratégias de teste
✅ Avaliação de cobertura de teste
✅ Política de implementação de testes automatizados
✅ Estratégias de prevenção de bugs e melhoria da qualidade
✅ Automação de testes em CI/CD

Uso: /role qa
```

## Quando múltiplos papéis são necessários

## 🔄 multi-role (análise paralela)

```text
Use multi-role quando:
✅ Quiser avaliação de múltiplas perspectivas especializadas
✅ Quiser criar plano de melhoria integrado
✅ Quiser comparar avaliações de cada área
✅ Quiser organizar contradições e duplicações

Exemplo: /multi-role security,performance
```

## 🗣️ role-debate (debate)

```text
Use role-debate quando:
✅ Há trade-offs entre áreas especializadas
✅ Opiniões se dividem na seleção tecnológica
✅ Quiser decidir diretrizes de design por debate
✅ Quiser ouvir debates de diferentes perspectivas

Exemplo: /role-debate security,performance
```

## 🤖 smart-review (sugestão automática)

```text
Use smart-review quando:
✅ Não souber qual papel usar
✅ Quiser conhecer a abordagem ideal para a situação atual
✅ Quiser escolher entre múltiplas opções
✅ For iniciante e estiver em dúvida

Exemplo: /smart-review
```

## Tabela de comparação de papéis

## Relacionados à segurança

| Papel    | Uso principal                    | Área forte                                 | Área fraca                               |
| -------- | -------------------------------- | ------------------------------------------ | ---------------------------------------- |
| security | Vulnerabilidades e contramedidas | Análise de ameaças, design de autenticação | UX, performance                          |
| analyzer | Análise da causa raiz            | Análise lógica, coleta de evidências       | Medidas preventivas, planejamento futuro |

## Relacionados ao design

| Papel     | Uso principal       | Área forte                                    | Área fraca                                       |
| --------- | ------------------- | --------------------------------------------- | ------------------------------------------------ |
| architect | Design de sistema   | Perspectiva de longo prazo, otimização global | Implementação detalhada, soluções de curto prazo |
| reviewer  | Qualidade do código | Nível de implementação, manutenibilidade      | Requisitos de negócio, UX                        |

## Relacionados à performance

| Papel       | Uso principal           | Área forte        | Área fraca          |
| ----------- | ----------------------- | ----------------- | ------------------- |
| performance | Aceleração e otimização | Medição, gargalos | Segurança, UX       |
| qa          | Garantia de qualidade   | Teste, automação  | Design, arquitetura |

## Relacionados à experiência do usuário

| Papel    | Uso principal | Área forte              | Área fraca    |
| -------- | ------------- | ----------------------- | ------------- |
| frontend | Web UI/UX     | Browser, acessibilidade | Servidor, DB  |
| mobile   | Mobile UX     | Touch, suporte offline  | Servidor, Web |

## Fluxograma para quando estiver em dúvida

```text
Qual é a natureza do problema?
├─ Relacionado à segurança → security
├─ Problema de performance → performance
├─ Investigação de bug/falha → analyzer
├─ Melhoria de UI/UX → frontend ou mobile
├─ Design/arquitetura → architect
├─ Qualidade do código → reviewer
├─ Relacionado a testes → qa
└─ Complexo/composto → smart-review para sugestão

Abrange múltiplas áreas?
├─ Quero análise integrada → multi-role
├─ Debate/trade-offs → role-debate
└─ Em dúvida sobre decisão → smart-review
```

## Perguntas frequentes

## Q: Qual a diferença entre frontend e mobile?

```text
A:
frontend: Foco em navegador web, HTML/CSS/JavaScript
mobile: Foco em app móvel, nativo iOS/Android, React Native etc.

Para casos relacionados a ambos, recomenda-se multi-role frontend,mobile
```

## Q: Como distinguir security e analyzer?

```text
A:
security: Prevenção de ataques e ameaças, design de segurança
analyzer: Análise de causas de problemas já ocorridos, investigação

Para investigação de incidentes de segurança: multi-role security,analyzer
```

## Q: Qual a diferença entre architect e performance?

```text
A:
architect: Design de longo prazo do sistema geral, extensibilidade
performance: Melhoria específica de velocidade e eficiência

Para design de performance de sistemas de grande escala: multi-role architect,performance
```

## Integração com Claude

```bash
# Combinação com explicação da situação
/role-help
"O carregamento da página do app React está lento e usuários estão reclamando"

# Combinação com conteúdo de arquivo
cat problem-description.md
/role-help
"Recomende o papel ideal para este problema"

# Quando estiver em dúvida sobre opções específicas
/role-help compare security,performance
"Qual papel é adequado para o problema de tempo de validade do token JWT?"
```

## Observações

- Problemas complexos são mais eficazes com combinação de múltiplos papéis
- Para casos de alta urgência, responda rapidamente com single role
- Quando estiver em dúvida, recomendamos receber sugestão automática com smart-review
- A decisão final deve ser tomada pelo usuário considerando a natureza do problema
