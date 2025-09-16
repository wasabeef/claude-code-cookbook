## Verificar Fatos

Comando para verificar a precisão de informações fornecidas, referenciando a base de código do projeto e documentação (docs/, README.md, etc.).

### Uso

```bash
# Uso básico
/check-fact "O aplicativo Flutter usa Riverpod"

# Verificar múltiplas informações de uma vez
/check-fact "Este projeto usa GraphQL e gerencia roteamento com auto_route"

# Verificar especificações técnicas específicas
/check-fact "A autenticação usa JWT e não usa Firebase Auth"
```

### Processo de Verificação

1. **Prioridade das Fontes de Informação**
   - Base de código (mais confiável)
   - README.md, documentação em docs/
   - Arquivos de configuração como package.json, pubspec.yaml
   - Histórico de discussões em Issues e Pull Requests

2. **Classificação dos Resultados**
   - `✅ Correto` - A informação coincide completamente com a base de código
   - `❌ Incorreto` - A informação está claramente errada
   - `⚠️ Parcialmente correto` - Parcialmente preciso, mas incompleto
   - `❓ Não pode julgar` - Falta informação necessária para verificação

3. **Demonstração de Evidências**
   - Nome do arquivo e número da linha
   - Trechos de código relevantes
   - Seção correspondente da documentação

### Formato do Relatório

```text
## Resultado da Verificação de Fatos

### Alvo de Verificação
"[Informação fornecida pelo usuário]"

### Conclusão
[✅/❌/⚠️/❓] [Resultado da avaliação]

### Evidência
- **Arquivo**: `path/to/file.dart:123`
- **Conteúdo**: [Código/texto correspondente]
- **Observação**: [Explicação adicional]

### Explicação Detalhada
[Se incorreto, apresentar informação correta]
[Se parcialmente correto, apontar partes imprecisas]
[Se não pode julgar, explicar informação em falta]
```

### Exemplos Básicos

```bash
# Verificação da stack tecnológica do projeto
/check-fact "Este app tem configuração Flutter + Riverpod + GraphQL"

# Verificação do status de implementação
/check-fact "A funcionalidade de modo escuro está implementada e pode ser alternada nas configurações do usuário"

# Verificação da arquitetura
/check-fact "Todo gerenciamento de estado é feito com Riverpod, não usa BLoC"

# Verificação de implementação de segurança
/check-fact "Tokens de autenticação são armazenados criptografados no secure storage"
```

### Integração com Claude

```bash
# Verificação após análise completa da base de código
ls -la && find . -name "pubspec.yaml" -exec cat {} \;
/check-fact "As principais dependências usadas neste projeto são..."

# Verificação do status de implementação de funcionalidades específicas
grep -r "authentication" . --include="*.dart"
/check-fact "A funcionalidade de autenticação é implementação customizada, não usa autenticação de terceiros"

# Verificação de consistência com documentação
cat README.md
/check-fact "Todas as funcionalidades descritas no README estão implementadas"
```

### Cenários de Uso

- Criação de especificações técnicas: Verificação da precisão do conteúdo
- Transferência de projeto: Verificação de compreensão da implementação existente
- Antes de relatórios ao cliente: Verificação factual do status de implementação
- Escrita de blog técnico: Verificação da precisão do conteúdo do artigo
- Criação de materiais para entrevista/apresentação: Verificação da precisão do resumo do projeto

### Observações

- A base de código é a fonte de informação mais confiável
- Quando a documentação está desatualizada, a implementação tem prioridade
- Se falta informação necessária para julgamento, honestamente marcar como "não pode julgar"
- Informações relacionadas à segurança são verificadas com especial cuidado
