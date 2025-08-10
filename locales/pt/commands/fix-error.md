## Error Fix

Identifica a causa raiz a partir de mensagens de erro e propõe soluções comprovadas.

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

### Prioridades na Análise de Erro

#### 🔴 Urgência: Alta (resposta imediata necessária)

- **Parada da aplicação**: Crash, loop infinito, deadlock
- **Risco de perda de dados**: Erro de banco de dados, corrupção de arquivo
- **Vulnerabilidade de segurança**: Falha de autenticação, erro de permissão, injeção
- **Impacto no ambiente de produção**: Falha de deploy, parada de serviço

#### 🟡 Urgência: Média (resposta antecipada recomendada)

- **Problemas de performance**: Vazamento de memória, atraso, timeout
- **Disfunção parcial**: Erro em funcionalidade específica, falha na UI
- **Redução de eficiência de desenvolvimento**: Erro de build, falha em teste

#### 🟢 Urgência: Baixa (resposta planejada)

- **Mensagens de aviso**: deprecation, erro de lint
- **Limitado ao ambiente de desenvolvimento**: Problema apenas no ambiente local
- **Risco futuro**: Dívida técnica, problema de manutenibilidade

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

#### Fase 2: Análise da Causa Raiz

1. **Organização dos sintomas superficiais**
   - Conteúdo exato da mensagem de erro
   - Timing e padrões de ocorrência
   - Identificação do escopo de impacto

2. **Identificação de causas profundas**
   - Aplicação da análise 5 Whys
   - Rastreamento de dependências
   - Verificação de diferenças ambientais

3. **Verificação de hipóteses**
   - Criação de código de reprodução mínima
   - Execução de testes isolados
   - Refinamento da causa

#### Fase 3: Implementação de Soluções

```bash
🔴 Tratamento imediato (hotfix):
- Correção mínima para suprimir sintomas
- Aplicação de solução temporária
- Preparação para deploy emergencial

🟡 Solução fundamental:
- Correção essencial para a causa
- Adição de casos de teste
- Atualização da documentação

🟢 Implementação de medidas preventivas:
- Fortalecimento do tratamento de erros
- Configuração de monitoramento e alertas
- Melhoria do pipeline CI/CD
```

### Exemplo de Saída

```
🚨 Relatório de Análise de Erro
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 Resumo do Erro
├─ Tipo: [Compilação/Tempo de execução/Lógico/Ambiente]
├─ Urgência: 🔴 Alta / 🟡 Média / 🟢 Baixa
├─ Escopo de impacto: [Nome da funcionalidade/Componente]
└─ Reprodutibilidade: [100% / Intermitente / Condição específica]

🔍 Causa Raiz
├─ Causa direta: [Causa específica]
├─ Fatores de contexto: [Ambiente/Configuração/Dependências]
└─ Gatilho: [Condições de ocorrência]

💡 Soluções
🔴 Tratamento imediato:
1. [Comando/código de correção específico]
2. [Solução temporária]

🟡 Solução fundamental:
1. [Método de correção essencial]
2. [Refatoração necessária]

🟢 Medidas preventivas:
1. [Melhoria do tratamento de erros]
2. [Adição de testes]
3. [Configuração de monitoramento]

📝 Procedimentos de Verificação
1. [Método de verificação após aplicação da correção]
2. [Comando de execução de testes]
3. [Itens de verificação de funcionamento]
```

### Métodos de Análise por Tipo de Erro

#### Erros de Compilação/Build

```bash
# Erro de tipo TypeScript
Verificação obrigatória (Alta):
- Configuração do tsconfig.json
- Existência de arquivos de definição de tipo (.d.ts)
- Precisão das declarações import

# Erro de lifetime do Rust
Verificação obrigatória (Alta):
- Movimentação de ownership
- Período de validade de referências
- Conflito de mutabilidade
```

#### Erros de Tempo de Execução

```bash
# Referência Null/Undefined
Verificação obrigatória (Alta):
- Falta de optional chaining
- Timing de inicialização
- Espera pela conclusão de processamento assíncrono

# Erros relacionados à memória
Verificação obrigatória (Alta):
- Obtenção de heap dump
- Análise de log GC
- Detecção de referência circular
```

#### Erros de Dependência

```bash
# Conflito de versão
Verificação obrigatória (Alta):
- Integridade do arquivo lock
- Requisitos de peer dependencies
- Dependências transitivas

# Erro de resolução de módulo
Verificação obrigatória (Alta):
- Configuração NODE_PATH
- Configuração de alias de caminho
- Link simbólico
```

### Observações

- **Absolutamente proibido**: Julgamento baseado apenas em parte da mensagem de erro, aplicação de soluções do Stack Overflow sem verificação
- **Condições de exceção**: Soluções temporárias são permitidas apenas nas seguintes 3 condições:
  1. Resposta de emergência no ambiente de produção (solução fundamental obrigatória em 24 horas)
  2. Falha de serviço externo (meio alternativo durante espera pela recuperação)
  3. Bug conhecido do framework (aguardando lançamento da versão corrigida)
- **Recomendação**: Priorizar identificação da causa raiz e evitar correções superficiais

### Melhores Práticas

1. **Coleta completa de informações**: Verificar mensagem de erro do início ao fim
2. **Verificação de reprodutibilidade**: Priorizar criação de código de reprodução mínima
3. **Abordagem por etapas**: Começar com pequenas correções e verificar
4. **Documentação**: Registrar o processo de resolução para compartilhar conhecimento

#### Armadilhas Comuns

- **Tratamento de sintomas**: Correção superficial que perde de vista a causa raiz
- **Generalização excessiva**: Aplicação ampla de solução para caso específico
- **Omissão de verificação**: Não verificar efeitos colaterais após correção
- **Conhecimento personalizado**: Não documentar métodos de resolução

### Comandos Relacionados

- `/design-patterns` : Analisar problemas de estrutura de código e propor padrões
- `/tech-debt` : Analisar causa raiz de erro do ponto de vista da dívida técnica
- `/analyzer` : Quando necessária análise mais profunda da causa raiz
