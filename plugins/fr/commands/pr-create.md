## PR Create

Crée automatiquement des Pull Requests en analysant vos modifications Git pour un flux de travail plus fluide.

### Utilisation

```bash
# Créer automatiquement une PR à partir de vos modifications
git add . && git commit -m "feat: Implement user authentication"
"Create a Draft PR with the right description and labels"

# Conserver votre modèle existant
cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
"Fill in the blanks but keep the template structure intact"

# Marquer comme prêt une fois terminé
gh pr ready
"Switch to Ready for Review after checking quality"
```

### Exemples de base

```bash
# 1. Créer une branche et committer
git checkout main && git pull
git checkout -b feat-user-profile
git add . && git commit -m "feat: Implement user profile feature"
git push -u origin feat-user-profile

# 2. Créer la PR
"Please create a PR:
1. Check what changed with git diff --cached
2. Use the PR template from .github/PULL_REQUEST_TEMPLATE.md
3. Pick up to 3 labels that match the changes
4. Create it as a Draft (keep HTML comments)"

# 3. La marquer comme prête après passage de la CI
"Once CI is green, mark the PR as Ready for Review"
```

### Étapes d'exécution

#### 1. Créer une branche

```bash
# Nomenclature des branches : {type}-{subject}
git checkout main
git pull
git checkout -b feat-user-authentication

# Confirmer que vous êtes sur la bonne branche
git branch --show-current
```

#### 2. Committer

```bash
# Préparer vos modifications
git add .

# Committer avec un message clair
git commit -m "feat: Implement user authentication API"
```

#### 3. Pousser vers le distant

```bash
# Premier push (définit l'upstream)
git push -u origin feat-user-authentication

# Pushs suivants
git push
```

#### 4. Créer un brouillon de PR avec analyse automatique

**Étape 1 : Analyser les modifications**

```bash
# Voir quels fichiers ont changé
git diff --cached --name-only

# Examiner les modifications réelles (premières 1000 lignes)
git diff --cached | head -1000
```

**Étape 2 : Générer automatiquement la description**

```bash
# Priorité des modèles :
# 1. Conserver la description PR existante telle quelle
# 2. Utiliser .github/PULL_REQUEST_TEMPLATE.md
# 3. Se rabattre sur le modèle par défaut

cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
# Remplir seulement les sections vides - ne pas toucher aux commentaires HTML ou séparateurs
```

**Étape 3 : Sélectionner automatiquement les labels**

```bash
# Obtenir les labels disponibles (non interactif)
"Retrieve available labels from .github/labels.yml or GitHub repository and automatically select appropriate labels based on changes"

# Sélection automatique par correspondance de motifs (max 3)
# - Documentation : *.md, docs/ → documentation|docs
# - Tests : test, spec → test|testing
# - Corrections de bugs : fix|bug → bug|fix
# - Nouvelles fonctionnalités : feat|feature → feature|enhancement
```

**Étape 4 : Créer la PR via l'API GitHub (Préserver les commentaires HTML)**

```bash
# Créer la PR
"Create a Draft PR with the following information:
- Title: Auto-generated from commit message
- Description: Properly filled using .github/PULL_REQUEST_TEMPLATE.md
- Labels: Auto-selected from changes (max 3)
- Base branch: main
- Preserve all HTML comments"
```

**Méthode B : GitHub MCP (Solution de secours)**

```javascript
// Créer une PR en préservant les commentaires HTML
mcp_github_create_pull_request({
  owner: "organization",
  repo: "repository",
  base: "main",
  head: "feat-user-authentication",
  title: "feat: Implement user authentication",
  body: prBodyContent, // Contenu complet incluant les commentaires HTML
  draft: true,
  maintainer_can_modify: true,
});
```

### Système de sélection automatique de labels

#### Détermination à partir des motifs de fichiers

- **Documentation** : `*.md`, `README`, `docs/` → `documentation|docs|doc`
- **Tests** : `test`, `spec` → `test|testing`
- **CI/CD** : `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`
- **Dépendances** : `package.json`, `pubspec.yaml` → `dependencies|deps`

#### Détermination à partir du contenu

- **Corrections de bugs** : `fix|bug|error|crash|repair` → `bug|fix`
- **Nouvelles fonctionnalités** : `feat|feature|add|implement|new-feature|implementation` → `feature|enhancement|feat`
- **Refactorisation** : `refactor|clean|restructure` → `refactor|cleanup|clean`
- **Performance** : `performance|perf|optimize` → `performance|perf`
- **Sécurité** : `security|secure` → `security`

#### Contraintes

- **Max 3 labels** : Limite supérieure pour la sélection automatique
- **Labels existants uniquement** : Interdit de créer de nouveaux labels
- **Correspondance partielle** : Déterminée par l'inclusion de mots-clés dans les noms de labels

### Directives du projet

#### Approche de base

1. **Toujours commencer en brouillon** : Toutes les PR doivent être créées à l'état Draft
2. **Amélioration progressive de la qualité** : Phase 1 (Implémentation de base) → Phase 2 (Ajouter des tests) → Phase 3 (Mettre à jour la documentation)
3. **Labels appropriés** : Toujours ajouter jusqu'à 3 labels
4. **Utiliser les modèles** : Toujours utiliser `.github/PULL_REQUEST_TEMPLATE.md`
5. **Espacement japonais** : Toujours ajouter un espace demi-chasse entre le texte japonais et les alphanumériques

#### Convention de nomenclature des branches

```text
{type}-{subject}

Exemples :
- feat-user-profile
- fix-login-error
- refactor-api-client
```

#### Messages de commit

```text
{type}: {description}

Exemples :
- feat: Implement user authentication API
- fix: Correct login error
- docs: Update README
```

### Système de traitement des modèles

#### Priorité de traitement

1. **Description PR existante** : Conserver tout ce qui est déjà écrit
2. **Modèle du projet** : Utiliser `.github/PULL_REQUEST_TEMPLATE.md`
3. **Modèle par défaut** : Utiliser ceci si rien d'autre n'existe

#### Règles de préservation du contenu existant

- **Ne pas toucher au contenu existant** : Laisser ce qui est déjà là tel quel
- **Remplir seulement les blancs** : Ajouter du contenu seulement là où il manque
- **Conserver les commentaires fonctionnels** : Comme `<!-- Copilot review rule -->`
- **Conserver les commentaires HTML** : Tous les `<!-- ... -->` restent tels quels
- **Conserver les séparateurs** : Les éléments comme `---` restent en place

#### Gestion de la préservation des commentaires HTML

**Attention** : GitHub CLI (`gh pr edit`) échappe les commentaires HTML, et le traitement du shell peut créer des problèmes avec des chaînes comme `EOF < /dev/null`.

**Comment corriger ceci** :

1. **Utiliser l'option --field de l'API GitHub** : Ceci gère l'échappement correctement
2. **Rester simple** : Éviter les pipes et redirections complexes
3. **Ne rien supprimer** : Conserver tous les commentaires HTML et modèles intacts

### Réponses aux commentaires de revue

```bash
# Committer vos corrections
git add .
git commit -m "fix: Address review feedback"
git push
```

### Notes

#### Importance de la préservation des commentaires HTML

- **Problème GitHub CLI** : `gh pr edit` échappe les commentaires HTML et peut casser les choses
- **La solution** : Utiliser l'option `--field` de l'API GitHub pour une gestion appropriée
- **Tout conserver** : Ne pas supprimer les commentaires HTML - conserver tout le modèle

#### Contraintes d'automatisation

- **Pas de nouveaux labels** : Ne peut utiliser que les labels de `.github/labels.yml`
- **3 labels max** : C'est la limite pour la sélection automatique
- **Ne pas toucher au contenu manuel** : Ne jamais changer ce que quelqu'un a écrit

#### Qualité étape par étape

- **Commencer avec brouillon** : Chaque PR commence comme brouillon
- **Vérifier la CI** : Exécuter `gh pr checks` pour voir le statut
- **Marquer comme prêt** : Utiliser `gh pr ready` quand la qualité semble bonne
- **Suivre le modèle** : S'en tenir à la structure de votre projet
