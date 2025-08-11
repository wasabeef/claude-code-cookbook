## Monitoreo de CI de GitHub

Monitorea el estado de GitHub Actions CI y rastrea hasta completarse.

### Uso

```bash
# Verificar estado de CI
gh pr checks
```

### Ejemplos Básicos

```bash
# Verificar CI después de crear PR
gh pr create --title "Add new feature" --body "Description"
gh pr checks
```

### Colaboración con Claude

```bash
# Flujo desde verificación CI hasta corrección
gh pr checks
"Analizar resultados de verificaciones CI y sugerir correcciones si hay fallas"

# Volver a verificar después de corrección
git push origin feature-branch
gh pr checks
"Verificar resultados CI después de corrección para confirmar que no hay problemas"
```

### Ejemplo de Resultados de Ejecución

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

### Notas

- Verificar detalles cuando falle
- Esperar a que todas las verificaciones se completen antes de hacer merge
- Volver a ejecutar `gh pr checks` según sea necesario
