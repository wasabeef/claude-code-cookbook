## Spec

**"Dar estrutura antes de escrever código"** - Totalmente em conformidade com o spec-driven development de Kiro

Diferente das ferramentas tradicionais de geração de código, realiza o desenvolvimento orientado por especificações de Kiro focado em dar estrutura ao caos do desenvolvimento. A partir de uma entrada mínima de requisitos, expande gradualmente desde especificações detalhadas de nível de product manager até design implementável, garantindo qualidade consistente do **protótipo ao ambiente de produção**.

### Como usar

```bash
# Solicitar Spec Mode ao Claude (entrada mínima de requisitos)
"Crie spec de [descrição da funcionalidade]"

# Expansão gradual estilo Kiro:
# 1. Requisitos simples → Geração automática de user stories detalhadas
# 2. Descrição estruturada de requisitos usando notação EARS
# 3. Refinamento de especificações através de diálogo gradual
# 4. Geração de 3 arquivos independentes:
#    - requirements.md: Definição de requisitos usando notação EARS
#    - design.md: Design incluindo diagramas Mermaid e interfaces TypeScript
#    - tasks.md: Plano de implementação com aplicação automática de boas práticas
```

### Efeitos Comprovados (Resultados do Kiro)

**Aplicativo de compartilhamento seguro de arquivos em 2 dias**

```bash
"Crie spec de sistema de compartilhamento de arquivos (com suporte a criptografia)"
→ Aplicativo de compartilhamento de arquivos criptografados de nível de produção concluído em 2 dias
→ Aplicação automática de boas práticas de segurança
→ Sem necessidade de prompts adicionais
```

**Desenvolvimento de jogo em uma noite (iniciante)**

```bash
"Crie spec de jogo de quebra-cabeça 2D"
→ Desenvolvedor de código aberto sem experiência em desenvolvimento de jogos
→ Criação de jogo concluída em uma noite
→ Kiro cuidou da lógica de implementação, desenvolvedor se concentrou na criatividade
```

**Protótipo→Produção em um fim de semana**

```bash
"Crie spec de sistema de gerenciamento de produtos para site de e-commerce"
→ Do conceito ao protótipo funcional em um fim de semana
→ Qualidade consistente do protótipo ao ambiente de produção
→ Abordagem estruturada através de spec-driven development
```

### Exemplos Básicos

```bash
# Criação de spec para nova funcionalidade (entrada mínima)
"Sistema de avaliação de produtos
- Funcionalidade de avaliação por estrelas
- Postagem de comentários
- Upload de imagens"

# Criação de spec para funcionalidade de sistema
"Autenticação de usuário
- Suporte OAuth
- Autenticação multifator"

# Criação de spec para funcionalidade de API
"API de sistema de pagamento
- Integração Stripe
- Foco em segurança"
```

### Integração com Claude

```bash
# Spec de funcionalidade complexa
"Crie spec de funcionalidade de chat. Inclua WebSocket, notificações em tempo real e gerenciamento de histórico"

# Spec de funcionalidade com integração de banco de dados
"Crie spec de funcionalidade de gerenciamento de estoque para site de e-commerce. Inclua adição de produtos, atualização de estoque e funcionalidade de alertas"

# Spec de funcionalidade de frontend
"Crie spec de dashboard React. Inclua exibição de gráficos, filtros e funcionalidade de exportação"

# Spec de funcionalidade de backend
"Crie spec de API RESTful. Inclua autenticação, validação e registro de logs"
```

### Características do Spec Mode

**Fluxo de Trabalho de Diálogo Gradual**

- Reprodução completa do diálogo gradual que é o valor original do Kiro
- Refinamento colaborativo de especificações com o usuário em cada fase
- Geração de arquivos após processo de esclarecimento de dúvidas, discussão de opções e aprovação

**Expansão Interativa em 3 Estágios**

- **Phase 1**: Requirements Discovery → Discussão → Aprovação → Geração de `requirements.md`
- **Phase 2**: Design Exploration → Discussão → Aprovação → Geração de `design.md`
- **Phase 3**: Implementation Planning → Discussão → Aprovação → Geração de `tasks.md`

**Especificação Dinâmica**

- Resolução de ambiguidades nos requisitos através de diálogo
- Apresentação e discussão de opções técnicas
- Explicação de trade-offs e confirmação de decisões

### Exemplos Detalhados

```bash
# Funcionalidade complexa de sistema
"Crie spec de sistema de pagamento online. Inclua integração Stripe, segurança e tratamento de erros"

# Funcionalidade de frontend
"Crie spec de componente React. Inclua gerenciamento de estado, design de propriedades e testes"

# Funcionalidade de backend
"Crie spec de API GraphQL. Inclua design de schema, resolvers e autenticação"

# Funcionalidade DevOps
"Crie spec de pipeline CI/CD. Inclua automação de testes, deployment e monitoramento"
```

### Fluxo de Trabalho de Diálogo Gradual (Phase by Phase)

#### Phase 1: Requirements Discovery & Discussion

**1. Expansão automática a partir de entrada mínima (estilo Kiro)**

```
Usuário: "Sistema de gerenciamento de usuários
- Funcionalidade de login
- Edição de perfil
- Permissões de administrador"

Claude: "Vou gerar user stories detalhadas a partir dos requisitos.
Esta compreensão está correta?

User Stories geradas automaticamente:
- Funcionalidade de registro e autenticação de usuários (suporte OAuth)
- Funcionalidade de gerenciamento de perfil (avatar, configurações)
- Funcionalidade de gerenciamento de permissões (RBAC)
- Funcionalidade de reset de senha
- Log de auditoria de segurança

Complementei os detalhes não explicitados. Há outras funcionalidades necessárias?"
```

**2. Descrição estruturada de requisitos usando notação EARS**

```
Claude: "Vou estruturar os requisitos com a notação EARS do Kiro:

Definição de requisitos pela notação EARS:

WHEN o usuário tenta fazer login
GIVEN que inseriu email e senha corretos
THEN o sistema confirma a autenticação
AND redireciona para o dashboard em caso de sucesso

WHILE o usuário está na tela de edição de perfil
THE SYSTEM SHALL executar validação em tempo real
AND exibir preview das mudanças

WHERE funcionalidades que requerem permissões de administrador
IS há tentativa de acesso
THE SYSTEM SHALL verificar o nível de permissão
AND negar acesso se insuficiente"
```

**3. Complementação automática de casos extremos e requisitos de segurança**

```
Claude: "Baseado nas boas práticas do Kiro, também considerei os seguintes casos:

Requisitos de segurança (complementação automática):
- Proteção contra ataques de força bruta
- Gerenciamento de sessão e timeout
- Proteção CSRF e contramedidas XSS
- Requisitos de força da senha

Casos extremos (detecção automática):
- Limitação de login simultâneo
- Funcionalidade de bloqueio de conta
- Garantia de integridade durante migração de dados
- Balanceamento de carga para grandes volumes de requisições

Estes requisitos são adequados?"
```

**5. Conclusão e aprovação da Phase 1**

```
Claude: "Requirements Phase foi concluída.
Posso gerar requirements.md?"
→ "Próximo passo" → Geração de requirements.md
```

#### Phase 2: Design Exploration & Discussion

**1. Análise de codebase + Proposta automática de design (estilo Kiro)**

```
Claude: "Vou analisar a codebase existente e propor a arquitetura ideal:

Resultado da análise da codebase:
- Autenticação: JWT + Express.js (v4.18.x)
- Banco de dados: PostgreSQL (v14+)
- Frontend: React + TypeScript (v18+)
- Padrões existentes: Repository pattern, separação de camada Service

Arquitetura recomendada pelo Kiro:
- Conformidade com Clean Architecture
- Elementos de Domain-Driven Design
- Aplicação parcial do padrão CQRS
- Boas práticas de segurança automatizadas

Proceder com este design?"
```

**2. Design visual com diagramas Mermaid**

```
Claude: "Gerei automaticamente o design de sistema com diagrama Mermaid:

Diagrama de arquitetura gerado automaticamente:

graph TB
    Client[React Client] --> API[Express API Gateway]
    API --> Auth[Auth Service]
    API --> User[User Service]
    API --> Profile[Profile Service]

    Auth --> AuthDB[(Auth Database)]
    User --> UserDB[(User Database)]
    Profile --> ProfileDB[(Profile Database)]

    Auth --> JWT[JWT Service]
    Auth --> OAuth[OAuth Provider]

Também gerar diagrama de fluxo de dados?"
```

**3. Geração automática de interfaces TypeScript**

```
Claude: "Vou gerar automaticamente interfaces TypeScript baseadas no design:

Interfaces TypeScript geradas automaticamente:

// Domain entities
interface User {
  readonly id: UserId;
  readonly email: Email;
  readonly profile: UserProfile;
  readonly auth: AuthSettings;
  readonly permissions: Permission[];
  readonly createdAt: Date;
  readonly updatedAt: Date;
}

interface UserProfile {
  readonly displayName: string;
  readonly avatar: AvatarUrl;
  readonly preferences: UserPreferences;
}

interface AuthSettings {
  readonly passwordHash: PasswordHash;
  readonly mfaEnabled: boolean;
  readonly lastLoginAt: Date;
  readonly failedAttempts: number;
}

// Use cases
interface UserRepository {
  findById(id: UserId): Promise<User | null>;
  findByEmail(email: Email): Promise<User | null>;
  save(user: User): Promise<void>;
}

interface AuthenticationService {
  authenticate(credentials: LoginCredentials): Promise<AuthResult>;
  refreshToken(token: RefreshToken): Promise<AccessToken>;
}

Proceder com este design de interface?"
```

**4. Conclusão e aprovação da Phase 2**

```

Claude: "Design Phase foi concluída.
Posso gerar design.md?"
→ "Próximo passo" → Geração de design.md

```

#### Phase 3: Implementation Planning & Discussion

**1. Aplicação automática de boas práticas (estilo Kiro)**

```

Claude: "Gerei plano de implementação com aplicação automática das boas práticas do Kiro:

Estratégia de implementação gerada automaticamente:

1. Desenvolvimento Security-First
   - Incorporação automática de contramedidas OWASP Top 10
   - Implementação automática de criptografia e hashing
   - Geração automática de testes de segurança

2. Aplicação forçada de Clean Architecture
   - Implementação automática de separação de camadas
   - Aplicação automática de inversão de dependência
   - Aplicação forçada de design testável

3. Otimização de performance
   - Implementação automática de estratégia de cache
   - Otimização de banco de dados
   - Utilização de processamento assíncrono

Proceder com esta abordagem?"

```

**2. Configuração automática de pontos de verificação de qualidade**

```

Claude: "Configurei automaticamente pontos de verificação de qualidade para cada etapa de implementação:

Processo automático de garantia de qualidade:

Phase 3a: Implementação de Backend

- [ ] Scan de segurança (SAST/DAST)
- [ ] Teste de especificação de API (conformidade OpenAPI)
- [ ] Teste de performance (carga e resposta)
- [ ] Scan de vulnerabilidades (dependências e CVE)

Phase 3b: Implementação de Frontend

- [ ] Teste de acessibilidade (WCAG 2.1 AA)
- [ ] Teste de compatibilidade de navegadores
- [ ] Verificação de design responsivo
- [ ] Confirmação de cabeçalhos de segurança

Phase 3c: Integração e Deploy

- [ ] Suite de testes E2E
- [ ] Configuração de pipeline CI/CD
- [ ] Configuração de monitoramento e logs
- [ ] Auditoria de segurança do ambiente de produção

Tudo será executado automaticamente. Há padrões de qualidade adicionais?"

```

**3. Análise automática de dependências e mitigação de riscos**

```

Claude: "Analisei automaticamente a ordem de implementação e estratégias de mitigação de riscos:

Ordem de implementação otimizada:

Semana 1: Infraestrutura e base de segurança

- Design e criação de schema de banco de dados
- Base de autenticação (JWT + gerenciamento de sessão)
- Implementação de middleware de segurança
- Endpoints básicos de API

Semana 2: Implementação de funcionalidades core

- Funcionalidade de gerenciamento de usuários
- Funcionalidade de gerenciamento de perfil
- Sistema de gerenciamento de permissões
- Validação e tratamento de erros

Semana 3: Funcionalidades avançadas e otimização

- Implementação de autenticação multifator
- Funcionalidade de log de auditoria
- Otimização de performance
- Integração com frontend

Estratégias de mitigação de riscos detectadas automaticamente:

- Autenticação multifator: Introdução gradual (SMS→Autenticação por app)
- Gerenciamento de sessão: Configuração de cluster Redis
- Acesso em massa: Rate limiting + Utilização de CDN
- Integridade de dados: Reforço do gerenciamento de transações

Há problemas com este plano?"

```

**4. Conclusão e aprovação da Phase 3**

```

Claude: "Implementation Planning Phase foi concluída.
Posso gerar tasks.md?"
→ "Próximo passo" → Geração de tasks.md

```

### Funcionalidades Específicas do Kiro

**Notação EARS (Easy Approach to Requirements Syntax)**

```
# Padrões padrão de notação EARS do Kiro

WHEN [situação / trigger]
GIVEN [precondição]
THEN [comportamento do sistema]
AND [comportamento adicional]

WHILE [estado / processo]
THE SYSTEM SHALL [comportamento obrigatório]
AND [comportamento relacionado]

WHERE [funcionalidade / componente]
IS [condição / estado]
THE SYSTEM SHALL [comportamento correspondente]
```

**Funcionalidades de geração automática**

- **Diagramas Mermaid**: Geração automática de diagramas de arquitetura e fluxo de dados
- **Interfaces TypeScript**: Criação automática de definições de tipos baseadas no design
- **Boas práticas**: Incorporação automática de contramedidas de segurança e performance
- **Pontos de verificação de qualidade**: Configuração automática de padrões de qualidade por etapas

**Integração hooks**

- Verificação automática de qualidade ao salvar arquivos
- Aplicação automática de padrões de código
- Execução automática de scan de segurança
- Verificação automática de contramedidas OWASP Top 10

**Garantia de qualidade protótipo→produção**

- Design consistente através de abordagem estruturada
- Aplicação forçada de desenvolvimento Security-First
- Aplicação automática de arquitetura escalável
- Incorporação de gerenciamento contínuo de qualidade

### Observações

**Escopo de aplicação**

- Spec Mode é otimizado para implementação de funcionalidades
- Para correções simples ou mudanças em pequena escala, use formato de implementação normal
- Recomendado para desenvolvimento de novas funcionalidades ou modificações complexas

**Garantia de qualidade**

- Clarificação de critérios de conclusão para cada etapa
- Revisão de design antes da implementação
- Padrões de qualidade abrangentes incluindo testes e acessibilidade

**Cuidados na execução**

- Resolver ambiguidades nos requisitos antes de avançar para a etapa de design
- Gerar tarefas de implementação após conclusão do design
- Valorizar processo de aprovação em cada etapa

### Frases de Ativação e Controle

#### Controle de fluxo de trabalho gradual

**Triggers de início**

- "Crie spec de [nome da funcionalidade]"
- "Quero desenvolver [nome da funcionalidade] orientado por spec"
- "Projete [nome da funcionalidade] a partir de especificações"

**Controle de progressão de fases**

- **"Próximo passo"**: Conclui a fase atual e gera arquivo, avança para próxima fase
- **"Modifique"**: Ajusta e melhora conteúdo dentro da fase atual
- **"Refaça"**: Recomeça a fase atual do início
- **"Explique detalhadamente"**: Apresenta explicações mais detalhadas ou opções
- **"Pule"**: Pula a fase atual e vai para a próxima (não recomendado)

**Timing de geração de arquivos**

```
Conclusão Phase 1 → "Próximo passo" → Geração de requirements.md
Conclusão Phase 2 → "Próximo passo" → Geração de design.md
Conclusão Phase 3 → "Próximo passo" → Geração de tasks.md
```

### Exemplo de Execução (Fluxo Gradual)

```bash
# Exemplo de uso
Usuário: "Crie spec de sistema de gerenciamento de usuários"

# Phase 1: Requirements Discovery
Claude: [Início de confirmação e discussão de requisitos]
Usuário: [Resposta, discussão, modificação]
Claude: "Requirements Phase foi concluída. Posso avançar?"
Usuário: "Próximo passo"
→ Geração de requirements.md

# Phase 2: Design Exploration
Claude: [Início de proposta e discussão de design]
Usuário: [Discussão de escolhas técnicas / arquitetura]
Claude: "Design Phase foi concluída. Posso avançar?"
Usuário: "Próximo passo"
→ Geração de design.md

# Phase 3: Implementation Planning
Claude: [Início de discussão de plano de implementação]
Usuário: [Discussão de prioridades, riscos, esforço]
Claude: "Implementation Phase foi concluída. Posso avançar?"
Usuário: "Próximo passo"
→ Geração de tasks.md

# Conclusão
Claude: "Preparação para spec-driven development concluída. Pode iniciar a implementação."
```

### Diferenças com /plan

| Característica          | /plan                            | /spec                                                                     |
| ----------------------- | -------------------------------- | ------------------------------------------------------------------------- |
| Objetivo                | Plano geral de implementação     | Desenvolvimento orientado por especificação funcional                     |
| Formato de saída        | Documento de plano único         | 3 arquivos independentes (requirements.md, design.md, tasks.md)           |
| Definição de requisitos | Organização básica de requisitos | Critérios de aceitação detalhados usando notação EARS                     |
| Design                  | Foco em seleção técnica          | Baseado em análise de codebase                                            |
| Implementação           | Decomposição geral de tarefas    | Sequência considerando dependências                                       |
| Garantia de qualidade   | Estratégia básica de testes      | Requisitos abrangentes de qualidade (testes, acessibilidade, performance) |
| Sincronização           | Plano estático                   | Atualização dinâmica de spec                                              |

### Casos de Uso Recomendados

**Uso recomendado de spec**

- Desenvolvimento de novas funcionalidades
- Modificações complexas de funcionalidades
- Design de API
- Design de banco de dados
- Implementação de UI/UX

**Uso recomendado de plan**

- Design de sistema geral
- Construção de infraestrutura
- Refatoração
- Seleção técnica
- Mudanças de arquitetura
