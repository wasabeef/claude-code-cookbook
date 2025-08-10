## AI Writing Check

Detecta padrões mecânicos de textos gerados por IA e propõe melhorias para um português mais natural.

### Uso

```bash
/ai-writing-check [opções]
```

### Opções

- nenhuma : Analisa o arquivo atual ou texto selecionado
- `--file <path>` : Analisa arquivo específico
- `--dir <path>` : Análise em lote de arquivos no diretório
- `--severity <level>` : Nível de detecção (all/high/medium)
- `--fix` : Corrige automaticamente padrões detectados

### Exemplos básicos

```bash
# Verificar artificialidade de IA no arquivo
cat README.md
/ai-writing-check
"Verifique a artificialidade de IA neste documento e apresente sugestões de melhoria"

# Análise de arquivo específico
/ai-writing-check --file docs/guide.md
"Detecte expressões que parecem IA e sugira correções para expressões naturais"

# Escaneamento de projeto inteiro
/ai-writing-check --dir . --severity high
"Reporte apenas problemas importantes de artificialidade de IA no projeto"
```

### Padrões de detecção

#### 1. Padrões mecânicos de formato de lista

```markdown
Exemplos detectados:

- **Importante**: Este é um item importante
- Item concluído (com marca de verificação)
- Tópico quente (com emoji de fogo)
- Pronto para início (com emoji de foguete)

Exemplos melhorados:

- Item importante: Este é um item importante
- Item concluído
- Tópico em destaque
- Pronto para início
```

#### 2. Expressões exageradas e de hype

```markdown
Exemplos detectados:
Revolucionará a indústria com tecnologia revolucionária.
Isso resolverá completamente o problema.
Funciona como mágica.

Exemplos melhorados:
Trará mudanças à indústria com tecnologia eficaz.
Resolve muitos problemas.
Funciona de forma fluida.
```

#### 3. Padrões mecânicos de ênfase

```markdown
Exemplos detectados:
**Ideia**: Há uma nova proposta (com emoji de lâmpada)
**Atenção**: Aviso importante (com emoji de alerta)

Exemplos melhorados:
Ideia: Há uma nova proposta
Observação: Aviso importante
```

#### 4. Escrita técnica redundante

```markdown
Exemplos detectados:
Primeiro, vamos configurar as configurações.
Você pode usar esta ferramenta.
O desempenho melhora significativamente.

Exemplos melhorados:
Primeiro, vamos configurar.
Você pode usar esta ferramenta.
O desempenho melhora 30%.
```

### Integração com Claude

```bash
# Análise de artificialidade de IA do documento inteiro
cat article.md
/ai-writing-check
"Analise sob os seguintes aspectos e apresente sugestões de melhoria:
1. Detecção de expressões mecânicas
2. Sugestões de correção para português natural
3. Lista de melhorias por prioridade"

# Foco em padrões específicos
/ai-writing-check --file blog.md
"Foque especialmente em expressões exageradas e expressões redundantes para sugerir melhorias"

# Verificação em lote de múltiplos arquivos
find . -name "*.md" -type f
/ai-writing-check --dir docs/
"Analise a artificialidade de IA de toda a documentação e crie resumo"
```

### Exemplos detalhados

```bash
# Comparação antes e depois das melhorias
/ai-writing-check --file draft.md
"Detecte expressões que parecem IA e apresente no seguinte formato:
- Partes problemáticas (com número da linha)
- Tipo e motivo do problema
- Sugestão específica de melhoria
- Efeito da melhoria"

# Modo de correção automática
/ai-writing-check --file report.md --fix
"Corrija automaticamente padrões detectados e relate resultados"

# Relatório de artificialidade de IA do projeto
/ai-writing-check --dir . --severity all
"Analise a artificialidade de IA de todo o projeto e forneça:
1. Informações estatísticas (número de detecções por padrão)
2. TOP 5 arquivos mais problemáticos
3. Matrix de prioridade de melhoria
4. Plano de melhoria em fases"
```

### Exemplos de uso avançado

```bash
# Aplicação de regras personalizadas
/ai-writing-check --file spec.md
"Verifique como especificação técnica com os seguintes critérios adicionais:
- Expressões ambíguas (adequado, conforme necessário)
- Falta de especificidade (rápido → valores numéricos específicos)
- Uso inconsistente de terminologia"

# Verificação para integração CI/CD
/ai-writing-check --dir docs/ --severity high
"Gere resultados em formato executável pelo GitHub Actions:
- Número de erros e nomes de arquivos
- Números de linha que precisam de correção
- Configuração de exit code"

# Verificação de conformidade com guia de estilo
/ai-writing-check --file manual.md
"Verificação adicional baseada no guia de estilo da empresa:
- Uso de linguagem formal (unificação de tom formal)
- Uso adequado de terminologia especializada
- Consideração pelo leitor"
```

### Observações

- A determinação de artificialidade de IA varia conforme o contexto, então trate as sugestões como referência
- Ajuste os critérios conforme o tipo de documento: documentos técnicos, blogs, manuais, etc.
- Não é necessário aceitar todas as sugestões; selecione as apropriadas
- A opção `--fix` corrige automaticamente padrões detectados

### Comportamento na execução do comando

Quando o comando `/ai-writing-check` é executado, Claude realiza os seguintes processos:

1. **Detecção de padrões**: Detecta padrões que parecem IA nos arquivos ou textos especificados
2. **Sugestões específicas de correção**: Apresenta sugestões de correção com número de linha para cada problema
3. **Modo --fix**: Corrige automaticamente padrões detectados e exibe resumo dos resultados
4. **Geração de relatório**: Fornece número de detecções, prioridade de melhoria e comparação antes/depois

Claude lê o conteúdo real dos arquivos e executa análise baseada nas regras do textlint-rule-preset-ai-writing.

### Referência

Este comando foi criado com base no conjunto de regras do [textlint-rule-preset-ai-writing](https://github.com/textlint-ja/textlint-rule-preset-ai-writing). É um preset de regras textlint para detectar padrões mecânicos de textos gerados por IA e promover expressões mais naturais.
