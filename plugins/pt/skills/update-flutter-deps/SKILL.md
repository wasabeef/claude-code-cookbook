---
description: "Atualizar dependências Flutter com segurança"
---

## Flutter Dependencies Update

Atualiza com segurança as dependências de projetos Flutter.

### Uso

```bash
# Verificar estado das dependências e solicitar ao Claude
flutter pub deps --style=compact
"Atualize as dependências do pubspec.yaml para as versões mais recentes"
```

### Exemplos básicos

```bash
# Verificar dependências atuais
cat pubspec.yaml
"Analise as dependências deste projeto Flutter e me informe quais pacotes podem ser atualizados"

# Verificação após upgrade
flutter pub upgrade --dry-run
"Verifique se há mudanças disruptivas no conteúdo planejado para este upgrade"
```

### Integração com Claude

```bash
# Atualização abrangente de dependências
cat pubspec.yaml
"Analise as dependências do Flutter e execute o seguinte:
1. Investigar as versões mais recentes de cada pacote
2. Verificar presença de mudanças disruptivas
3. Avaliar nível de risco (seguro/atenção/perigoso)
4. Sugerir alterações de código necessárias
5. Gerar pubspec.yaml atualizado"

# Atualização segura e gradual
flutter pub outdated
"Evitando atualizações de versão major, atualize apenas pacotes que podem ser atualizados com segurança"

# Análise de impacto de pacote específico
"Informe o impacto e mudanças necessárias se atualizar o provider para a versão mais recente"
```

### Exemplos detalhados

```bash
# Análise detalhada incluindo Release Notes
cat pubspec.yaml && flutter pub outdated
"Analise as dependências e para cada pacote apresente:
1. Versão atual → versão mais recente
2. Avaliação de risco (seguro/atenção/perigoso)
3. Principais alterações (do CHANGELOG)
4. Correções de código necessárias
em formato de tabela"

# Análise de migração para Null Safety
cat pubspec.yaml
"Identifique pacotes que não suportam Null Safety e crie um plano de migração"
```

### Critérios de nível de risco

```text
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
cp pubspec.yaml pubspec.yaml.backup
cp pubspec.lock pubspec.lock.backup

# Executar atualização
flutter pub upgrade

# Verificação após atualização
flutter analyze
flutter test
flutter pub deps --style=compact
```

### Observações

Sempre realize verificação de funcionamento após a atualização. Em caso de problemas, restaure usando:

```bash
cp pubspec.yaml.backup pubspec.yaml
cp pubspec.lock.backup pubspec.lock
flutter pub get
```
