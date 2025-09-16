## Multi Role

Comando que realiza análise paralela do mesmo objeto com múltiplos roles e gera relatório integrado.

### Como usar

```bash
/multi-role <role1>,<role2> [--agent|-a] [objeto de análise]
/multi-role <role1>,<role2>,<role3> [--agent|-a] [objeto de análise]
```

**Importante**:

- A opção `--agent` deve ser colocada imediatamente após a especificação dos roles
- A mensagem deve ser escrita após `--agent`
- Exemplo correto: `/multi-role qa,architect --agent avalie o plano`
- Exemplo incorreto: `/multi-role qa,architect avalie o plano --agent`

### Opções

- `--agent` ou `-a` : Executa cada role como subagente em paralelo (recomendado para análises em larga escala)
  - Quando esta opção é usada, se a descrição de cada role contém frases de promoção de delegação automática (como "use PROACTIVELY"), uma delegação automática mais agressiva será habilitada

### Exemplos Básicos

```bash
# Análise de segurança e performance (normal)
/multi-role security,performance
"Avalie este endpoint de API"

# Análise paralela de sistema em larga escala (subagente)
/multi-role security,performance --agent
"Analise comprehensivamente a segurança e performance de todo o sistema"

# Análise integrada de frontend, mobile e performance
/multi-role frontend,mobile,performance
"Considere propostas de otimização desta tela"

# Avaliação multifacetada de design arquitetural (subagente)
/multi-role architect,security,performance --agent
"Avalie o design de migração para microsserviços"
```

### Processo de Análise

### Phase 1: Análise Paralela

Cada role analisa independentemente o mesmo objeto

- Execução de avaliação do ponto de vista especializado
- Julgamento com critérios específicos do role
- Geração de recomendações independentes

### Phase 2: Análise de Integração

Estrutura e integra os resultados

- Organização dos resultados de avaliação de cada role
- Identificação de sobreposições e pontos contraditórios
- Clarificação de relacionamentos complementares

### Phase 3: Relatório Integrado

Geração de recomendações finais

- Plano de ação com prioridades
- Explicitação de trade-offs
- Apresentação de roadmap de implementação

### Exemplo de Formato de Saída

### Caso de análise com 2 roles

```text
Análise Multi-Role: Security + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Objeto de análise: Endpoint API /api/users

Resultado da análise Security:
Autenticação: Verificação JWT implementada adequadamente
Autorização: Controle de acesso baseado em roles incompleto
Criptografia: Chave API sendo outputada em texto plano nos logs

Score de avaliação: 65/100
Importância: Alta (devido ao acesso a dados confidenciais)

Resultado da análise Performance:
Tempo de resposta: Média 180ms (meta: dentro de 200ms)
Query de banco de dados: Problema N+1 detectado
Cache: Cache Redis não implementado

Score de avaliação: 70/100
Importância: Média (dentro do range aceitável atualmente)

Análise de correlação:
Oportunidades sinérgicas:
- Considerar criptografia simultaneamente na implementação do cache Redis
- Melhoria na saída de logs beneficia segurança + performance

Pontos de trade-off:
- Reforço da verificação de autorização ↔ Impacto no tempo de resposta
- Criptografia de logs ↔ Redução da eficiência de debug

Prioridade integrada:
Critical: Correção da saída de chave API em texto plano
High: Resolução de query N+1
Medium: Implementação de cache Redis + criptografia
Low: Detalhamento do controle de autorização

Roadmap de implementação:
Semana 1: Implementação de mascaramento de chave API
Semana 2: Otimização de query de banco de dados
Semana 3-4: Design e implementação de camada de cache
Mês 2: Reforço gradual do controle de autorização
```

### Caso de análise com 3 roles

```text
Análise Multi-Role: Frontend + Mobile + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Objeto de análise: Tela de perfil do usuário

Resultado da análise Frontend:
Usabilidade: Layout intuitivo
Acessibilidade: Taxa de conformidade WCAG 2.1: 85%
Responsivo: Problemas na exibição em tablet

Resultado da análise Mobile:
Touch target: Mais de 44pt garantido
Operação com uma mão: Botões importantes posicionados na parte superior
Suporte offline: Não implementado

Resultado da análise Performance:
Exibição inicial: LCP 2.1 segundos (bom)
Otimização de imagens: WebP não suportado
Carregamento tardio: Não implementado

Recomendações integradas:
1. Otimização mobile (operação com uma mão + suporte offline)
2. Otimização de imagens (WebP + carregamento tardio)
3. Melhoria da UI para tablet

Prioridade: Mobile > Performance > Frontend
Período de implementação: 3-4 semanas
```

### Padrões de Combinação Eficazes

### Foco em Segurança

```bash
/multi-role security,architect
"Design do sistema de autenticação"

/multi-role security,frontend
"Segurança da tela de login"

/multi-role security,mobile
"Proteção de dados do app mobile"
```

### Foco em Performance

```bash
/multi-role performance,architect
"Design de escalabilidade"

/multi-role performance,frontend
"Aceleração de páginas web"

/multi-role performance,mobile
"Otimização de operação do app"
```

### Foco na Experiência do Usuário

```bash
/multi-role frontend,mobile
"UI multiplataforma"

/multi-role frontend,performance
"Equilíbrio entre UX e performance"

/multi-role mobile,performance
"Otimização de UX mobile"
```

### Análise Abrangente

```bash
/multi-role architect,security,performance
"Avaliação de todo o sistema"

/multi-role frontend,mobile,performance
"Avaliação geral da experiência do usuário"

/multi-role security,performance,mobile
"Diagnóstico geral do app mobile"
```

### Integração com Claude

```bash
# Combinação com análise de arquivos
cat src/components/UserProfile.tsx
/multi-role frontend,mobile
"Avalie este componente de múltiplas perspectivas"

# Avaliação de documento de design
cat architecture-design.md
/multi-role architect,security,performance
"Avalie este design em múltiplas áreas especializadas"

# Análise de erros
cat performance-issues.log
/multi-role performance,analyzer
"Analise problemas de performance de múltiplos ângulos"
```

### Diferenciação entre multi-role vs role-debate

### Quando usar multi-role

- Quer avaliação independente de cada área especializada
- Quer elaborar plano de melhorias integrado
- Quer organizar contradições e sobreposições
- Quer decidir prioridade de implementação

### Quando usar role-debate

- Há trade-offs entre áreas especializadas
- Opiniões podem se dividir na seleção técnica
- Quer decidir política de design através de discussão
- Quer ouvir discussão de diferentes perspectivas

### Execução Paralela de Subagentes (--agent)

Usando a opção `--agent`, cada role é executado em paralelo como subagente independente.

#### Promoção de Delegação Automática

Quando o campo description dos arquivos de role contém frases como as seguintes, uma delegação automática mais agressiva é habilitada no uso de `--agent`:

- "use PROACTIVELY"
- "MUST BE USED"
- Outras expressões de ênfase

#### Fluxo de Execução

```text
Execução normal:
Role 1 → Role 2 → Role 3 → Integração
(Execução sequencial, cerca de 3-5 minutos)

Execução --agent:
Role 1 ─┐
Role 2 ─┼→ Integração
Role 3 ─┘
(Execução paralela, cerca de 1-2 minutos)
```

#### Exemplos de Uso Eficaz

```bash
# Avaliação geral de sistema em larga escala
/multi-role architect,security,performance,qa --agent
"Avaliação abrangente do novo sistema"

# Análise detalhada de múltiplas perspectivas
/multi-role frontend,mobile,performance --agent
"Análise de otimização UX de todas as telas"
```

#### Comparação de Performance

| Número de Roles | Execução Normal | Execução --agent | Taxa de Redução |
| --------------- | --------------- | ---------------- | --------------- |
| 2 roles         | 2-3 min         | 1 min            | 50%             |
| 3 roles         | 3-5 min         | 1-2 min          | 60%             |
| 4 roles         | 5-8 min         | 2-3 min          | 65%             |

### Observações

- Execução simultânea de 3 ou mais roles pode resultar em saída longa
- Análises complexas podem levar mais tempo de execução
- Se surgirem recomendações mutuamente contraditórias, considere também role-debate
- A decisão final deve ser tomada pelo usuário com base nos resultados integrados
- **Ao usar --agent**: Usa mais recursos, mas é eficiente para análises em larga escala
