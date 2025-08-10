## Monitoramento de CI do GitHub

Monitora o status do CI do GitHub Actions e acompanha até a conclusão.

### Uso

```bash
# Verificar status dos checks do CI
gh pr checks
```

### Exemplo Básico

```bash
# Verificação do CI após criação de PR
gh pr create --title "Adição de nova funcionalidade" --body "descrição"
gh pr checks
```

### Integração com Claude

```bash
# Fluxo desde verificação do CI até correção
gh pr checks
"Analise os resultados dos checks do CI e proponha métodos de correção se houver itens com falha"

# Reverificação após correção
git push origin feature-branch
gh pr checks
"Verifique os resultados do CI após correção e confirme que não há problemas"
```

### Exemplo de Resultado de Execução

```
All checks were successful
0 cancelled, 0 failing, 8 successful, 3 skipped, and 0 pending checks

   NAME                                    DESCRIPTION                ELAPSED  URL
○  Build/test (pull_request)                                          5m20s    https://github.com/user/repo/actions/runs/123456789
○  Build/lint (pull_request)                                          2m15s    https://github.com/user/repo/actions/runs/123456789
○  Security/scan (pull_request)                                       1m30s    https://github.com/user/repo/actions/runs/123456789
○  Type Check (pull_request)                                          45s      https://github.com/user/repo/actions/runs/123456789
○  Commit Messages (pull_request)                                     12s      https://github.com/user/repo/actions/runs/123456789
-  Deploy Preview (pull_request)                                               https://github.com/user/repo/actions/runs/123456789
-  Visual Test (pull_request)                                                  https://github.com/user/repo/actions/runs/123456789
```

### Observações

- Em caso de falha, verificar detalhes
- Aguardar conclusão de todos os checks antes do merge
- Reexecutar `gh pr checks` conforme necessário
