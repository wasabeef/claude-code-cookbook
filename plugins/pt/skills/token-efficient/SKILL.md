---
description: 'Comprimir respostas para reduzir uso de contexto. Ativa com "modo eficiente", "comprimir respostas", "economizar contexto".'
---

# Comprimir respostas para reduzir uso de contexto

Reduz o uso de contexto nas respostas da IA em 30-50% através do modo de eficiência por compressão.

## Comprimir respostas para reduzir uso de contexto em 30-50%

O Modo Eficiência de Tokens utiliza sistemas de símbolos visuais e abreviações para comprimir as respostas do Claude.
**A qualidade do código gerado e o conteúdo permanecem inalterados**. Apenas o método de explicação é alterado.

## Como Usar

```bash
# Ativar modo
"Responda no Modo Eficiência de Tokens"
"--uc mode"
"Modo conciso"
```

## Como Funciona

## 1. Sistema de Símbolos

### Lógica e Fluxo

| Símbolo | Significado          | Exemplo                              |
| ------- | -------------------- | ------------------------------------ |
| →       | leva a, causa        | `auth.js:45 → 🛡️ risco de segurança` |
| ⇒       | converte para        | `entrada ⇒ saida_validada`           |
| ←       | reversão, voltar     | `migration ← rollback`               |
| ⇄       | bidirecional         | `sync ⇄ remoto`                      |
| &       | e, combinar          | `🛡️ segurança & ⚡ performance`      |
| \|      | ou, separador        | `react\|vue\|angular`                |
| :       | definir, especificar | `escopo: arquivo\|módulo`            |
| »       | então, sequência     | `build » test » deploy`              |
| ∴       | portanto             | `testes ❌ ∴ código quebrado`        |
| ∵       | porque               | `lento ∵ algoritmo O(n²)`            |

### Status e Progresso

| Símbolo | Significado       | Uso                          |
| ------- | ----------------- | ---------------------------- |
| ✅      | completo, sucesso | Tarefa concluída normalmente |
| ❌      | falhou, erro      | Ação imediata necessária     |
| ⚠️      | aviso             | Revisão recomendada          |
| 🔄      | em andamento      | Atualmente ativo             |
| ⏳      | pendente          | Agendado para depois         |
| 🚨      | urgente, crítico  | Alta prioridade              |

### Domínios Técnicos

| Símbolo | Domínio        | Uso                       |
| ------- | -------------- | ------------------------- |
| ⚡      | Performance    | Velocidade, otimização    |
| 🔍      | Análise        | Busca, investigação       |
| 🔧      | Configuração   | Setup, ferramentas        |
| 🛡️      | Segurança      | Proteção, segurança       |
| 📦      | Deploy         | Pacote, bundle            |
| 🎨      | Design         | UI, frontend              |
| 🏗️      | Arquitetura    | Estrutura do sistema      |
| 🗄️      | Banco de Dados | Persistência de dados     |
| ⚙️      | Backend        | Processamento do servidor |
| 🧪      | Testes         | Garantia de qualidade     |

## 2. Sistema de Abreviações

### Sistema e Arquitetura

- `cfg` → configuração
- `impl` → implementação
- `arq` → arquitetura
- `perf` → performance
- `ops` → operações
- `env` → ambiente

### Processo de Desenvolvimento

- `req` → requisitos
- `deps` → dependências
- `val` → validação
- `auth` → autenticação
- `docs` → documentação
- `std` → padrões

### Qualidade e Análise

- `qual` → qualidade
- `seg` → segurança
- `err` → erro
- `rec` → recuperação
- `sev` → severidade
- `opt` → otimização

## Exemplos de Comparação

## Exemplo 1: Relatório de Erro

**Modo Normal (95 caracteres)**

```text
Vulnerabilidade de segurança encontrada na função de validação do usuário na linha 45 do sistema auth.
```

**Token Eficiente (44 caracteres)**

```text
auth.js:45 → 🛡️ vuln seg na val() usuário
```

## Exemplo 2: Status de Build

**Modo Normal (118 caracteres)**

```text
Processo de build foi concluído com sucesso. Testes estão sendo executados atualmente, seguidos pelo deploy.
```

**Token Eficiente (38 caracteres)**

```text
build ✅ » teste 🔄 » deploy ⏳
```

## Exemplo 3: Análise de Performance

**Modo Normal (105 caracteres)**

```text
Análise de performance revelou processamento lento devido à complexidade do algoritmo O(n²).
```

**Token Eficiente (46 caracteres)**

```text
⚡ perf: lento ∵ O(n²) → otimizar para O(n)
```

## Casos de Uso

## ✅ Cenários Efetivos

- **Sessões longas de debug**: Manter histórico eficientemente
- **Revisões grandes de código**: Análise concisa de muitos arquivos
- **Monitoramento CI/CD**: Atualizações de status em tempo real
- **Relatórios de progresso de projeto**: Visão geral de múltiplos estados de tarefa
- **Rastreamento de erros**: Representação visual de cadeias de problemas

## ❌ Cenários a Evitar

- Explicações para iniciantes
- Criação de documentação detalhada
- Definição de requisitos iniciais
- Comunicação com stakeholders não-técnicos

## Exemplos de Implementação

## Sessão de Debug

```text
[14:23] breakpoint → vars: {user: null, token: expirado}
[14:24] step → auth.validate() ❌
[14:25] check → token.exp < Date.now() ∴ expirado
[14:26] fix → refresh() → ✅
[14:27] continue → fluxo principal 🔄
```

## Resultados de Análise de Arquivos

```text
/src/auth/: 🛡️ problemas × 3
/src/api/: ⚡ gargalo no handler()
/src/db/: ✅ limpo
/src/utils/: ⚠️ métodos deprecated
/tests/: 🧪 cobertura 78%
```

## Status do Projeto

```text
Frontend: 🎨 ✅ 100%
Backend: ⚙️ 🔄 75%
Database: 🗄️ ✅ migrado
Testes: 🧪 ⚠️ 68% (meta: 80%)
Deploy: 📦 ⏳ agendado
Segurança: 🛡️ 🚨 1 crítico
```

## Opções de Configuração

```javascript
// Níveis de compressão
--uc; // Ultra Comprimido: Máxima compressão
--mc; // Moderadamente Comprimido: Compressão média
--lc; // Levemente Comprimido: Compressão leve

// Específico do domínio
--dev; // Compressão focada em desenvolvimento
--ops; // Compressão focada em operações
--seg; // Compressão focada em segurança
```

## Benefícios

1. **Economia de contexto**: Redução de 30-50% nos tokens
2. **Compreensão visual**: Compreensão intuitiva através de símbolos
3. **Densidade de informação**: Mais informação no mesmo espaço
4. **Retenção de histórico**: Manter conversas mais longas no histórico
5. **Reconhecimento de padrões**: Detecção mais fácil de problemas através de padrões visuais

## Observações

- Este modo apenas muda o **estilo de resposta da IA**
- **Qualidade do código** permanece inalterada
- Pode alternar com "explicar no modo normal" conforme necessário
- Modo normal recomendado para iniciantes e usuários não-técnicos

## Exemplos de Comandos

```bash
# Ativar
"Modo Eficiência de Tokens ligado"
"Responder de forma concisa"
"Analisar com --uc"

# Desativar
"Voltar ao modo normal"
"Explicar em detalhes"
"Modo Eficiência de Tokens desligado"
```

## Impacto da Implementação

| Item                       | Impacto              |
| -------------------------- | -------------------- |
| Qualidade do código gerado | Sem mudança ✅       |
| Precisão da implementação  | Sem mudança ✅       |
| Funcionalidade             | Sem mudança ✅       |
| Método de explicação da IA | Comprimido 🔄        |
| Uso de contexto            | Redução de 30-50% ⚡ |

---

💡 **Dica Pro**: Para sessões de trabalho longas, comece com o modo normal para construir entendimento, depois mude para o Modo Eficiência de Tokens para otimizar a eficiência e retenção de contexto.
