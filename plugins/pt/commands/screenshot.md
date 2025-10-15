## Screenshot

Captura screenshots no macOS e analisa as imagens.

### Como usar

```bash
/screenshot [opções]
```

### Opções

- nenhuma : Seleciona janela (Claude confirma as opções)
- `--window` : Especifica e captura janela
- `--full` : Captura tela inteira
- `--crop` : Seleciona região para captura

### Exemplos Básicos

```bash
# Captura janela e analisa
/screenshot --window
"Analise a tela capturada"

# Seleciona região e analisa
/screenshot --crop
"Descreva o conteúdo da região selecionada"

# Captura tela inteira e analisa
/screenshot --full
"Analise a composição de toda a tela"
```

### Integração com Claude

```bash
# Sem problema específico - análise da situação
/screenshot --crop
(Claude automaticamente analisa o conteúdo da tela e descreve elementos e composição)

# Análise de problemas de UI/UX
/screenshot --window
"Proponha pontos problemáticos desta UI e sugestões de melhoria"

# Análise de erros
/screenshot --window
"Ensine a causa e método de resolução desta mensagem de erro"

# Revisão de design
/screenshot --full
"Avalie este design do ponto de vista de UX"

# Análise de código
/screenshot --crop
"Aponte os problemas deste código"

# Análise de visualização de dados
/screenshot --crop
"Analise as tendências que podem ser lidas deste gráfico"
```

### Exemplos Detalhados

```bash
# Análise de múltiplas perspectivas
/screenshot --window
"Analise esta tela sobre o seguinte:
1. Consistência da UI
2. Problemas de acessibilidade
3. Propostas de melhoria"

# Múltiplas capturas para análise comparativa
/screenshot --window
# (salva imagem do before)
# Faz mudanças
/screenshot --window
# (salva imagem do after)
"Compare as imagens before e after, analise mudanças e efeitos de melhoria"

# Foco em elemento específico
/screenshot --crop
"Avalie se o design do botão selecionado está em harmonia com outros elementos"
```

### Itens Proibidos

- **É proibido dizer "capturei" sem ter capturado screenshot**
- **É proibido tentar analisar arquivos de imagem inexistentes**
- **O comando `/screenshot` não realiza captura real de screenshot**

### Observações

- Quando nenhuma opção é especificada, apresente as seguintes escolhas:

  ```
  "Qual método usar para capturar screenshot?
  1. Selecionar janela (--window) → screencapture -W
  2. Tela inteira (--full) → screencapture -x
  3. Selecionar região (--crop) → screencapture -i"
  ```

- Inicie a análise de imagem após o usuário executar o comando screencapture
- Ao especificar problemas ou pontos de vista específicos, é possível uma análise mais focada
