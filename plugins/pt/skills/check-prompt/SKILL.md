---
description: "Avaliar e melhorar qualidade de prompts de IA"
---

## Verificar Prompt

Coleção abrangente de melhores práticas para avaliar e melhorar a qualidade de prompts para AI Agent. Sistematiza conhecimentos obtidos através de processos reais de melhoria de prompts, cobrindo todos os aspectos importantes: eliminação de ambiguidade, integração de informações, reforço de obrigatoriedade, sistema de rastreamento e melhoria contínua.

### Uso

```bash
# Verificar qualidade de arquivo de prompt
cat your-prompt.md
/check-prompt
"Verifique a qualidade deste prompt e apresente propostas de melhoria"
```

### Opções

- nenhuma : Analisa o arquivo atual ou texto selecionado
- `--category <name>` : Verifica apenas categoria específica (structure/execution/restrictions/quality/roles/improvement)
- `--score` : Calcula apenas o score de qualidade
- `--fix` : Proposta de correção automática dos problemas detectados
- `--deep` : Modo de análise profunda (foco em ambiguidade, dispersão de informação, força obrigatória)

### Exemplos Básicos

```bash
# Avaliação geral da qualidade do prompt
cat devin/playbooks/code-review.md
/check-prompt
"Avalie a qualidade deste prompt em 6 categorias e apresente problemas e propostas de melhoria"

# Modo de análise profunda
/check-prompt --deep
"Verifique intensivamente ambiguidade, dispersão de informação e falta de força obrigatória e apresente propostas de melhoria fundamentais"

# Verificação de categoria específica
/check-prompt --category structure
"Verifique este prompt na perspectiva de estrutura e clareza"

# Detecção e correção de expressões ambíguas
/check-prompt --fix
"Detecte expressões ambíguas e proponha correções para expressões claras"
```

---

## Princípios Fundamentais de Design

### Princípio 1: Eliminação Completa de Margem para Interpretação

- **Absolutamente proibido**: "em princípio", "recomendado", "se possível", "dependendo da situação", "julgue adequadamente"
- **Uso obrigatório**: "obrigatoriamente", "absolutamente", "cumprimento rigoroso", "sem exceção", "forçado"
- **Condições de exceção**: Limitação rigorosa com números ("apenas as 3 condições a seguir", "exceto estes 2 casos")

### Princípio 2: Integração Estratégica de Informações

- Integração completa de informações importantes relacionadas em uma seção
- Resumo do quadro geral em checklist de execução
- Eliminação completa de referências circulares ou dispersas

### Princípio 3: Construção de Força Obrigatória por Etapas

- 🔴 (nível de parada de execução) → 🟡 (qualidade importante) → 🟢 (item recomendado) hierarquia clara
- Promoção gradual do nível recomendado para obrigatório
- Demonstração clara do grau de impacto e métodos de tratamento em caso de violação

### Princípio 4: Garantia de Rastreabilidade

- Capacidade de registrar e verificar todos os resultados de execução
- Prevenção técnica de relatórios falsos
- Critérios objetivos de julgamento de sucesso/falha

### Princípio 5: Melhoria Baseada em Feedback

- Aprendizado a partir de casos reais de falha
- Verificação contínua de eficácia
- Detecção automática de novos padrões

---

## 📋 Itens de Verificação Abrangentes

### 1. 📐 Estrutura e Clareza (Pontuação: 25 pontos)

#### 1.1 Exibição de Prioridade de Instruções (8 pontos)

- [ ] Prioridades 🔴🟡🟢 são claramente indicadas em todas as instruções importantes
- [ ] Condições de nível de parada de execução são definidas de forma específica e clara
- [ ] Critérios de julgamento de cada prioridade são objetivos e verificáveis
- [ ] Hierarquia de prioridades é aplicada de forma consistente

#### 1.2 Eliminação Completa de Expressões Ambíguas (9 pontos)

- [ ] **Expressões ambíguas fatais**: "em princípio", "recomendado", "se possível" = 0 ocorrências
- [ ] **Uso de expressões obrigatórias**: Uso apropriado de "obrigatoriamente", "absolutamente", "cumprimento rigoroso", "sem exceção"
- [ ] **Limitação numérica de condições de exceção**: Linhas de demarcação claras como "apenas 3 condições"
- [ ] **Eliminação de margem de julgamento**: Uso apenas de expressões que não permitem múltiplas interpretações
- [ ] **Erradicação de zonas cinzentas**: Critérios claros de julgamento em todas as situações

#### 1.3 Integração Estratégica de Informações (8 pontos)

- [ ] Dispersão de informações importantes em múltiplos locais completamente resolvida
- [ ] Instruções relacionadas logicamente integradas em uma seção
- [ ] Quadro geral completamente resumido em checklist de execução
- [ ] Não existem referências circulares ou loops infinitos

### 2. 🎯 Executabilidade (Pontuação: 20 pontos)

#### 2.1 Integridade de Procedimentos Específicos (7 pontos)

- [ ] Todos os exemplos de comandos são executáveis e verificados
- [ ] Variáveis de ambiente, pré-requisitos e dependências claramente especificados
- [ ] Métodos de tratamento de erros específicos e executáveis
- [ ] Ordem dos procedimentos lógica e com necessidade

#### 2.2 Garantia de Verificabilidade (7 pontos)

- [ ] Sucesso/falha dos resultados de execução podem ser julgados objetivamente
- [ ] Exemplos de saída, formatos de log e valores esperados mostrados especificamente
- [ ] Métodos de teste e procedimentos de verificação implementáveis
- [ ] Pontos de verificação de resultados intermediários adequadamente posicionados

#### 2.3 Adaptabilidade à Automação (6 pontos)

- [ ] Formato fácil para criação de scripts e integração CI/CD
- [ ] Separação clara entre partes de julgamento humano e execução de IA
- [ ] Suporte para processamento em lote e execução paralela

### 3. 🚫 Clarificação de Itens Proibidos (Pontuação: 15 pontos)

#### 3.1 Sistematização de Itens Absolutamente Proibidos (8 pontos)

- [ ] Lista completa de operações que não devem ser executadas
- [ ] Indicação do grau de impacto de violação de cada item proibido (leve/grave/fatal)
- [ ] Apresentação específica de meios alternativos e métodos de contorno
- [ ] Explicação das bases técnicas dos itens proibidos

#### 3.2 Limitação Rigorosa de Condições de Exceção (7 pontos)

- [ ] Condições para reconhecer exceções específicas e limitadas (especificação numérica)
- [ ] Critérios objetivos de julgamento como "completamente duplicado", "explicitamente descrito"
- [ ] Linhas de demarcação claras que não deixam zonas cinzentas
- [ ] Indicação de condições e restrições adicionais ao aplicar exceções

### 4. 📊 Mecanismo de Garantia de Qualidade (Pontuação: 20 pontos)

#### 4.1 Integridade do Sistema de Rastreamento (8 pontos)

- [ ] Função de registro automático e obtenção de estatísticas de todos os resultados de execução
- [ ] Função de verificação que previne tecnicamente relatórios falsos
- [ ] Função de monitoramento em tempo real e alertas
- [ ] Função de prevenção de alteração de logs de auditoria

#### 4.2 Obrigatoriedade de Conformidade com Template (7 pontos)

- [ ] Definição clara de elementos obrigatórios e função de verificação
- [ ] Limitações técnicas em locais proibidos de customização
- [ ] Checkpoints automatizados de confirmação de conformidade
- [ ] Função automática de correção e aviso em caso de violação

#### 4.3 Abrangência do Tratamento de Erros (5 pontos)

- [ ] Catalogação completa de padrões de erro esperados
- [ ] Processo de tratamento por etapas em caso de erro
- [ ] Prevenção técnica de relatar falha como sucesso

### 5. 🎭 Clarificação de Papéis e Responsabilidades (Pontuação: 10 pontos)

#### 5.1 Escopo de Autoridade do AI Agent (5 pontos)

- [ ] Linha de demarcação clara entre operações executáveis e proibidas
- [ ] Escopo específico e restrições da autoridade de julgamento
- [ ] Separação clara de operações que requerem confirmação humana

#### 5.2 Unificação do Sistema de Classificação (5 pontos)

- [ ] Clareza, unicidade e exclusividade das definições de classificação
- [ ] Explicação explícita para prevenir mal-entendidos sobre importância entre classificações
- [ ] Exemplos específicos de uso de cada classificação e fluxograma de julgamento

### 6. 🔄 Melhoria Contínua (Pontuação: 10 pontos)

#### 6.1 Automação da Coleta de Feedback (5 pontos)

- [ ] Extração automática de pontos de melhoria de logs de execução
- [ ] Análise baseada em machine learning de padrões de falha
- [ ] Mecanismo de atualização automática de melhores práticas

#### 6.2 Implementação de Função de Aprendizado (5 pontos)

- [ ] Detecção e classificação automática de novos padrões
- [ ] Monitoramento contínuo da eficácia de regras existentes
- [ ] Proposta automática de melhorias graduais

---

## 🚨 Padrões de Problemas Fatais (Correção Imediata Necessária)

### ❌ Nível 1: Ambiguidade Fatal (Nível de Parada de Execução)

- **Instruções com múltiplas interpretações possíveis**: "julgue adequadamente", "dependendo da situação", "em princípio"
- **Condições ambíguas de exceção**: "em casos especiais", "conforme necessário"
- **Critérios subjetivos de julgamento**: "adequadamente", "suficientemente", "na medida do possível"
- **Conceitos importantes não definidos**: "padrão", "geral", "básico"

### ❌ Nível 2: Defeitos Estruturais (Nível de Qualidade Importante)

- **Dispersão de informações**: Informações importantes relacionadas dispersas em 3 ou mais locais
- **Referência circular**: Loop infinito Seção A→B→C→A
- **Instruções contraditórias**: Instruções opostas em seções diferentes
- **Ordem de execução não clara**: Procedimentos com dependências não claras

### ❌ Nível 3: Degradação da Qualidade (Nível de Melhoria Recomendada)

- **Não verificabilidade**: Critérios de julgamento de sucesso/falha não claros
- **Dificuldade de automação**: Design que depende de julgamento subjetivo humano
- **Dificuldade de manutenção**: Estrutura onde o escopo de impacto de atualizações não pode ser previsto
- **Dificuldade de aprendizado**: Complexidade que leva tempo para novos usuários entenderem

---

## 🎯 Métodos de Melhoria Comprovados

### ✅ Abordagem de Reforço Gradual

1. **Análise da situação atual**: Classificação de problemas, priorização, avaliação do grau de impacto
2. **Prioridade para problemas fatais**: Resolução completa de problemas Nível 1 como máxima prioridade
3. **Implementação gradual**: Não fazer todas as mudanças de uma vez, implementar em unidades verificáveis
4. **Medição de efeitos**: Comparação quantitativa antes e depois da melhoria
5. **Monitoramento contínuo**: Confirmação da sustentabilidade dos efeitos de melhoria

### ✅ Métodos Práticos de Eliminação de Ambiguidade

```markdown
# ❌ Antes da melhoria (ambíguo)

"Pontos apontados devem, em princípio, ser descritos como comentários inline nos locais de mudança correspondentes no GitHub"

# ✅ Depois da melhoria (claro)

"Pontos apontados devem ser obrigatoriamente descritos como comentários inline nos locais de mudança correspondentes no GitHub. Exceções são apenas as 3 condições definidas na Seção 3.3"
```

### ✅ Métodos Práticos de Integração de Informações

```markdown
# ❌ Antes da melhoria (disperso)

Seção 2.1: "Usar 6 seções obrigatórias"
Seção 3.5: "📊 Avaliação geral, 📋 Itens apontados..."
Seção 4.2: "Proibição de deletar seções"

# ✅ Depois da melhoria (integrado)

Checklist de execução:
□ 10. Postar comentário de resumo (usar 6 seções obrigatórias)
🔴 6 seções obrigatórias: 1) 📊 Avaliação geral 2) 📋 Agregação por classificação de itens apontados 3) ⚠️ Principais preocupações 4) ✅ Pontos avaliáveis 5) 🎯 Conclusão 6) 🤖 Auto-avaliação da qualidade do review de IA
❌ Absolutamente proibido: deletar, adicionar, renomear seções
```

### ✅ Padrões de Implementação de Sistema de Rastreamento

```bash
# Rastreamento rigoroso de resultados de execução
POSTED_COMMENTS=0
FAILED_COMMENTS=0
TOTAL_COMMENTS=0

# Registro de resultado de cada operação
if [ $? -eq 0 ]; then
    echo "✅ Sucesso: $OPERATION" >> /tmp/execution_log.txt
    POSTED_COMMENTS=$((POSTED_COMMENTS + 1))
else
    echo "❌ Falha: $OPERATION" >> /tmp/execution_log.txt
    FAILED_COMMENTS=$((FAILED_COMMENTS + 1))
fi

# Prevenção de relatórios falsos
if [ $POSTED_COMMENTS -ne $REPORTED_COMMENTS ]; then
    echo "🚨 Aviso: Número reportado e número real de posts não coincidem"
    exit 1
fi
```

---

## 📈 Cálculo de Score de Qualidade (Versão Melhorada)

### Cálculo do Score Total

```text
Score base = Σ(Score de cada categoria × Pontuação) / 100

Penalidades por problemas fatais:
- Problemas Nível 1: -20 pontos/caso
- Problemas Nível 2: -10 pontos/caso
- Problemas Nível 3: -5 pontos/caso

Elementos de bônus:
- Suporte à automação: +5 pontos
- Implementação de função de aprendizado: +5 pontos
- Casos de melhoria comprovados: +5 pontos

Score final = Score base + Bônus - Penalidades
```

### Julgamento do Nível de Qualidade

```text
95-100 pontos: Padrão mundial mais alto (recomendável como padrão da indústria)
90-94 pontos:  Excelente (operável em produção)
80-89 pontos:  Bom (operável com melhorias menores)
70-79 pontos:  Normal (melhoria necessária)
60-69 pontos:  Requer melhoria (correção substancial necessária)
50-59 pontos:  Requer correção substancial (revisão fundamental necessária)
49 pontos ou menos: Proibido o uso (redesign completo necessário)
```

---

## 🔧 Processo Prático de Melhoria

### Fase 1: Diagnóstico e Análise (1-2 dias)

1. **Compreensão da estrutura geral**: Visualização de configuração de seções, fluxo de informações, relações de dependência
2. **Detecção de ambiguidade**: Extração de todas as expressões com margem de interpretação
3. **Análise de dispersão de informações**: Mapeamento de padrões de dispersão de informações relacionadas
4. **Avaliação de força obrigatória**: Avaliação de classificação e eficácia de recomendado/obrigatório
5. **Confirmação de rastreabilidade**: Avaliação de funções de registro e verificação de resultados de execução

### Fase 2: Priorização e Planejamento (meio dia)

1. **Classificação de criticidade**: Classificação de problemas Nível 1-3 e avaliação do grau de impacto
2. **Determinação da ordem de melhoria**: Ordem ótima considerando relações de interdependência
3. **Alocação de recursos**: Otimização do equilíbrio entre efeito de melhoria e custo
4. **Avaliação de riscos**: Previsão de efeitos colaterais e problemas de compatibilidade durante melhoria

### Fase 3: Implementação Gradual (2-5 dias)

1. **Resolução de problemas Nível 1**: Eliminação completa de ambiguidade fatal
2. **Implementação de integração de informações**: Agregação estratégica de informações dispersas
3. **Reforço de força obrigatória**: Promoção gradual de recomendado → obrigatório
4. **Implementação de sistema de rastreamento**: Função automática de registro e verificação de resultados de execução
5. **Reforço de template**: Clarificação de elementos obrigatórios e obrigatoriedade de conformidade

### Fase 4: Verificação e Ajuste (1-2 dias)

1. **Teste de função**: Confirmação de operação de todos os pontos de mudança
2. **Teste de integração**: Confirmação de consistência do sistema como um todo
3. **Teste de performance**: Confirmação de eficiência de execução e resposta
4. **Teste de usabilidade**: Verificação em cenários reais de uso

### Fase 5: Operação e Monitoramento (contínuo)

1. **Medição de efeitos**: Comparação quantitativa antes e depois da melhoria
2. **Monitoramento contínuo**: Detecção precoce de degradação da qualidade
3. **Coleta de feedback**: Extração de problemas na operação real
4. **Otimização contínua**: Ciclo de melhoria contínua

---

## 📊 Casos Reais de Melhoria (Versão Detalhada)

### Estudo de Caso: Melhoria da Qualidade de Prompt de Grande Escala

#### Situação Antes da Melhoria

```bash
Score de qualidade: 70 pontos/100 pontos
- Expressões ambíguas: 15 locais encontrados
- Dispersão de informações: Informações importantes dispersas em 6 locais
- Falta de força obrigatória: 80% expressões de nível recomendado
- Função de rastreamento: Nenhum registro de resultados de execução
- Tratamento de erros: Métodos de tratamento em caso de falha não claros
```

#### Conteúdos de Melhoria Implementados

```bash
# 1. Eliminação de ambiguidade (2 dias)
- "em princípio" → "exceções são apenas as 3 condições da Seção 3.3"
- "recomendado" → "obrigatório" (nível de importância 2 ou superior)
- "adequadamente" → indicação de critérios específicos de julgamento

# 2. Integração de informações (1 dia)
- Informações dispersas das 6 seções obrigatórias → integradas no checklist de execução
- Itens proibidos relacionados → agregados em uma seção
- Resolução de referências circulares → fluxo linear de informações

# 3. Implementação de sistema de rastreamento (1 dia)
- Registro automático de logs de resultados de execução
- Função de verificação para prevenção de relatórios falsos
- Exibição de estatísticas em tempo real

# 4. Reforço do tratamento de erros (meio dia)
- Catalogação completa de padrões de erro esperados
- Documentação de processo de tratamento por etapas
- Implementação de função de recuperação automática
```

#### Resultados Após Melhoria

```bash
Score de qualidade: 90 pontos/100 pontos (+20 pontos de melhoria)
- Expressões ambíguas: 0 locais (eliminação completa)
- Integração de informações: Informações importantes agregadas em 3 locais
- Força obrigatória: 95% expressões de nível obrigatório
- Função de rastreamento: Automação completa
- Tratamento de erros: 90% dos problemas resolvidos automaticamente

Efeitos reais de melhoria:
- Erros de julgamento: 85% de redução
- Tempo de execução: 40% de redução
- Taxa de ocorrência de erros: 70% de redução
- Satisfação do usuário: 95% de melhoria
```

### Lições Aprendidas e Melhores Práticas

#### Fatores de Sucesso

1. **Abordagem gradual**: Não fazer todas as mudanças de uma vez, implementar em unidades verificáveis
2. **Baseado em dados**: Melhoria baseada em dados medidos, não julgamento subjetivo
3. **Monitoramento contínuo**: Confirmação periódica da sustentabilidade dos efeitos de melhoria
4. **Foco no feedback**: Coleta ativa de opiniões de usuários reais

#### Estratégias para Evitar Falhas

1. **Perfeccionismo excessivo**: Começar operação ao atingir 90 pontos, buscar 100 pontos com melhoria contínua
2. **Perigo de mudanças em lote**: Implementar sempre mudanças de grande escala de forma gradual
3. **Compatibilidade com versões anteriores**: Minimizar impacto em workflows existentes
4. **Falta de documentação**: Registrar e compartilhar todas as mudanças detalhadamente

---

### Integração com Claude

```bash
# Verificação de qualidade combinando com arquivo de prompt
cat your-prompt.md
/check-prompt
"Avalie a qualidade deste prompt e proponha pontos de melhoria"

# Comparação de múltiplos arquivos de prompt
cat prompt-v1.md && echo "---" && cat prompt-v2.md
/check-prompt
"Compare as duas versões e analise pontos melhorados e desafios restantes"

# Análise combinando com log de erros reais
cat execution-errors.log
/check-prompt --deep
"Identifique problemas no prompt que podem ter causado este erro"
```

### Observações

- **Pré-requisitos**: Recomenda-se que os arquivos de prompt sejam descritos em formato Markdown
- **Limitações**: Para prompts de grande escala (mais de 10 mil linhas), recomenda-se dividir para análise
- **Recomendação**: Implemente verificações regulares de qualidade de prompt e melhore continuamente

---

_Esta checklist é uma versão completa de conhecimentos comprovados em projetos reais de melhoria de prompts e continua evoluindo continuamente._
