## Gemini Web Search

Executa busca na Web usando Gemini CLI para obter informações mais recentes.

### Como usar

```bash
# Busca na Web via Gemini CLI (obrigatório)
gemini --prompt "WebSearch: <consulta de busca>"
```

### Exemplos Básicos

```bash
# Usar Gemini CLI
gemini --prompt "WebSearch: React 19 novas funcionalidades"
gemini --prompt "WebSearch: TypeError Cannot read property of undefined método de resolução"
```

### Integração com Claude

```bash
# Busca e resumo de documentação
gemini --prompt "WebSearch: Next.js 14 App Router documentação oficial"
"Resuma os resultados da busca e explique as principais funcionalidades"

# Investigação de erros
cat error.log
gemini --prompt "WebSearch: [mensagem de erro] método de resolução"
"Proponha o método de resolução mais adequado dos resultados da busca"

# Comparação técnica
gemini --prompt "WebSearch: Rust vs Go performance benchmark 2024"
"Resuma as diferenças de performance dos resultados da busca"
```

### Exemplos Detalhados

```bash
# Coleta de informações de múltiplas fontes
gemini --prompt "WebSearch: GraphQL best practices 2024 multiple sources"
"Compile informações de múltiplas fontes confiáveis dos resultados da busca"

# Investigação de mudanças cronológicas
gemini --prompt "WebSearch: JavaScript ES2015 ES2016 ES2017 ES2018 ES2019 ES2020 ES2021 ES2022 ES2023 ES2024 features"
"Resuma as principais mudanças de cada versão em ordem cronológica"

# Busca restrita a domínio específico
gemini --prompt "WebSearch: site:github.com Rust WebAssembly projects stars:>1000"
"Liste 10 projetos em ordem de número de estrelas"

# Informações mais recentes de segurança
gemini --prompt "WebSearch: CVE-2024 Node.js vulnerabilities"
"Resuma o impacto e contramedidas das vulnerabilidades encontradas"
```

### Itens Proibidos

- **É proibido usar a ferramenta WebSearch integrada do Claude**
- Quando busca na Web for necessária, sempre usar `gemini --prompt "WebSearch: ..."`

### Observações

- **Quando Gemini CLI estiver disponível, sempre usar `gemini --prompt "WebSearch: ..."`**
- Os resultados de busca na Web nem sempre são os mais recentes
- É recomendado confirmar informações importantes na documentação oficial ou fontes confiáveis
