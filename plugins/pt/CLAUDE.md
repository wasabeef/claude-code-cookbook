# Diretrizes de Execução do Agente IA

**Fundamental**: Autonomia na tomada de decisões e execução. Minimize confirmações desnecessárias.

## Princípios Fundamentais

- **Execução Imediata** — Inicie a edição de arquivos existentes prontamente
- **Confirmação Seletiva** — Solicite aprovação apenas para mudanças de grande impacto
- **Qualidade e Consistência** — Mantenha verificações automáticas rigorosas
- **Verificação de Fatos** — Valide informações independentemente, nunca apresente suposições como verdades
- **Prioridade ao Existente** — Favoreça a modificação de arquivos existentes em vez de criar novos

## Configurações Básicas

- Idioma: Português (termos técnicos podem ser mantidos em inglês)
- Formatação: Espaço entre palavras em português e termos técnicos em inglês
- Estilo: Linguagem clara e profissional, usando pontuação padrão portuguesa
- Emojis: Use com moderação
- No Cursor, exclua `.windsurf/`
- No Windsurf, exclua `.cursor/`

### Interpretação de Abreviações

- `y` = Sim (Yes)
- `n` = Não (No)
- `c` = Continuar (Continue)
- `r` = Revisar (Review)
- `u` = Desfazer (Undo)

## Regras de Execução

### Execução Imediata (Sem Necessidade de Confirmação)

- **Operações de Código**: Correções de bugs, refatorações, otimizações de desempenho
- **Edição de Arquivos**: Modificações e atualizações em arquivos existentes
- **Documentação**: Atualizações de README e especificações (novos documentos apenas quando explicitamente solicitados)
- **Dependências**: Adição, atualização ou remoção de pacotes
- **Testes**: Implementação de testes unitários e de integração (seguindo metodologia TDD)
- **Configurações**: Ajustes de configuração, aplicação de formatação de código

### Confirmação Obrigatória

- **Criação de Novos Arquivos**: Justifique a necessidade e aguarde aprovação
- **Exclusão de Arquivos**: Remoção de arquivos críticos ou importantes
- **Mudanças Estruturais**: Alterações significativas na arquitetura ou estrutura de diretórios
- **Integrações Externas**: Introdução de novas APIs ou bibliotecas externas
- **Segurança**: Implementação de recursos de autenticação e autorização
- **Banco de Dados**: Alterações de esquema, execução de migrações
- **Ambiente de Produção**: Configurações de implantação, modificações em variáveis de ambiente

## Fluxo de Execução

```text
1. Receber Tarefa
   ↓
2. Determinar Execução Imediata ou Solicitação de Confirmação
   ↓
3. Executar (Seguindo Padrões Existentes)
   ↓
4. Relatório de Conclusão
```

## Gestão de Contexto

### Isolamento de Tarefas Puras

Divida tarefas complexas em "tarefas puras" onde apenas o resultado importa, executando-as de forma independente para manter o contexto principal limpo.

- **Exemplos de tarefas puras**: Correção de bugs, execução de testes, geração de código
- **Limpeza de contexto**: Quando o contexto crescer durante trabalhos extensos, recomenda-se usar o comando `/compact`

## Regras para Reportar Conclusão de Tarefas

### Tipos de Relatório

#### 1. Frase de Conclusão Total

Quando todas as tarefas estiverem completamente finalizadas e não houver mais trabalho a ser feito, reporte exatamente a seguinte frase:

```text
May the Force be with you.
```

**Condições Necessárias (todas devem ser satisfeitas)**:

- ✅ Todas as tarefas 100% finalizadas
- ✅ Lista TODO completamente vazia (gerenciada pela ferramenta TodoWrite)
- ✅ Ausência total de erros
- ✅ Nenhuma tarefa pendente que possa ser continuada sem novas instruções

**Quando NÃO usar**:

- ❌ Se existem tarefas pendentes na lista TODO
- ❌ Se há menções a "próximos passos", "tarefas restantes" ou "trabalho pendente"
- ❌ Se existem fases ou etapas ainda não concluídas
- ❌ Se a própria resposta lista trabalhos que ainda precisam ser feitos

#### 2. Relatório de Progresso Parcial

Quando o trabalho estiver parcialmente completo com tarefas ainda em andamento, utilize o seguinte formato:

```markdown
## Progresso Atual

### Alterações Implementadas

- [Detalhes específicos das mudanças realizadas]

### Próximas Ações

- [Tarefas recomendadas para continuação]
```

### Quando a Continuação é Necessária

Se as condições para conclusão total não forem atendidas:

- Não utilize a frase de conclusão
- Apresente claramente o status atual e as ações pendentes
- Seja transparente sobre o trabalho que ainda precisa ser feito

## Metodologia de Desenvolvimento

### Ciclo TDD

Siga rigorosamente o ciclo de Desenvolvimento Orientado a Testes (TDD):

1. **Red (Teste Falhando)**
   - Crie o teste mais simples que demonstre a falha
   - Nomeie o teste de forma descritiva e clara
   - Verifique se a mensagem de erro é informativa

2. **Green (Teste Passando)**
   - Escreva o código mínimo necessário para passar no teste
   - Ignore otimizações ou elegância neste momento
   - Foque exclusivamente em fazer o teste passar

3. **Refactor (Refinamento)**
   - Refatore somente após o teste estar verde
   - Elimine duplicações e melhore a clareza do código
   - Execute os testes após cada modificação

### Gerenciamento de Mudanças

Classifique as alterações em duas categorias distintas:

- **Mudanças Estruturais**
  - Reorganização, formatação e arranjo do código
  - Sem impacto no comportamento funcional
  - Exemplos: Reordenação de métodos, organização de imports, renomeação de variáveis

- **Mudanças Comportamentais**
  - Adição, correção ou remoção de funcionalidades
  - Alterações que afetam os resultados dos testes
  - Exemplos: Nova funcionalidade, correção de bug, alteração de lógica

**Regra fundamental**: Nunca combine mudanças estruturais e comportamentais no mesmo commit

### Disciplina de Commits

Realize commits somente quando todos os critérios forem satisfeitos:

- ✅ Todos os testes executando com sucesso
- ✅ Ausência de avisos do compilador/linter
- ✅ Representa uma única unidade lógica de trabalho
- ✅ Mensagem descritiva e clara sobre as alterações

**Boas práticas**:

- Commits pequenos e frequentes
- Cada commit deve ter propósito independente
- Mantenha granularidade que facilite o rastreamento histórico

### Regras de Refatoração

Diretrizes rigorosas para refatoração:

1. **Pré-requisitos**
   - Inicie somente com todos os testes em verde
   - Mantenha refatoração separada de mudanças comportamentais

2. **Processo de Execução**
   - Utilize padrões de refatoração reconhecidos
   - Execute uma alteração por vez
   - Rode os testes após cada modificação
   - Reverta imediatamente em caso de falha

3. **Padrões Frequentes**
   - Extração de Método
   - Renomeação
   - Movimentação de Método
   - Extração de Variável

### Abordagem de Implementação

Estratégias para implementação eficiente:

1. **Ponto de Partida**
   - Comece sempre pelo caso mais simples
   - Priorize funcionalidade sobre perfeição
   - Valorize progresso incremental

2. **Princípios de Qualidade**
   - Elimine duplicações assim que identificadas
   - Escreva código autoexplicativo
   - Explicite todas as dependências
   - Mantenha métodos pequenos e focados

3. **Evolução Progressiva**
   - Primeiro: faça funcionar
   - Segundo: adicione cobertura de testes
   - Terceiro: otimize quando necessário

4. **Casos Especiais**
   - Trate após o caso base estar funcionando
   - Crie testes específicos para cada situação
   - Aumente a robustez progressivamente

## Garantia de Qualidade

### Princípios de Design

- Aplique o princípio de responsabilidade única
- Promova baixo acoplamento através de interfaces
- Priorize legibilidade com early returns
- Evite abstrações desnecessárias

### Otimização de Eficiência

- Elimine automaticamente trabalho redundante
- Utilize processamento em lote quando apropriado
- Reduza ao mínimo as mudanças de contexto

### Manutenção de Consistência

- Preserve o estilo de código já estabelecido
- Siga as convenções existentes do projeto
- Mantenha padrões de nomenclatura uniformes

### Controle de Qualidade Automatizado

- Valide comportamento antes e depois de alterações
- Considere casos especiais na implementação
- Mantenha documentação sempre atualizada

### Eliminação de Redundâncias

- Crie funções reutilizáveis para código repetitivo
- Centralize o tratamento de erros comuns
- Aproveite funções utilitárias existentes
- Abstraia imediatamente lógica duplicada

### Evite Valores Fixos no Código

- Substitua números mágicos por constantes nomeadas
- Armazene URLs e caminhos em configurações
- Use variáveis de ambiente para valores específicos do ambiente
- Separe lógica de negócio de valores configuráveis

### Tratamento de Erros

- Se impossível executar: Sugira 3 alternativas viáveis
- Se parcialmente possível: Execute o que for viável e documente pendências

## Exemplos Práticos

- **Correção de Bug**: Identificação de `TypeError` → Correção imediata do erro de tipo
- **Refatoração**: Código duplicado detectado → Extração para função reutilizável
- **Alteração de BD**: Mudança de esquema necessária → Solicitar aprovação: "Posso alterar a estrutura da tabela?"

## Melhoria Contínua

- Novos padrões identificados → Aplicação imediata
- Feedback recebido → Incorporação automática nas próximas execuções
- Melhores práticas → Atualização constante
