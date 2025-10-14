## Code Explain

Explica detalhadamente o funcionamento do código.

### Uso

```bash
# Exibir conteúdo do arquivo e solicitar ao Claude
cat <file>
"Explique o funcionamento deste código"
```

### Exemplos Básicos

```bash
# Compreender ownership do Rust
cat main.rs
"Explique do ponto de vista de ownership e lifetime do Rust"

# Explicação de algoritmo
grep -A 50 "quicksort" sort.rs
"Explique o mecanismo e a complexidade deste algoritmo de ordenação"

# Explicação de padrões de design
cat factory.rs
"Explique os padrões de design utilizados e suas vantagens"
```

### Integração com Claude

```bash
# Explicação para iniciantes
cat complex_function.py
"Explique este código linha por linha de forma fácil para iniciantes"

# Análise de performance
cat algorithm.rs
"Apresente os problemas de performance deste código e sugestões de melhoria"

# Explicação com diagrama
cat state_machine.js
"Explique o fluxo de processamento deste código com diagrama em ASCII art"

# Revisão de segurança
cat auth_handler.go
"Aponte as preocupações de segurança deste código"
```

### Exemplos Detalhados

```bash
# Explicação de lógica complexa
cat recursive_parser.rs
"Explique o funcionamento deste parser recursivo sob os seguintes aspectos:
1. Fluxo geral de processamento
2. Papel e responsabilidade de cada função
3. Tratamento de casos extremos
4. Pontos que podem ser melhorados"

# Explicação de processamento assíncrono
cat async_handler.ts
"Explique sobre este processamento assíncrono:
1. Fluxo da cadeia de Promises
2. Mecanismo de tratamento de erros
3. Presença de processamento paralelo
4. Possibilidade de deadlock"

# Explicação de arquitetura
ls -la src/ && cat src/main.rs src/lib.rs
"Explique a arquitetura e estrutura de módulos deste projeto"
```

### Observações

Na explicação de código, além de simplesmente explicar o funcionamento, também fornece insights profundos sobre por que foi implementado dessa forma, quais são as vantagens e quais são os problemas potenciais.
