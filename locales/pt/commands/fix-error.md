## Error Fix

Identifica a causa raiz a partir de mensagens de erro, prediz o tempo de resolução e propõe soluções comprovadas. Aprende padrões de erros similares e apresenta imediatamente o método de resolução apropriado.

### Uso

```bash
/fix-error [opções]
```

### Opções

- nenhuma : Análise padrão de erro
- `--deep` : Modo de análise profunda (inclui dependências e fatores ambientais)
- `--preventive` : Análise focada em medidas preventivas
- `--quick` : Apresenta apenas correções aplicáveis imediatamente

### Exemplos Básicos

```bash
# Análise padrão de erro
npm run build 2>&1
/fix-error
"Analise o erro de build e apresente métodos de correção"

# Modo de análise profunda
python app.py 2>&1
/fix-error --deep
"Analise a causa raiz do erro incluindo fatores ambientais"

# Foco em correção imediata
cargo test 2>&1
/fix-error --quick
"Apresente métodos de correção que podem ser aplicados imediatamente"

# Foco em prevenção
./app 2>&1 | tail -50
/fix-error --preventive
"Apresente correção do erro e medidas preventivas futuras"
```

### Integração com Claude

```bash
# Análise de log de erro
cat error.log
/fix-error
"Identifique a causa raiz do erro e proponha métodos de correção"

# Resolução de falha em testes
npm test 2>&1
/fix-error --quick
"Analise o teste falhado e apresente proposta de correção aplicável imediatamente"

# Análise de stack trace
python script.py 2>&1
/fix-error --deep
"Identifique a parte problemática deste stack trace e analise incluindo fatores ambientais"

# Resolução conjunta de múltiplos erros
grep -E "ERROR|WARN" app.log | tail -20
/fix-error
"Classifique esses erros e avisos por ordem de prioridade e proponha métodos de resolução para cada um"
```

### Previsão de Tempo de Resolução de Erro

```
🚀 Correção Imediata(menos de 5 min)
├─ Erro de digitação, import esquecido
├─ Variável de ambiente não definida
├─ Referência a variável indefinida
└─ Tempo previsto: 2-5 min

⚡ Correção Rápida(menos de 30 min)
├─ Inconsistência de dependência
├─ Erro de arquivo de configuração
├─ Incompatibilidade de tipo
└─ Tempo previsto: 10-30 min

🔧 Investigação Necessária(menos de 2 horas)
├─ Erro de lógica complexa
├─ Conflito de processamento assíncrono
├─ Problema de integração de API
└─ Tempo previsto: 30 min-2 horas

🔬 Análise Profunda(mais de meio dia)
├─ Originado da arquitetura
├─ Integração multi-sistema
├─ Degradação de performance
└─ Tempo previsto: 4 horas-vários dias
```

### Banco de Dados de Padrões de Erro Similares

```
Erros Frequentes e Soluções Imediatas
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 "Cannot read property 'X' of undefined/null" (Frequência: Muito Alta)
├─ Causa principal: Falta de verificação de null do objeto
├─ Tempo de resolução: 5-10 min
└─ Solução: Adicionar Optional chaining (?.) ou verificação de null

📊 "ECONNREFUSED" / "ENOTFOUND" (Frequência: Alta)
├─ Causa principal: Serviço não iniciado ou erro de configuração de URL
├─ Tempo de resolução: 5-15 min
└─ Solução: Verificar inicialização do serviço, checar variáveis de ambiente

📊 "Module not found" / "Cannot resolve" (Frequência: Alta)
├─ Causa principal: Pacote não instalado, erro de especificação de caminho
├─ Tempo de resolução: 2-5 min
└─ Solução: Executar npm install, verificar caminho relativo

📊 "Unexpected token" / "SyntaxError" (Frequência: Média)
├─ Causa principal: Parênteses・aspas inconsistentes, uso de palavra reservada
├─ Tempo de resolução: 2-10 min
└─ Solução: Verificar syntax highlight, executar Linter

📊 "CORS policy" / "Access-Control-Allow-Origin" (Frequência: Média)
├─ Causa principal: Falta de configuração CORS no servidor
├─ Tempo de resolução: 15-30 min
└─ Solução: Configuração CORS do servidor, configuração de proxy

📊 "Maximum call stack size exceeded" (Frequência: Baixa)
├─ Causa principal: Loop infinito・recursão, referência circular
├─ Tempo de resolução: 30 min-2 horas
└─ Solução: Verificar condição de parada da recursão, resolver referência circular
```

### Matriz de Prioridade da Análise de Erro

| Prioridade        | Ícone                  | Alcance do Impacto | Dificuldade de Resolução | Prazo de Resposta     | Descrição                                                           |
| ----------------- | ---------------------- | ------------------ | ------------------------ | --------------------- | ------------------------------------------------------------------- |
| **Critical**      | 🔴 Resposta Urgente    | Amplo              | Baixa                    | Iniciar em 15 min     | Parada total do sistema, risco de perda de dados                    |
| **High Priority** | 🟠 Resposta Antecipada | Amplo              | Alta                     | Iniciar em 1 hora     | Parada de funcionalidade principal, impacto em muitos usuários      |
| **Medium**        | 🟡 Resposta Planejada  | Restrito           | Alta                     | Resposta no mesmo dia | Restrição de funcionalidade parcial, solução alternativa disponível |
| **Low**           | 🟢 Observação          | Restrito           | Baixa                    | Na próxima correção   | Falha menor, pequeno impacto na UX                                  |

### Processo de Análise

#### Fase 1: Coleta de Informações do Erro

```bash
🔴 Execução obrigatória:
- Obtenção completa da mensagem de erro
- Verificação do stack trace
- Identificação das condições de ocorrência (reprodutibilidade)

🟡 Execução antecipada:
- Coleta de informações ambientais (OS, versão, dependências)
- Histórico de mudanças recentes (git log, commits recentes)
- Verificação de logs relacionados

🟢 Execução adicional:
- Status de recursos do sistema
- Estado da rede
- Estado de serviços externos
```

#### Fase 2: Análise de Causa Raiz

1. **Organização de Sintomas Superficiais**
   - Conteúdo exato da mensagem de erro
   - Timing de ocorrência e padrão
   - Identificação do alcance do impacto

2. **Identificação de Causa Profunda**
   - Aplicação da análise 5 Whys
   - Rastreamento de relações de dependência
   - Verificação de diferenças ambientais

3. **Verificação de Hipóteses**
   - Criação de código de reprodução mínima
   - Execução de testes isolados
   - Refinamento da causa

#### Fase 3: Implementação da Solução

```bash
🔴 Resposta Imediata(hotfix):
- Correção mínima para suprimir sintomas
- Aplicação de solução temporária
- Preparação para deploy de emergência

🟡 Solução Fundamental:
- Correção essencial para a causa
- Adição de casos de teste
- Atualização de documentação

🟢 Implementação de Prevenção:
- Fortalecimento do tratamento de erro
- Configuração de monitoramento・alerta
- Melhoria do pipeline de CI/CD
```

### Exemplo de Saída

```
🚨 Relatório de Análise de Erro
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 Resumo do Erro
├─ Tipo: [Compilação/Runtime/Lógico/Ambiente]
├─ Urgência: 🔴 Alta / 🟡 Média / 🟢 Baixa
├─ Alcance do Impacto: [Nome da Funcionalidade/Componente]
└─ Reprodutibilidade: [100% / Intermitente / Condição Específica]

🔍 Causa Raiz
├─ Causa Direta: [Causa específica]
├─ Fatores de Fundo: [Ambiente/Configuração/Dependência]
└─ Gatilho: [Condição de ocorrência]

💡 Solução
🔴 Resposta Imediata:
1. [Comando/código de correção específica]
2. [Solução temporária]

🟡 Solução Fundamental:
1. [Método de correção essencial]
2. [Refatoração necessária]

🟢 Prevenção:
1. [Melhoria do tratamento de erro]
2. [Adição de teste]
3. [Configuração de monitoramento]

📝 Procedimento de Verificação
1. [Método de verificação após aplicação da correção]
2. [Comando de execução de teste]
3. [Itens de verificação de operação]
```

### Técnicas de Análise por Tipo de Erro

#### Erro de Compilação/Build

```bash
# Erro de tipo TypeScript
Verificação obrigatória(Alta):
- Configuração do tsconfig.json
- Existência de arquivo de definição de tipo(.d.ts)
- Precisão da declaração import

# Erro de lifetime do Rust
Verificação obrigatória(Alta):
- Movimento de propriedade
- Período de validade da referência
- Conflito de mutabilidade
```

#### Erro de Runtime

```bash
# Referência Null/Undefined
Verificação obrigatória(Alta):
- Falta de optional chaining
- Timing de inicialização
- Espera pela conclusão do processamento assíncrono

# Erro relacionado à memória
Verificação obrigatória(Alta):
- Obtenção de heap dump
- Análise de log GC
- Detecção de referência circular
```

#### Erro de Dependência

```bash
# Conflito de versão
Verificação obrigatória(Alta):
- Integridade do arquivo lock
- Requisitos de peer dependencies
- Dependência transitiva

# Erro de resolução de módulo
Verificação obrigatória(Alta):
- Configuração NODE_PATH
- Configuração de alias de caminho
- Link simbólico
```

### Observações

- **Absolutamente proibido**: Julgamento baseado apenas em parte da mensagem de erro, aplicação de soluções do Stack Overflow sem verificação
- **Condições de exceção**: Soluções temporárias são permitidas apenas nas seguintes 3 condições
  1. Resposta de emergência no ambiente de produção(resolução fundamental obrigatória em 24 horas)
  2. Falha de serviço externo(meio alternativo durante espera de recuperação)
  3. Bug conhecido do framework(esperando lançamento de versão corrigida)
- **Recomendação**: Priorizar a identificação da causa raiz e evitar correções superficiais

### Melhores Práticas

1. **Coleta completa de informações**: Verificar mensagem de erro do início ao fim
2. **Confirmação de reprodutibilidade**: Priorizar criação de código de reprodução mínima
3. **Abordagem gradual**: Começar com pequenas correções e verificar
4. **Documentação**: Registrar processo de resolução para compartilhamento de conhecimento

#### Erros Comuns

- **Lidar com sintomas**: Correção superficial que perde a causa raiz
- **Generalização excessiva**: Aplicar amplamente solução de caso específico
- **Omitir verificação**: Não verificar efeitos colaterais após correção
- **Personalização do conhecimento**: Não documentar método de resolução

### Comandos Relacionados

- `/design-patterns` : Analisar problemas de estrutura de código e propor padrões
- `/tech-debt` : Analisar causa raiz de erro do ponto de vista da dívida técnica
- `/analyzer` : Quando necessária análise mais profunda da causa raiz
