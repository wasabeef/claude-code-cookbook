## Node Dependencies Update

Atualiza com segurança as dependências de projetos Node.js.

### Uso

```bash
# Verificar estado das dependências e solicitar ao Claude
npm outdated
"Atualize as dependências do package.json para as versões mais recentes"
```

### Exemplos básicos

```bash
# Verificar dependências atuais
cat package.json
"Analise as dependências deste projeto Node.js e me informe quais pacotes podem ser atualizados"

# Verificar lista de possíveis atualizações
npm outdated
"Analise o nível de risco na atualização destes pacotes"
```

### Integração com Claude

```bash
# Atualização abrangente de dependências
cat package.json
"Analise as dependências do Node.js e execute o seguinte:
1. Investigar as versões mais recentes de cada pacote
2. Verificar presença de mudanças disruptivas
3. Avaliar nível de risco (seguro/atenção/perigoso)
4. Sugerir alterações de código necessárias
5. Gerar package.json atualizado"

# Atualização segura e gradual
npm outdated
"Evitando atualizações de versão major, atualize apenas pacotes que podem ser atualizados com segurança"

# Análise de impacto de pacote específico
"Informe o impacto e mudanças necessárias se atualizar o express para a versão mais recente"
```

### Exemplos detalhados

```bash
# Análise detalhada incluindo Release Notes
cat package.json && npm outdated
"Analise as dependências e para cada pacote apresente:
1. Versão atual → versão mais recente
2. Avaliação de risco (seguro/atenção/perigoso)
3. Principais alterações (do CHANGELOG)
4. Correções de código necessárias
em formato de tabela"

# Consideração de definições de tipo para projetos TypeScript
cat package.json tsconfig.json
"Inclua também definições de tipo do TypeScript na atualização de dependências e crie plano de atualização que evite erros de tipo"
```

### Critérios de nível de risco

```
Seguro (🟢):
- Atualização de versão de patch (1.2.3 → 1.2.4)
- Apenas correções de bug
- Garantia de compatibilidade retroativa

Atenção (🟡):
- Atualização de versão minor (1.2.3 → 1.3.0)
- Adição de novas funcionalidades
- Avisos de descontinuação

Perigoso (🔴):
- Atualização de versão major (1.2.3 → 2.0.0)
- Mudanças disruptivas
- Remoção/alteração de API
```

### Execução da atualização

```bash
# Criar backup
cp package.json package.json.backup
cp package-lock.json package-lock.json.backup

# Executar atualização
npm update

# Verificação após atualização
npm test
npm run build
npm audit
```

### Observações

Sempre realize verificação de funcionamento após a atualização. Em caso de problemas, restaure usando:

```bash
cp package.json.backup package.json
cp package-lock.json.backup package-lock.json
npm install
```
