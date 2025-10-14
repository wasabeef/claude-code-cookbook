## Nome do Comando

Descrição concisa do comando (explicar em uma linha o que o comando faz).

<!--
Notas para usar o template:
- Seções obrigatórias: Título, Descrição, Uso, Exemplos Básicos, Integração com Claude, Observações
- Seções opcionais: Opções, Funcionalidades Detalhadas, Exemplos de Saída, Melhores Práticas, Comandos Relacionados
- Use apenas as seções necessárias de acordo com a complexidade do comando
-->

### Uso

```bash
/command-name [opções]
```

### Opções

- Nenhuma : Comportamento padrão
- `--option1` : Descrição da opção 1
- `--option2 <valor>` : Descrição da opção que aceita parâmetro
- `--flag` : Descrição da opção de flag

Nota: Você pode omitir toda esta seção se o comando não requer opções.

### Exemplos Básicos

```bash
# Uso básico
/command-name
"Explicação ao executar"

# Exemplo com opção
/command-name --option1
"Explicação ao usar a opção 1"

# Exemplo com opção parametrizada
/command-name --option2 value
"Exemplo de uso de opção parametrizada"

# Combinação de múltiplas opções
/command-name --option1 --flag
"Exemplo combinando múltiplas opções"
```

### Funcionalidades Detalhadas (Opcional)

#### Categoria de Funcionalidade 1

Descrição detalhada da funcionalidade e cenários de uso.

```bash
# Exemplo de código específico
command example
```

#### Categoria de Funcionalidade 2

Descrição detalhada de outra funcionalidade.

- **Característica 1**: Descrição
- **Característica 2**: Descrição
- **Característica 3**: Descrição

Nota: Para comandos simples, você pode omitir esta seção.

### Exemplos de Saída (Opcional)

```text
Exemplo do formato de saída esperado
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Amostra do conteúdo de saída real
├─ Item 1: Valor
├─ Item 2: Valor
└─ Item 3: Valor
```

Nota: Você pode omitir esta seção se a saída for simples ou suficientemente explicada nos exemplos básicos.

### Integração com Claude

```bash
# Exemplo de uso com arquivos
cat file.txt
/command-name
"Solicitar análise incluindo conteúdo do arquivo"

# Exemplo de uso em pipeline
command1 | command2
/command-name
"Processamento usando saída do comando anterior"

# Exemplo de análise complexa
ls -la && cat config.json
/command-name --option1
"Análise combinando múltiplas fontes de informação"
```

### Observações

- **Pré-requisitos**: Requisitos necessários para executar o comando
- **Limitações**: Limitações funcionais e pontos a observar
- **Recomendações**: Recomendações para uso efetivo

### Melhores Práticas (Opcional)

1. **Princípio 1**: Explicação do método de uso recomendado
2. **Princípio 2**: Explicação de métodos de uso a evitar
3. **Princípio 3**: Recomendações sobre desempenho e eficiência
4. **Princípio 4**: Recomendações sobre segurança e proteção

Nota: Você pode omitir esta seção para comandos simples sem considerações especiais.

### Comandos Relacionados (Opcional)

- `/related-command1` : Comando com funcionalidade relacionada
- `/related-command2` : Comando que funciona efetivamente em combinação
- `/related-command3` : Comando que pode ser usado como alternativa

Nota: Você pode omitir esta seção se não houver comandos relacionados.
