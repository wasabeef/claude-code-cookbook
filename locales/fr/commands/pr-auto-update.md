## PR Auto Update

## Vue d'ensemble

Une commande qui met à jour automatiquement les descriptions et labels de Pull Requests. Analyse les changements Git pour générer et définir des descriptions et labels appropriés.

## Utilisation

```bash
/pr-auto-update [options] [numéro PR]
```

### Options

- `--pr <number>` : Spécifier le numéro de PR cible (détecté automatiquement depuis la branche courante si omis)
- `--description-only` : Mettre à jour seulement la description (conserver les labels inchangés)
- `--labels-only` : Mettre à jour seulement les labels (conserver la description inchangée)
- `--dry-run` : Afficher le contenu généré sans faire de mises à jour réelles
- `--lang <language>` : Spécifier la langue (fr, en)

### Exemples de base

```bash
# Mise à jour automatique de la PR pour la branche courante
/pr-auto-update

# Mettre à jour une PR spécifique
/pr-auto-update --pr 1234

# Mettre à jour seulement la description
/pr-auto-update --description-only

# Vérifier avec dry-run
/pr-auto-update --dry-run
```

## Détails des fonctionnalités

### 1. Détection automatique de PR

Détecte automatiquement la PR correspondante depuis la branche courante :

```bash
# Rechercher la PR depuis la branche
gh pr list --head $(git branch --show-current) --json number,title,url
```

### 2. Analyse des changements

Collecte et analyse les informations suivantes :

- **Changements de fichiers** : Fichiers ajoutés, supprimés ou modifiés
- **Analyse de code** : Changements dans les imports, définitions de fonctions, définitions de classes
- **Tests** : Présence et contenu des fichiers de test
- **Documentation** : Mises à jour de README, docs
- **Configuration** : Changements de package.json, pubspec.yaml, fichiers de configuration
- **CI/CD** : Changements dans GitHub Actions, workflows

### 3. Génération automatique de description

#### Priorité de traitement des modèles

1. **Description PR existante** : Suit complètement le contenu déjà écrit
2. **Modèle de projet** : Obtient la structure depuis `.github/PULL_REQUEST_TEMPLATE.md`
3. **Modèle par défaut** : Solution de repli quand les précédents n'existent pas

#### Règles de préservation du contenu existant

**Important** : Ne pas modifier le contenu existant

- Conserver les sections existantes
- Compléter seulement les sections vides
- Conserver les commentaires fonctionnels (comme les règles de revue Copilot)

#### Utilisation des modèles de projet

```bash
# Analyser la structure de .github/PULL_REQUEST_TEMPLATE.md
parse_template_structure() {
  local template_file="$1"
  
  if [ -f "$template_file" ]; then
    # Extraire la structure de section
    grep -E '^##|^###' "$template_file"
    
    # Identifier les espaces réservés de commentaires
    grep -E '<!--.*-->' "$template_file"
    
    # Suivre complètement la structure du modèle existant
    cat "$template_file"
  fi
}
```

### 4. Définition automatique de labels

#### Mécanisme de récupération de labels

**Priorité** :

1. **`.github/labels.yml`** : Obtenir depuis les définitions de labels spécifiques au projet
2. **API GitHub** : Obtenir les labels existants avec `gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'`

#### Règles de détermination automatique

**Basé sur les motifs de fichiers** :

- Documentation : `*.md`, `README`, `docs/` → labels contenant `documentation|docs|doc`
- Tests : `test`, `spec` → labels contenant `test|testing`
- CI/CD : `.github/`, `*.yml`, `Dockerfile` → labels contenant `ci|build|infra|ops`
- Dépendances : `package.json`, `pubspec.yaml`, `requirements.txt` → labels contenant `dependencies|deps`

**Basé sur le contenu des changements** :

- Corrections de bugs : `fix|bug|error|crash|correction` → labels contenant `bug|fix`
- Nouvelles fonctionnalités : `feat|feature|add|implement|new-feature|implementation` → labels contenant `feature|enhancement|feat`
- Refactorisation : `refactor|clean|restructure` → labels contenant `refactor|cleanup|clean`
- Performance : `performance|perf|optimize|optimization` → labels contenant `performance|perf`
- Sécurité : `security|secure|vulnerability` → labels contenant `security`

#### Contraintes

- **Maximum 3** : Limite supérieure des labels sélectionnés automatiquement
- **Labels existants uniquement** : Création de nouveaux labels interdite
- **Correspondance partielle** : Déterminé par la présence de mots-clés dans les noms de labels

#### Exemples d'utilisation réelle

**Quand `.github/labels.yml` existe** :

```bash
# Récupération automatique depuis les définitions de labels
grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"

# Exemple : Utiliser le système de labels spécifique au projet
```

**Lors de récupération depuis l'API GitHub** :

```bash
# Obtenir la liste des labels existants
gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'

# Exemple : Utiliser des labels standards comme bug, enhancement, documentation
```

### 5. Flux d'exécution

```bash
#!/bin/bash

# 1. Détection et récupération de PR
detect_pr() {
  if [ -n "$PR_NUMBER" ]; then
    echo $PR_NUMBER
  else
    gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
  fi
}

# 2. Analyse des changements
analyze_changes() {
  local pr_number=$1
  
  # Obtenir les changements de fichiers
  gh pr diff $pr_number --name-only
  
  # Analyse du contenu
  gh pr diff $pr_number | head -1000
}

# 3. Génération de description
generate_description() {
  local pr_number=$1
  local changes=$2
  
  # Obtenir la description PR actuelle
  local current_body=$(gh pr view $pr_number --json body --jq -r .body)
  
  # Utiliser le contenu existant si disponible
  if [ -n "$current_body" ]; then
    echo "$current_body"
  else
    # Générer nouveau depuis le modèle
    local template_file=".github/PULL_REQUEST_TEMPLATE.md"
    if [ -f "$template_file" ]; then
      generate_from_template "$(cat "$template_file")" "$changes"
    else
      generate_from_template "" "$changes"
    fi
  fi
}

# Générer depuis le modèle
generate_from_template() {
  local template="$1"
  local changes="$2"
  
  if [ -n "$template" ]; then
    # Utiliser le modèle tel quel (préserver les commentaires HTML)
    echo "$template"
  else
    # Générer en format par défaut
    echo "## What does this change?"
    echo ""
    echo "$changes"
  fi
}

# 4. Détermination des labels
determine_labels() {
  local changes=$1
  local file_list=$2
  local pr_number=$3
  
  # Obtenir les labels disponibles
  local available_labels=()
  if [ -f ".github/labels.yml" ]; then
    # Extraire les noms de labels depuis labels.yml
    available_labels=($(grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"))
  else
    # Obtenir les labels depuis l'API GitHub
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    available_labels=($(gh api "repos/$owner/$repo/labels" --jq '.[].name'))
  fi
  
  local suggested_labels=()
  
  # Correspondance de motifs générique
  analyze_change_patterns "$file_list" "$changes" available_labels suggested_labels
  
  # Limiter à maximum 3
  echo "${suggested_labels[@]:0:3}"
}

# Déterminer les labels depuis les motifs de changements
analyze_change_patterns() {
  local file_list="$1"
  local changes="$2"
  local -n available_ref=$3
  local -n suggested_ref=$4
  
  # Détermination du type de fichier
  if echo "$file_list" | grep -q "\.md$\|README\|docs/"; then
    add_matching_label "documentation\|docs\|doc" available_ref suggested_ref
  fi
  
  if echo "$file_list" | grep -q "test\|spec"; then
    add_matching_label "test\|testing" available_ref suggested_ref
  fi
  
  # Détermination du contenu des changements
  if echo "$changes" | grep -iq "fix\|bug\|error\|crash\|correction"; then
    add_matching_label "bug\|fix" available_ref suggested_ref
  fi
  
  if echo "$changes" | grep -iq "feat\|feature\|add\|implement\|new-feature\|implementation"; then
    add_matching_label "feature\|enhancement\|feat" available_ref suggested_ref
  fi
}

# Ajouter un label correspondant
add_matching_label() {
  local pattern="$1"
  local -n available_ref=$2
  local -n suggested_ref=$3
  
  # Ignorer si on a déjà 3 labels
  if [ ${#suggested_ref[@]} -ge 3 ]; then
    return
  fi
  
  # Ajouter le premier label correspondant au motif
  for available_label in "${available_ref[@]}"; do
    if echo "$available_label" | grep -iq "$pattern"; then
      # Vérifier les doublons
      local already_exists=false
      for existing in "${suggested_ref[@]}"; do
        if [ "$existing" = "$available_label" ]; then
          already_exists=true
          break
        fi
      done
      
      if [ "$already_exists" = false ]; then
        suggested_ref+=("$available_label")
        return
      fi
    fi
  done
}

# Conserver l'ancienne fonction pour compatibilité
find_and_add_label() {
  add_matching_label "$@"
}

# 5. Mise à jour PR
update_pr() {
  local pr_number=$1
  local description="$2"
  local labels="$3"
  
  if [ "$DRY_RUN" = "true" ]; then
    echo "=== DRY RUN ==="
    echo "Description:"
    echo "$description"
    echo "Labels: $labels"
  else
    # Obtenir les informations du dépôt
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    
    # Mettre à jour le corps en utilisant l'API GitHub (préserver les commentaires HTML)
    # Gérer l'échappement JSON correctement
    local escaped_body=$(echo "$description" | jq -R -s .)
    gh api \
      --method PATCH \
      "/repos/$owner/$repo/pulls/$pr_number" \
      --field body="$description"
    
    # Les labels peuvent être gérés avec la commande gh normale
    if [ -n "$labels" ]; then
      gh pr edit $pr_number --add-label "$labels"
    fi
  fi
}
```

## Fichier de configuration (Extension future)

`~/.claude/pr-auto-update.config` :

```json
{
  "language": "fr",
  "max_labels": 3
}
```

## Motifs communs

### Projets Flutter

```markdown
## What does this change?

Implémenté {nom de fonctionnalité}. Résout le {problème} utilisateur.

### Changements principaux

- **Implémentation UI** : Créé nouvel {nom d'écran}
- **Gestion d'état** : Ajouté providers Riverpod
- **Intégration API** : Implémenté requêtes et mutations GraphQL
- **Tests** : Ajouté tests de widgets et tests unitaires

### Spécifications techniques

- **Architecture** : {motif utilisé}
- **Dépendances** : {packages nouvellement ajoutés}
- **Performance** : {détails d'optimisation}
```

### Projets Node.js

```markdown
## What does this change?

Implémenté endpoint {nom API}. Supporte {cas d'usage}.

### Changements principaux

- **Implémentation API** : Créé nouvel {endpoint}
- **Validation** : Ajouté logique de validation des requêtes
- **Base de données** : Implémenté opérations pour {nom de table}
- **Tests** : Ajouté tests d'intégration et unitaires

### Sécurité

- **Authentification** : Validation de token JWT
- **Autorisation** : Contrôle d'accès basé sur les rôles
- **Validation d'entrée** : Protection contre injection SQL
```

### Améliorations CI/CD

```markdown
## What does this change?

Amélioré le workflow GitHub Actions. Obtient {effet}.

### Améliorations

- **Performance** : Réduit le temps de construction de {temps}
- **Fiabilité** : Amélioré la gestion d'erreurs
- **Sécurité** : Amélioré la gestion des secrets

### Détails techniques

- **Parallélisation** : Exécuter {nom de job} en parallèle
- **Mise en cache** : Optimisé la stratégie de cache pour {cible de cache}
- **Surveillance** : Ajouté surveillance pour {métriques}
```

## Notes importantes

1. **Préservation complète du contenu existant** :
   - Ne pas changer même un seul caractère du contenu déjà écrit
   - Compléter seulement les sections de commentaires vides et espaces réservés
   - Respecter le contenu intentionnellement écrit par les utilisateurs

2. **Priorité des modèles** :
   - Description PR existante > `.github/PULL_REQUEST_TEMPLATE.md` > Par défaut
   - Suivre complètement la structure du modèle spécifique au projet

3. **Contraintes de labels** :
   - Utiliser `.github/labels.yml` de préférence s'il existe
   - Obtenir les labels existants depuis l'API GitHub s'il n'existe pas
   - Création de nouveaux labels interdite
   - Maximum 3 labels sélectionnés automatiquement

4. **Mises à jour sûres** :
   - Recommander pré-confirmation avec `--dry-run`
   - Afficher un avertissement pour les changements contenant des informations sensibles
   - Sauvegarder la description originale comme sauvegarde

5. **Maintien de cohérence** :
   - Correspondre au style PR existant du projet
   - Maintenir la cohérence linguistique (français/anglais)
   - Hériter des conventions de labellisation

## Dépannage

### Problèmes courants

1. **PR non trouvée** : Vérifier le nom de branche et l'association PR
2. **Erreur de permission** : Vérifier le statut d'authentification GitHub CLI
3. **Impossible de définir les labels** : Vérifier les permissions du dépôt
4. **Les commentaires HTML sont échappés** : Spécification GitHub CLI convertit `<!-- -->` en `&lt;!-- --&gt;`

### Problème d'échappement des commentaires HTML de GitHub CLI

**Important** : GitHub CLI (`gh pr edit`) échappe automatiquement les commentaires HTML. De plus, le traitement de redirection du shell peut introduire des chaînes invalides comme `EOF < /dev/null`.

#### Solutions fondamentales

1. **Utiliser l'option --field de l'API GitHub** : Utiliser `--field` pour un traitement d'échappement approprié
2. **Simplifier le traitement shell** : Éviter les redirections complexes et le traitement de pipe
3. **Simplifier le traitement de modèle** : Éliminer le traitement de suppression de commentaires HTML et préserver complètement
4. **Échappement JSON approprié** : Gérer correctement les caractères spéciaux

### Options de débogage

```bash
# Sortie de journal détaillée (à ajouter lors de l'implémentation)
/pr-auto-update --verbose
```
