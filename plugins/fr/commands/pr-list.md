## PR List

Affiche une liste priorisée des PR ouvertes dans le dépôt actuel.

### Utilisation

```bash
# Demande à Claude
"Show a prioritized list of open PRs"
```

### Exemples de base

```bash
# Obtenir les informations du dépôt
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# Obtenir les informations des PR ouvertes et demander à Claude
gh pr list --state open --draft=false --json number,title,author,createdAt,additions,deletions,reviews --limit 30

"Organize the above PRs by priority, including a 2-line summary for each PR. Generate URLs using the repository name obtained above"
```

### Format d'affichage

```text
Liste des PR Ouvertes (par Priorité)

### Haute Priorité
#numéro Titre [Draft/DNM] | Auteur | Temps depuis ouverture | Nombre d'approbations | +ajouts/-suppressions
      ├─ Ligne de résumé 1
      └─ Ligne de résumé 2
      https://github.com/owner/repo/pull/numéro

### Priorité Moyenne
(Format similaire)

### Basse Priorité
(Format similaire)
```

### Critères d'évaluation de priorité

**Haute Priorité**

- `fix:` Corrections de bugs
- `release:` Travail de release

**Priorité Moyenne**

- `feat:` Nouvelles fonctionnalités
- `update:` Améliorations de fonctionnalités
- Autres PR régulières

**Basse Priorité**

- PR contenant DO NOT MERGE
- PR brouillons avec `test:`, `build:`, `perf:`

### Notes

- Nécessite GitHub CLI (`gh`)
- Affiche seulement les PR à l'état ouvert (les brouillons sont exclus)
- Affiche maximum 30 PR
- Le temps écoulé est depuis l'ouverture de la PR
- Les URLs des PR sont générées automatiquement depuis le nom réel du dépôt
