## Rust Dependencies Update

Atualiza com segurança as dependências de projetos Rust.

### Uso

```bash
# Verificar estado das dependências e solicitar ao Claude
cargo tree
"Atualize as dependências do Cargo.toml para as versões mais recentes"
```

### Exemplos básicos

```bash
# Verificar dependências atuais
cat Cargo.toml
"Analise as dependências deste projeto Rust e me informe quais crates podem ser atualizados"

# Verificar lista de possíveis atualizações
cargo update --dry-run
"Analise o nível de risco na atualização destes crates"
```

### Integração com Claude

```bash
# Atualização abrangente de dependências
cat Cargo.toml
"Analise as dependências do Rust e execute o seguinte:
1. Investigar as versões mais recentes de cada crate
2. Verificar presença de mudanças disruptivas
3. Avaliar nível de risco (seguro/atenção/perigoso)
4. Sugerir alterações de código necessárias
5. Gerar Cargo.toml atualizado"

# Atualização segura e gradual
cargo tree
"Evitando atualizações de versão major, atualize apenas crates que podem ser atualizados com segurança"

# Análise de impacto de crate específico
"Informe o impacto e mudanças necessárias se atualizar o tokio para a versão mais recente"
```

### Exemplos detalhados

```bash
# Análise detalhada incluindo Release Notes
cat Cargo.toml && cargo tree
"Analise as dependências e para cada crate apresente:
1. Versão atual → versão mais recente
2. Avaliação de risco (seguro/atenção/perigoso)
3. Principais alterações (do CHANGELOG)
4. Mudanças em trait bounds
5. Correções de código necessárias
em formato de tabela"

# Análise de migração de runtime assíncrono
cat Cargo.toml src/main.rs
"Apresente todas as mudanças necessárias para migração de async-std para tokio, ou atualização de versão major do tokio"
```

### Critérios de nível de risco

```
Seguro (🟢):
- Atualização de versão de patch (0.1.2 → 0.1.3)
- Apenas correções de bug
- Garantia de compatibilidade retroativa

Atenção (🟡):
- Atualização de versão minor (0.1.0 → 0.2.0)
- Adição de novas funcionalidades
- Avisos de descontinuação

Perigoso (🔴):
- Atualização de versão major (0.x.y → 1.0.0, 1.x.y → 2.0.0)
- Mudanças disruptivas
- Remoção/alteração de API
- Mudanças em trait bounds
```

### Execução da atualização

```bash
# Criar backup
cp Cargo.toml Cargo.toml.backup
cp Cargo.lock Cargo.lock.backup

# Executar atualização
cargo update

# Verificação após atualização
cargo check
cargo test
cargo clippy
```

### Observações

Sempre realize verificação de funcionamento após a atualização. Em caso de problemas, restaure usando:

```bash
cp Cargo.toml.backup Cargo.toml
cp Cargo.lock.backup Cargo.lock
cargo build
```
