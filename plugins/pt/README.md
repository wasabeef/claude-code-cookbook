# Claude Code Cookbook

[🏠 Home](../../README.md) | [🇺🇸 English](../en/README.md) | [🇯🇵 日本語](../ja/README.md) | [🇰🇷 한국어](../ko/README.md) | [🇨🇳 简体中文](../zh-cn/README.md) | [🇹🇼 繁體中文](../zh-tw/README.md) | [🇪🇸 Español](../es/README.md) | [🇫🇷 Français](../fr/README.md) | [🇧🇷 Português](../pt/README.md)

Coleção de configurações para otimizar o uso do Claude Code.

Foque no que realmente importa enquanto tarefas rotineiras são executadas automaticamente, minimizando interrupções para confirmações.
O Claude Code gerencia autonomamente atividades comuns como correções de código, execução de testes e atualização de documentação.

## Principais Funcionalidades

Personalize o comportamento do Claude Code através de três recursos principais:

- **Commands**: Comandos personalizados iniciados com `/`
- **Roles**: Configurações de papéis especializados para respostas contextualizadas
- **Hooks**: Scripts automatizados executados em momentos específicos

---

## Lista de Funcionalidades

### Commands (Comandos Personalizados)

Armazenados como arquivos Markdown no diretório `/commands`. Execute digitando `/` seguido do nome do arquivo.

| Comando                 | Descrição                                                                                                                                      |
| :---------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| `/analyze-dependencies` | Analisa as dependências do projeto e visualiza dependências circulares e problemas estruturais.                                                |
| `/analyze-performance`  | Analisa problemas de desempenho da aplicação e propõe melhorias do ponto de vista de dívida técnica.                                           |
| `/check-fact`           | Verifica a veracidade das informações fornecidas consultando o código-base e a documentação do projeto.                                        |
| `/check-github-ci`      | Monitora o status do CI do GitHub Actions e acompanha até a conclusão.                                                                         |
| `/check-prompt`         | Revisa o conteúdo do prompt atual e apresenta sugestões de melhoria.                                                                           |
| `/commit-message`       | Gera apenas a mensagem de commit com base nas alterações.                                                                                      |
| `/context7`             | Gerencia contexto usando Context7 MCP.                                                                                                         |
| `/design-patterns`      | Propõe e revisa implementações baseadas em padrões de design.                                                                                  |
| `/explain-code`         | Explica de forma clara a funcionalidade e lógica do código selecionado.                                                                        |
| `/fix-error`            | Apresenta sugestões de correção de código com base nas mensagens de erro.                                                                      |
| `/multi-role`           | Combina múltiplos papéis (Role) para analisar o mesmo alvo em paralelo e gerar um relatório integrado.                                         |
| `/plan`                 | Ativa o modo de planejamento pré-implementação e elabora estratégias de implementação detalhadas.                                              |
| `/pr-auto-update`       | Atualiza automaticamente o conteúdo do Pull Request (descrição, labels).                                                                       |
| `/pr-create`            | Realiza fluxo de trabalho eficiente de Pull Request com criação automática de PR baseada na análise de mudanças Git.                           |
| `/pr-feedback`          | Responde eficientemente aos comentários de revisão do Pull Request e busca resolução fundamental com abordagem de análise de erro em 3 etapas. |
| `/pr-issue`             | Exibe lista de Issues abertas do repositório atual com priorização.                                                                            |
| `/pr-list`              | Exibe lista de PRs abertos do repositório atual com priorização.                                                                               |
| `/pr-review`            | Garante qualidade do código e integridade da arquitetura com revisão sistemática de Pull Request.                                              |
| `/refactor`             | Executa refatoração de código segura e gradual e avalia conformidade com princípios SOLID.                                                     |
| `/role-debate`          | Faz múltiplos papéis (Role) debaterem sobre um tema específico.                                                                                |
| `/role-help`            | Exibe lista e descrição dos Roles disponíveis.                                                                                                 |
| `/role`                 | Comporta-se como o papel (Role) especificado.                                                                                                  |
| `/screenshot`           | Captura e analisa screenshot da tela                                                                                                           |
| `/search-gemini`        | Realiza busca na Web usando Gemini.                                                                                                            |
| `/semantic-commit`      | Divide grandes mudanças em unidades mínimas significativas e faz commits sequenciais com mensagens semânticas.                                 |
| `/sequential-thinking`  | Usa Sequential Thinking MCP para pensar problemas complexos passo a passo e derivar conclusões.                                                |
| `/show-plan`            | Exibe o plano de execução atual.                                                                                                               |
| `/smart-review`         | Realiza revisão avançada e melhora a qualidade do código.                                                                                      |
| `/spec`                 | Cria especificações detalhadas passo a passo a partir de requisitos, conforme spec-driven development do Kiro.                                 |
| `/style-ai-writing`     | Detecta e corrige textos não naturais que parecem gerados por IA.                                                                              |
| `/task`                 | Ativa agente dedicado para executar autonomamente tarefas complexas de busca, investigação e análise.                                          |
| `/tech-debt`            | Analisa a dívida técnica do projeto e cria plano de melhoria priorizado.                                                                       |
| `/ultrathink`           | Executa processo de pensamento estruturado e gradual para problemas complexos ou decisões importantes.                                         |
| `/update-dart-doc`      | Gerencia sistematicamente comentários DartDoc em arquivos Dart e mantém documentação de alta qualidade.                                        |
| `/update-doc-string`    | Gerencia e atualiza strings de documentação multilíngue de forma unificada.                                                                    |
| `/update-flutter-deps`  | Atualiza com segurança as dependências do projeto Flutter.                                                                                     |
| `/update-node-deps`     | Atualiza com segurança as dependências do projeto Node.js.                                                                                     |
| `/update-rust-deps`     | Atualiza com segurança as dependências do projeto Rust.                                                                                        |

### Roles (Configuração de Papéis)

Definidos em arquivos Markdown no diretório `agents/roles/`. Permite que o Claude adote perspectivas especializadas para fornecer respostas mais precisas e contextualizadas.

Cada papel pode ser **executado de forma independente como subagente**. Com a opção `--agent`, é possível realizar análises em larga escala ou processamento especializado em paralelo, sem afetar o contexto da conversa principal.

| Papel               | Descrição                                                                                                                                   |
| :------------------ | :------------------------------------------------------------------------------------------------------------------------------------------ |
| `/role analyzer`    | Como especialista em análise de sistemas, analisa código e arquitetura.                                                                     |
| `/role architect`   | Como arquiteto de software, fornece revisões e sugestões sobre design.                                                                      |
| `/role backend`     | Como especialista em desenvolvimento backend, fornece conselhos sobre design de API, microsserviços, cloud-native e arquitetura serverless. |
| `/role frontend`    | Como especialista em frontend, fornece conselhos sobre UI/UX e desempenho.                                                                  |
| `/role mobile`      | Como especialista em desenvolvimento mobile, responde baseado nas melhores práticas de iOS/Android.                                         |
| `/role performance` | Como especialista em otimização de desempenho, propõe melhorias de velocidade e uso de memória.                                             |
| `/role qa`          | Como engenheiro de QA, revisa do ponto de vista de planos de teste e garantia de qualidade.                                                 |
| `/role reviewer`    | Como revisor de código, avalia código do ponto de vista de legibilidade e manutenibilidade.                                                 |
| `/role security`    | Como especialista em segurança, aponta vulnerabilidades e riscos de segurança.                                                              |

#### Exemplos de Execução de Subagente

```bash
# Modo normal (execução no contexto principal)
/role security
"Verificação de segurança deste projeto"

# Modo subagente (execução em contexto independente)
/role security --agent
"Executar auditoria de segurança completa do projeto"

# Análise paralela com múltiplos papéis
/multi-role security,performance --agent
"Analisar abrangentemente segurança e desempenho de todo o sistema"
```

### Hooks (Scripts de Automação)

Configure no `settings.json` para automatizar tarefas de desenvolvimento.

| Script de Execução             | Evento                       | Descrição                                                                                                                |
| :----------------------------- | :--------------------------- | :----------------------------------------------------------------------------------------------------------------------- |
| `preserve-file-permissions.sh` | `PreToolUse` / `PostToolUse` | Salva permissões originais antes da edição de arquivo e restaura após edição. Previne Claude Code de alterar permissões. |

---

## Fluxo de Desenvolvimento e Guia de Uso de Comandos

### Exemplos de Uso de Comandos em Fluxo de Desenvolvimento Típico

```mermaid
flowchart TB
    Start([Verificar Tarefa]) --> PRList["/pr-list<br/>Lista PRs Abertos"]
    Start --> PRIssue["/pr-issue<br/>Lista Issues Abertas"]

    PRList --> TaskType{Tipo?}
    PRIssue --> TaskType

    TaskType -->|Nova Funcionalidade| Plan["/spec<br/>Definição de Requisitos ・Design"]
    TaskType -->|Correção de Bug| Fix["/fix-error<br/>Análise de Erro"]
    TaskType -->|Refatoração| Refactor["/refactor<br/>Melhoria"]
    TaskType -->|Revisão| Review["/pr-review<br/>Revisão"]

    Plan --> Design["/role architect<br/>/role-debate<br/>Consulta de Design"]
    Design --> Implementation[Implementação ・Teste]
    Fix --> Implementation
    Refactor --> Implementation
    Review --> Implementation

    Implementation --> Check["/smart-review<br/>Verificação de Qualidade"]
    Check --> Commit["/semantic-commit<br/>Commit por Unidade de Objetivo"]
    Commit --> PR["/pr-create<br/>Criação Automática de PR"]
    PR --> CI["/check-github-ci<br/>Verificação de Status CI"]

    CI --> Status{Há Problema?}
    Status -->|Sim| Feedback["Responder Correção<br/>/pr-feedback<br/>/fix-error"]
    Status -->|Não| End([Concluído])

    Feedback --> Implementation

    classDef commandBox fill:#e0f2fe,stroke:#0369a1,stroke-width:2px,rx:5,ry:5,color:#0c4a6e
    classDef processBox fill:#f0f9ff,stroke:#0ea5e9,stroke-width:1px,rx:5,ry:5,color:#075985
    classDef decisionBox fill:#fef3c7,stroke:#f59e0b,stroke-width:2px,rx:5,ry:5,color:#78350f
    classDef startEnd fill:#86efac,stroke:#22c55e,stroke-width:2px,rx:20,ry:20,color:#14532d

    class PRList,PRIssue,Plan,Fix,Refactor,Review,Design,Check,CI,Commit,PR,Feedback commandBox
    class Implementation processBox
    class TaskType,Status decisionBox
    class Start,End startEnd

    %%{init: {'theme':'base', 'themeVariables': { 'primaryColor':'#e0f2fe', 'primaryTextColor':'#0c4a6e', 'primaryBorderColor':'#0369a1', 'lineColor':'#64748b', 'secondaryColor':'#f0f9ff', 'background':'#ffffff', 'mainBkg':'#ffffff', 'fontSize': '14px'}}}%%
```

---

## Instalação

### Passo 1: Adicionar o Marketplace

Primeiro, adicione este repositório como um marketplace de plugins:

```bash
/plugin marketplace add wasabeef/claude-code-cookbook
```

### Passo 2: Instalar o Plugin em Português

Em seguida, instale o plugin em versão portuguesa:

```bash
/plugin install cook-pt@claude-code-cookbook
```

Este comando instala a versão em português dos Commands e Roles.

### Uso

Após a instalação, comandos e agentes são chamados com o prefixo `cook-pt:`:

#### Executando Comandos

```bash
# Executar com prefixo
/cook-pt:check-fact

# Usar autocompletar
/cook-pt:
```

#### Chamando Agentes

```bash
# Buscar agentes começando com @
@agent-cook-pt:frontend

# Também pode usar via comando de papel
/cook-pt:role frontend
```

**Nota**: O nome do plugin é automaticamente adicionado como prefixo. Isso evita conflitos de nomes quando múltiplos plugins de idioma são instalados simultaneamente.

### Personalização

- **Adicionar comandos**: Apenas adicione arquivo `.md` em `commands/`
- **Adicionar papéis**: Apenas adicione arquivo `.md` em `agents/roles/`
- **Editar Hooks**: Edite `settings.json` para alterar processamento automático
