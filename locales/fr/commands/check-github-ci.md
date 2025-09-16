## GitHub CI Monitoring

Surveille le statut CI de GitHub Actions et suit jusqu'à l'achèvement.

### Utilisation

```bash
# Vérifier le statut CI
gh pr checks
```

### Exemples de base

```bash
# Vérifier la CI après création de PR
gh pr create --title "Add new feature" --body "Description"
gh pr checks
```

### Collaboration avec Claude

```bash
# Flux de vérification CI à correction
gh pr checks
"Analyze CI check results and suggest fixes if there are failures"

# Revérifier après correction
git push origin feature-branch
gh pr checks
"Check CI results after correction to confirm no issues"
```

### Exemples de résultats d'exécution

```text
Toutes les vérifications ont réussi
0 annulée, 0 échouée, 8 réussies, 3 ignorées et 0 en attente

   NOM                                     DESCRIPTION                DURÉE    URL
○  Build/test (pull_request)                                          5m20s    https://github.com/user/repo/actions/runs/123456789
○  Build/lint (pull_request)                                          2m15s    https://github.com/user/repo/actions/runs/123456789
○  Security/scan (pull_request)                                       1m30s    https://github.com/user/repo/actions/runs/123456789
○  Type Check (pull_request)                                          45s      https://github.com/user/repo/actions/runs/123456789
○  Commit Messages (pull_request)                                     12s      https://github.com/user/repo/actions/runs/123456789
-  Deploy Preview (pull_request)                                               https://github.com/user/repo/actions/runs/123456789
-  Visual Test (pull_request)                                                  https://github.com/user/repo/actions/runs/123456789
```

### Notes

- Vérifier les détails en cas d'échec
- Attendre que toutes les vérifications soient terminées avant fusion
- Relancer `gh pr checks` au besoin
