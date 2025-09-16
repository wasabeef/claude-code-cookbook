## Issue List

Affiche une liste priorisée des issues ouvertes dans le dépôt actuel.

### Utilisation

```bash
# Demande à Claude
"Show a prioritized list of open issues"
```

### Exemples de base

```bash
# Obtenir les informations du dépôt
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# Obtenir les informations des issues ouvertes et demander à Claude
gh issue list --state open --json number,title,author,createdAt,updatedAt,labels,assignees,comments --limit 30

"Organize the above issues by priority, including a 2-line summary for each issue. Generate URLs using the repository name obtained above"
```

### Format d'affichage

```text
Liste des Issues Ouvertes (par Priorité)

### Haute Priorité
#numéro Titre [labels] | Auteur | Temps depuis ouverture | Nombre de commentaires | Assigné
      ├─ Ligne de résumé 1
      └─ Ligne de résumé 2
      https://github.com/owner/repo/issues/numéro

### Priorité Moyenne
(Format similaire)

### Basse Priorité
(Format similaire)
```

### Critères d'évaluation de priorité

**Haute Priorité**

- Issues avec label `bug`
- Issues avec labels `critical` ou `urgent`
- Issues avec label `security`

**Priorité Moyenne**

- Issues avec label `enhancement`
- Issues avec label `feature`
- Issues avec assignés

**Basse Priorité**

- Issues avec label `documentation`
- Issues avec label `good first issue`
- Issues avec labels `wontfix` ou `duplicate`

### Filtrage par labels

```bash
# Obtenir seulement les issues avec un label spécifique
gh issue list --state open --label "bug" --json number,title,author,createdAt,labels,comments --limit 30

# Filtrer avec plusieurs labels (condition AND)
gh issue list --state open --label "bug,high-priority" --json number,title,author,createdAt,labels,comments --limit 30
```

### Notes

- Nécessite GitHub CLI (`gh`)
- Affiche seulement les issues à l'état ouvert
- Affiche maximum 30 issues
- Le temps écoulé est depuis l'ouverture de l'issue
- Les URLs des issues sont générées automatiquement depuis le nom réel du dépôt
