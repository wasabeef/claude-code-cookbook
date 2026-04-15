---
description: "Diviser les changements en unités sémantiques et commiter. Se déclenche avec « commit », « diviser et commiter »."
allowed-tools:
  - Bash(git *)
---

# Diviser les changements en unités sémantiques et commiter

Divise les gros changements en petits commits significatifs avec des messages appropriés. Utilise uniquement des commandes git standard.

## Utilisation

```bash
/semantic-commit [options]
```

## Options

- `--dry-run` : Afficher les divisions de commits proposées sans réellement committer
- `--lang <langue>` : Forcer la langue pour les messages de commit (en, fr)
- `--max-commits <nombre>` : Spécifier le nombre maximum de commits (défaut : 10)

## Exemples de base

```bash
# Analyser les changements actuels et committer en unités logiques
/semantic-commit

# Vérifier uniquement la proposition de division (pas de commit réel)
/semantic-commit --dry-run

# Générer les messages de commit en anglais
/semantic-commit --lang en

# Générer les messages de commit en français
/semantic-commit --lang fr

# Diviser en maximum 5 commits
/semantic-commit --max-commits 5
```

## Comment ça fonctionne

1. **Analyser les changements** : Vérifier ce qui a changé avec `git diff HEAD`
2. **Grouper les fichiers** : Assembler les fichiers liés
3. **Créer les messages** : Écrire des messages de commit sémantiques pour chaque groupe
4. **Committer étape par étape** : Committer chaque groupe après votre approbation

## Quand diviser les changements

### Ce qui rend un changement "important"

Nous divisons quand nous voyons :

1. **Nombreux fichiers** : 5+ fichiers modifiés
2. **Nombreuses lignes** : 100+ lignes modifiées
3. **Multiples fonctionnalités** : Changements dans 2+ zones
4. **Types mixtes** : feat + fix + docs ensemble

```bash
# Analyser l'échelle du changement
CHANGED_FILES=$(git diff HEAD --name-only | wc -l)
CHANGED_LINES=$(git diff HEAD --stat | tail -1 | grep -o '[0-9]\+ insertions\|[0-9]\+ deletions' | awk '{sum+=$1} END {print sum}')

if [ $CHANGED_FILES -ge 5 ] || [ $CHANGED_LINES -ge 100 ]; then
  echo "Changement important détecté : division recommandée"
fi
```

### Comment diviser en petits commits significatifs

#### 1. Division par limites fonctionnelles

```bash
# Identifier les unités fonctionnelles à partir de la structure des répertoires
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq
# → src/auth, src/api, components/ui, etc.
```

#### 2. Séparation par type de changement

```bash
# Nouveaux fichiers vs modifications de fichiers existants
git diff HEAD --name-status | grep '^A' # Nouveaux fichiers
git diff HEAD --name-status | grep '^M' # Fichiers modifiés
git diff HEAD --name-status | grep '^D' # Fichiers supprimés
```

#### 3. Analyse des dépendances

```bash
# Détecter les changements de relations d'import
git diff HEAD | grep -E '^[+-].*import|^[+-].*require' | \
cut -d' ' -f2- | sort | uniq
```

### Analyse détaillée des fichiers

```bash
# Obtenir la liste des fichiers modifiés
git diff HEAD --name-only

# Analyser les changements de chaque fichier individuellement
git diff HEAD -- <fichier>

# Déterminer le type de changement pour les fichiers
git diff HEAD --name-status | while read status file; do
  case $status in
    A) echo "$file: Nouvelle création" ;;
    M) echo "$file: Modification" ;;
    D) echo "$file: Suppression" ;;
    R*) echo "$file: Renommé" ;;
  esac
done
```

### Comment grouper les fichiers

1. **Par fonctionnalité** : Garder les fonctions liées ensemble
   - Fichiers `src/auth/` → Authentification
   - Fichiers `components/` → Composants UI

2. **Par type** : Même type de changements
   - Tests uniquement → `test:`
   - Documentation uniquement → `docs:`
   - Configuration uniquement → `chore:`

3. **Par dépendances** : Fichiers qui ont besoin les uns des autres
   - Modèle + Migration
   - Composant + Style

4. **Par taille** : Garder les commits gérables
   - Max 10 fichiers par commit
   - Garder les fichiers liés ensemble

## Exemple de sortie

```bash
$ /semantic-commit

Analyse des changements...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Changements détectés :
• src/auth/login.ts (modifié)
• src/auth/register.ts (nouveau)
• src/auth/types.ts (modifié)
• tests/auth.test.ts (nouveau)
• docs/authentication.md (nouveau)

Divisions de commits proposées :

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 1/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Message : feat: implémenter système d'enregistrement et connexion utilisateur
Fichiers inclus :
  • src/auth/login.ts
  • src/auth/register.ts
  • src/auth/types.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 2/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Message : test: ajouter tests complets pour système d'authentification
Fichiers inclus :
  • tests/auth.test.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 3/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Message : docs: ajouter documentation du système d'authentification
Fichiers inclus :
  • docs/authentication.md

Exécuter le commit avec ce plan de division ? (y/n/edit):
```

## Vos options

- `y` : Procéder avec la division proposée
- `n` : Tout annuler
- `edit` : Changer les messages de commit
- `merge <numéro1> <numéro2>` : Combiner les commits
- `split <numéro>` : Diviser davantage un commit

## Mode Dry Run

```bash
$ /semantic-commit --dry-run

Analyse des changements... (DRY RUN)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Affichage de la proposition de division de commit]

ℹ️  Mode DRY RUN : Aucun commit réel ne sera exécuté
💡 Pour exécuter, relancez sans l'option --dry-run
```

## Fonctionnalités intelligentes

### 1. Comprend votre projet

- Détecte le type de projet à partir des fichiers de configuration
- Détermine les fonctionnalités à partir de la structure des dossiers

### 2. Reconnaissance de patterns de changement

```bash
# Détecter les patterns de correction de bugs
- Mots-clés comme "fix", "bug", "error"
- Ajout de gestion d'exceptions
- Corrections de branches de conditions

# Détecter les patterns de nouvelles fonctionnalités
- Création de nouveaux fichiers
- Ajouts de nouvelles méthodes
- Ajouts de points de terminaison API
```

### 3. Analyse des dépendances

- Changements dans les déclarations d'import
- Ajout/modification de définitions de types
- Relation avec les fichiers de configuration

## Comment c'est construit

### Commits étape par étape avec Git

#### 1. Préprocessing : Sauvegarder l'état actuel

```bash
# Réinitialiser les changements non stagés s'il y en a
git reset HEAD
git status --porcelain > /tmp/original_state.txt

# Vérifier la branche de travail
CURRENT_BRANCH=$(git branch --show-current)
echo "Branche de travail : $CURRENT_BRANCH"
```

#### 2. Exécution séquentielle de commits par groupe

```bash
# Lire le plan de division
while IFS= read -r commit_plan; do
  group_num=$(echo "$commit_plan" | cut -d':' -f1)
  files=$(echo "$commit_plan" | cut -d':' -f2- | tr ' ' '\n')

  echo "=== Exécution du commit $group_num ==="

  # Stager uniquement les fichiers pertinents
  echo "$files" | while read file; do
    if [ -f "$file" ]; then
      git add "$file"
      echo "Stagé : $file"
    fi
  done

  # Vérifier le statut de staging
  staged_files=$(git diff --staged --name-only)
  if [ -z "$staged_files" ]; then
    echo "Attention : Aucun fichier stagé"
    continue
  fi

  # Générer le message de commit (analyse LLM)
  commit_msg=$(generate_commit_message_for_staged_files)

  # Confirmation utilisateur
  echo "Message de commit proposé : $commit_msg"
  echo "Fichiers stagés :"
  echo "$staged_files"
  read -p "Exécuter ce commit ? (y/n) : " confirm

  if [ "$confirm" = "y" ]; then
    # Exécuter le commit
    git commit -m "$commit_msg"
    echo "✅ Commit $group_num terminé"
  else
    # Annuler le staging
    git reset HEAD
    echo "❌ Commit $group_num ignoré"
  fi

done < /tmp/commit_plan.txt
```

#### 3. Gestion d'erreurs et rollback

```bash
# Gérer les échecs de hooks pre-commit
commit_with_retry() {
  local commit_msg="$1"
  local max_retries=2
  local retry_count=0

  while [ $retry_count -lt $max_retries ]; do
    if git commit -m "$commit_msg"; then
      echo "✅ Commit réussi"
      return 0
    else
      echo "❌ Échec du commit (tentative $((retry_count + 1))/$max_retries)"

      # Incorporer les corrections automatiques des hooks pre-commit
      if git diff --staged --quiet; then
        echo "Changements automatiquement corrigés par le hook pre-commit"
        git add -u
      fi

      retry_count=$((retry_count + 1))
    fi
  done

  echo "❌ Échec du commit. Veuillez vérifier manuellement."
  return 1
}

# Récupérer des interruptions
resume_from_failure() {
  echo "Processus de commit interrompu détecté"
  echo "Statut de staging actuel :"
  git status --porcelain

  read -p "Continuer le traitement ? (y/n) : " resume
  if [ "$resume" = "y" ]; then
    # Reprendre depuis le dernier commit
    last_commit=$(git log --oneline -1 --pretty=format:"%s")
    echo "Dernier commit : $last_commit"
  else
    # Réinitialisation complète
    git reset HEAD
    echo "Processus réinitialisé"
  fi
}
```

#### 4. Vérification post-complétion

```bash
# Vérifier que tous les changements ont été committés
remaining_changes=$(git status --porcelain | wc -l)
if [ $remaining_changes -eq 0 ]; then
  echo "✅ Tous les changements committés"
else
  echo "⚠️  Changements non committés restants :"
  git status --short
fi

# Afficher l'historique des commits
echo "Commits créés :"
git log --oneline -n 10 --graph
```

#### 5. Supprimer le push automatique

```bash
# Note : Pas de push automatique
echo "📝 Note : Push automatique non effectué"
echo "Si nécessaire, pushez avec la commande suivante :"
echo "  git push origin $CURRENT_BRANCH"
```

### Détails de l'algorithme de division

#### Étape 1 : Analyse initiale

```bash
# Obtenir et classifier tous les fichiers modifiés
git diff HEAD --name-status | while read status file; do
  echo "$status:$file"
done > /tmp/changes.txt

# Statistiques des changements par répertoire fonctionnel
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq -c
```

#### Étape 2 : Groupement initial par limites fonctionnelles

```bash
# Groupement basé sur les répertoires
GROUPS=$(git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq)
for group in $GROUPS; do
  echo "=== Groupe : $group ==="
  git diff HEAD --name-only | grep "^$group" | head -10
done
```

#### Étape 3 : Analyser la similarité des changements

```bash
# Analyser le type de changement pour chaque fichier
git diff HEAD --name-only | while read file; do
  # Détecter les ajouts de nouvelles fonctions/classes
  NEW_FUNCTIONS=$(git diff HEAD -- "$file" | grep -c '^+.*function\|^+.*class\|^+.*def ')

  # Détecter les patterns de correction de bugs
  BUG_FIXES=$(git diff HEAD -- "$file" | grep -c '^+.*fix\|^+.*bug\|^-.*error')

  # Déterminer si c'est un fichier de test
  if [[ "$file" =~ test|spec ]]; then
    echo "$file: TEST"
  elif [ $NEW_FUNCTIONS -gt 0 ]; then
    echo "$file: FEAT"
  elif [ $BUG_FIXES -gt 0 ]; then
    echo "$file: FIX"
  else
    echo "$file: REFACTOR"
  fi
done
```

#### Étape 4 : Ajustements basés sur les dépendances

```bash
# Analyser les relations d'import
git diff HEAD | grep -E '^[+-].*import|^[+-].*from.*import' | \
while read line; do
  echo "$line" | sed 's/^[+-]//' | awk '{print $2}'
done | sort | uniq > /tmp/imports.txt

# Grouper les fichiers liés
git diff HEAD --name-only | while read file; do
  basename=$(basename "$file" .js .ts .py)
  related=$(git diff HEAD --name-only | grep "$basename" | grep -v "^$file$")
  if [ -n "$related" ]; then
    echo "Fichiers liés : $file <-> $related"
  fi
done
```

#### Étape 5 : Optimisation de la taille des commits

```bash
# Ajuster la taille des groupes
MAX_FILES_PER_COMMIT=8
current_group=1
file_count=0

git diff HEAD --name-only | while read file; do
  if [ $file_count -ge $MAX_FILES_PER_COMMIT ]; then
    current_group=$((current_group + 1))
    file_count=0
  fi
  echo "Commit $current_group: $file"
  file_count=$((file_count + 1))
done
```

#### Étape 6 : Déterminer les groupes finaux

```bash
# Vérifier les résultats de division
for group in $(seq 1 $current_group); do
  files=$(grep "Commit $group:" /tmp/commit_plan.txt | cut -d':' -f2-)
  lines=$(echo "$files" | xargs git diff HEAD -- | wc -l)
  echo "Commit $group: $(echo "$files" | wc -w) fichiers, $lines lignes modifiées"
done
```

## Conformité Conventional Commits

### Format de base

```text
<type>[scope optionnel]: <description>

[corps optionnel]

[pied(s) optionnel(s)]
```

### Types standard

**Types requis** :

- `feat` : Nouvelle fonctionnalité (ajout de fonctionnalité visible par l'utilisateur)
- `fix` : Correction de bug

**Types optionnels** :

- `build` : Changements au système de build ou aux dépendances externes
- `chore` : Autres changements (sans impact sur la release)
- `ci` : Changements aux fichiers de configuration CI ou aux scripts
- `docs` : Changements de documentation uniquement
- `style` : Changements qui n'affectent pas la signification du code (espaces, formatage, points-virgules, etc.)
- `refactor` : Changements de code sans corrections de bugs ou ajouts de fonctionnalités
- `perf` : Améliorations de performance
- `test` : Ajout ou modification de tests

### Scope (Optionnel)

Indique la zone affectée par le changement :

```text
feat(api): add user authentication endpoint
fix(ui): resolve button alignment issue
docs(readme): update installation instructions
```

### Breaking Change

Quand il y a des changements d'API breaking :

```text
feat!: change user API response format

```

ou

```text
feat(api)!: change authentication flow
```

### Détection automatique des conventions de projet

**Important** : Si des conventions spécifiques au projet existent, elles prennent la priorité.

#### 1. Vérifier la configuration CommitLint

Détection automatique de la configuration à partir des fichiers suivants :

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- Section `commitlint` dans `package.json`

```bash
# Vérifier les fichiers de configuration exemple
cat commitlint.config.mjs
cat .commitlintrc.json
grep -A 10 '"commitlint"' package.json
```

#### 2. Détecter les types personnalisés

Exemple de types spécifiques au projet :

```javascript
// commitlint.config.mjs
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // Travail en cours
        "hotfix", // Correction d'urgence
        "release", // Release
        "deps", // Mise à jour de dépendance
        "config", // Changement de configuration
      ],
    ],
  },
};
```

#### 3. Détecter les paramètres de langue

```javascript
// Quand le projet utilise des messages en français
export default {
  rules: {
    "subject-case": [0], // Désactiver pour le support français (accents)
    "subject-max-length": [2, "always", 72], // Ajuster la limite de caractères pour le français
  },
};
```

### Flux d'analyse automatique

1. **Recherche de fichiers de configuration**

   ```bash
   find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
   ```

2. **Analyse des commits existants**

   ```bash
   git log --oneline -50 --pretty=format:"%s"
   ```

3. **Statistiques d'usage des types**

   ```bash
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

### Exemples de conventions de projet

#### Style Angular

```text
feat(scope): add new feature
fix(scope): fix bug
docs(scope): update documentation
```

#### Style combiné Gitmoji

```text
✨ feat: add user registration
🐛 fix: resolve login issue
📚 docs: update API docs
```

#### Projets français

```text
feat: ajout de la fonctionnalité d'inscription utilisateur
fix: correction du bug du processus de connexion
docs: mise à jour de la documentation API
```

## Détection de langue

Comment nous déterminons votre langue :

1. **Option explicite** avec `--lang`

   ```bash
   # Forcer en français
   /semantic-commit --lang fr

   # Forcer en anglais
   /semantic-commit --lang en
   ```

2. **Analyse du git log** pour la détermination automatique

   ```bash
   # Analyser la langue des 20 derniers commits
   git log --oneline -20 --pretty=format:"%s" | \
   grep -E '^[\x{00C0}-\x{017F}]' | wc -l
   # Mode français si détection de caractères accentués
   ```

3. **Fichiers de projet** paramètres de langue

   ```bash
   # Vérifier la langue du README.md
   head -10 README.md | grep -E '^[\x{00C0}-\x{017F}]' | wc -l

   # Vérifier la description de package.json
   grep -E '"description".*[\x{00C0}-\x{017F}]' package.json
   ```

4. **Analyse des commentaires et chaînes** dans les fichiers modifiés

   ```bash
   # Vérifier la langue des commentaires dans les fichiers modifiés
   git diff HEAD | grep -E '^[+-].*//.*[\x{3040}-\x{30ff}]|[\x{4e00}-\x{9fff}]' | wc -l
   ```

### Algorithme de détermination

```bash
# Calcul du score de langue française
FRENCH_SCORE=0

# 1. Configurations CommitLint (+3 points)
if grep -q '"subject-case".*\[0\]' commitlint.config.* 2>/dev/null; then
  FRENCH_SCORE=$((FRENCH_SCORE + 3))
fi

# 2. Analyse de git log (max +2 points)
FRENCH_COMMITS=$(git log --oneline -20 --pretty=format:"%s" | \
  grep -cE '[àâäçéèêëïîôùûüÿæœÀÂÄÇÉÈÊËÏÎÔÙÛÜŸÆŒ]' 2>/dev/null || echo 0)
if [ $FRENCH_COMMITS -gt 10 ]; then
  FRENCH_SCORE=$((FRENCH_SCORE + 2))
elif [ $FRENCH_COMMITS -gt 5 ]; then
  FRENCH_SCORE=$((FRENCH_SCORE + 1))
fi

# 3. Vérification README.md (+1 point)
if head -5 README.md 2>/dev/null | grep -qE '[àâäçéèêëïîôùûüÿæœÀÂÄÇÉÈÊËÏÎÔÙÛÜŸÆŒ]'; then
  FRENCH_SCORE=$((FRENCH_SCORE + 1))
fi

# 4. Vérification du contenu des fichiers modifiés (+1 point)
if git diff HEAD 2>/dev/null | grep -qE '^[+-].*[àâäçéèêëïîôùûüÿæœÀÂÄÇÉÈÊËÏÎÔÙÛÜŸÆŒ]'; then
  FRENCH_SCORE=$((FRENCH_SCORE + 1))
fi

# Déterminer : mode français si score >= 3
if [ $FRENCH_SCORE -ge 3 ]; then
  LANGUAGE="fr"
else
  LANGUAGE="en"
fi
```

## Chargement automatique de configuration

### Ce qui se passe à l'exécution

Nous vérifions les fichiers de configuration dans cet ordre :

1. **Rechercher les fichiers de configuration CommitLint**

   ```bash
   # Rechercher dans cet ordre, utiliser le premier fichier trouvé
   commitlint.config.mjs
   commitlint.config.js
   commitlint.config.cjs
   commitlint.config.ts
   .commitlintrc.js
   .commitlintrc.json
   .commitlintrc.yml
   .commitlintrc.yaml
   package.json (section commitlint)
   ```

2. **Parser le contenu de configuration**
   - Extraire la liste des types disponibles
   - Vérifier les restrictions de scope
   - Obtenir les limites de longueur de message
   - Vérifier les paramètres de langue

3. **Analyser l'historique des commits existants**

   ```bash
   # Apprendre les patterns d'usage à partir des commits récents
   git log --oneline -100 --pretty=format:"%s" | \
   head -20
   ```

### Analyser les exemples de configuration

**commitlint.config.mjs standard** :

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "perf", "test", "chore"],
    ],
    "scope-enum": [2, "always", ["api", "ui", "core", "auth", "db"]],
  },
};
```

**Configuration compatible japonais** :

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "subject-case": [0], // Désactiver pour le japonais
    "subject-max-length": [2, "always", 72],
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "test", "chore"],
    ],
  },
};
```

**Configuration avec types personnalisés** :

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // Travail en cours
        "hotfix", // Correction d'urgence
        "release", // Préparation de release
        "deps", // Mise à jour de dépendance
        "config", // Changement de configuration
      ],
    ],
  },
};
```

### Comportement de fallback

Si aucun fichier de configuration n'est trouvé :

1. **Inférence automatique** par analyse du git log

   ```bash
   # Extraire les types des 100 derniers commits
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

2. **Par défaut au standard Conventional Commits**

   ```
   feat, fix, docs, style, refactor, perf, test, chore, build, ci
   ```

3. **Détermination de langue**
   - Mode français si détection de caractères accentués français
   - Mode anglais par défaut

## Exigences

- Doit être dans un dépôt Git
- Besoin de changements non committés
- Les changements stagés sont temporairement réinitialisés

## Important

- **Ne pushera pas** : Vous devez `git push` vous-même
- **Même branche** : Les commits restent dans la branche actuelle
- **Sauvegardez d'abord** : Considérez `git stash` pour la sécurité

## Quelles règles gagnent

Lors de la création de messages de commit, nous suivons cet ordre :

1. **Paramètres CommitLint** (priorité la plus élevée)
   - Paramètres dans les fichiers `commitlint.config.*`
   - Types personnalisés et restrictions de scope
   - Restrictions de longueur et de casse de message

2. **Historique des commits existants** (deuxième priorité)
   - Statistiques des types réellement utilisés
   - Langue des messages (français/anglais)
   - Patterns d'usage des scopes

3. **Type de projet** (troisième priorité)
   - `package.json` → Projet Node.js
   - `Cargo.toml` → Projet Rust
   - `pom.xml` → Projet Java

4. **Standard Conventional Commits** (fallback)
   - Comportement standard quand aucun paramètre n'est trouvé

### Exemples de détection de convention

**Détection automatique de scope dans Monorepo** :

```bash
# Inférer les scopes à partir du dossier packages/
ls packages/ | head -10
# → Proposer api, ui, core, auth, etc. comme scopes
```

**Conventions spécifiques au framework** :

```javascript
// Pour les projets Angular
{
  'scope-enum': [2, 'always', [
    'animations', 'common', 'core', 'forms', 'http', 'platform-browser',
    'platform-server', 'router', 'service-worker', 'upgrade'
  ]]
}

// Pour les projets React
{
  'scope-enum': [2, 'always', [
    'components', 'hooks', 'utils', 'types', 'styles', 'api'
  ]]
}
```

**Conventions spécifiques à l'entreprise/équipe** :

```javascript
// Pattern courant dans les équipes françaises
{
  'type-enum': [2, 'always', [
    'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
    'wip',      // Travail en cours (pour les pull requests)
    'hotfix',   // Correction d'urgence
    'release'   // Préparation de release
  ]],
  'subject-case': [0],  // Support japonais
  'subject-max-length': [2, 'always', 72]  // Limite plus longue pour le japonais
}
```

## Bonnes pratiques

1. **Suivre les règles** : Utiliser les patterns existants
2. **Garder petit** : Un changement logique par commit
3. **Être clair** : Dire ce qui a changé
4. **Grouper intelligemment** : Fichiers liés ensemble
5. **Tests séparés** : Commits de tests seuls
6. **Utiliser les configurations** : CommitLint aide les équipes à rester cohérentes

## Exemples de division du monde réel (Avant/Après)

### Exemple 1 : Ajout de système d'authentification volumineux

**Avant (un commit massif)** :

```bash
# Fichiers modifiés (15 fichiers, 850 lignes modifiées)
src/auth/login.js          # Nouveau
src/auth/register.js       # Nouveau
src/auth/password.js       # Nouveau
src/auth/types.js          # Nouveau
src/api/auth-routes.js     # Nouveau
src/middleware/auth.js     # Nouveau
src/database/migrations/001_users.sql  # Nouveau
src/database/models/user.js            # Nouveau
tests/auth/login.test.js   # Nouveau
tests/auth/register.test.js # Nouveau
tests/api/auth-routes.test.js # Nouveau
docs/authentication.md    # Nouveau
package.json              # Ajout de dépendance
README.md                 # Ajout d'usage
.env.example             # Exemple de variable d'environnement

# Commit conventionnel problématique
feat: implement complete user authentication system with login, registration, password reset, API routes, database models, tests and documentation
```

**Après (divisé en 5 commits significatifs)** :

```bash
# Commit 1 : Fondation base de données
feat(db): add user model and authentication schema

Fichiers inclus :
- src/database/migrations/001_users.sql
- src/database/models/user.js
- src/auth/types.js

Raison : La structure de base de données est la fondation pour les autres fonctionnalités, committée en premier

# Commit 2 : Logique d'authentification
feat(auth): implement core authentication functionality

Fichiers inclus :
- src/auth/login.js
- src/auth/register.js
- src/auth/password.js
- src/middleware/auth.js

Raison : Logique métier d'authentification centrale committée ensemble

# Commit 3 : Points de terminaison API
feat(api): add authentication API routes

Fichiers inclus :
- src/api/auth-routes.js

Raison : La couche API dépend de la logique d'authentification, committée plus tard

# Commit 4 : Tests complets
test(auth): add comprehensive authentication tests

Fichiers inclus :
- tests/auth/login.test.js
- tests/auth/register.test.js
- tests/api/auth-routes.test.js

Raison : Tests ajoutés après que l'implémentation soit complète

# Commit 5 : Documentation et configuration
docs(auth): add authentication documentation and configuration

Fichiers inclus :
- docs/authentication.md
- package.json
- README.md
- .env.example

Raison : Documentation et configuration committées ensemble à la fin
```

### Exemple 2 : Corrections de bugs et refactorisation mixtes

**Avant (commit mixte problématique)** :

```bash
# Fichiers modifiés (8 fichiers, 320 lignes modifiées)
src/user/service.js       # Corrections de bugs + Refactorisation
src/user/validator.js     # Nouveau (refactorisation)
src/auth/middleware.js    # Correction de bug
src/api/user-routes.js    # Correction de bug + Amélioration de gestion d'erreurs
tests/user.test.js        # Ajout de test
tests/auth.test.js        # Ajout de test de correction de bug
docs/user-api.md          # Mise à jour de documentation
package.json              # Mise à jour de dépendance

# Commit problématique
fix: resolve user validation bugs and refactor validation logic with improved error handling
```

**Après (divisé en 3 commits par type)** :

```bash
# Commit 1 : Corrections de bugs critiques
fix: resolve user validation and authentication bugs

Fichiers inclus :
- src/user/service.js (portion correction de bug uniquement)
- src/auth/middleware.js
- tests/auth.test.js (tests de correction de bugs uniquement)

Raison : Bugs affectant la production corrigés avec la priorité la plus élevée

# Commit 2 : Refactorisation de logique de validation
refactor: extract and improve user validation logic

Fichiers inclus :
- src/user/service.js (portion refactorisation)
- src/user/validator.js
- src/api/user-routes.js
- tests/user.test.js

Raison : Améliorations structurelles committées comme unités fonctionnelles

# Commit 3 : Documentation et mise à jour de dépendance
chore: update documentation and dependencies

Fichiers inclus :
- docs/user-api.md
- package.json

Raison : Améliorations de l'environnement de développement committées ensemble à la fin
```

### Exemple 3 : Développement simultané de multiples fonctionnalités

**Avant (commit massif cross-fonctionnel)** :

```bash
# Fichiers modifiés (12 fichiers, 600 lignes modifiées)
src/user/profile.js       # Nouvelle fonctionnalité A
src/user/avatar.js        # Nouvelle fonctionnalité A
src/notification/email.js # Nouvelle fonctionnalité B
src/notification/sms.js   # Nouvelle fonctionnalité B
src/api/profile-routes.js # API nouvelle fonctionnalité A
src/api/notification-routes.js # API nouvelle fonctionnalité B
src/dashboard/widgets.js  # Nouvelle fonctionnalité C
src/dashboard/charts.js   # Nouvelle fonctionnalité C
tests/profile.test.js     # Tests nouvelle fonctionnalité A
tests/notification.test.js # Tests nouvelle fonctionnalité B
tests/dashboard.test.js   # Tests nouvelle fonctionnalité C
package.json              # Dépendances de toutes les fonctionnalités

# Commit problématique
feat: add user profile management, notification system and dashboard widgets
```

**Après (divisé en 4 commits par fonctionnalité)** :

```bash
# Commit 1 : Fonctionnalité profil utilisateur
feat(profile): add user profile management

Fichiers inclus :
- src/user/profile.js
- src/user/avatar.js
- src/api/profile-routes.js
- tests/profile.test.js

Raison : La fonctionnalité profil est une unité fonctionnelle indépendante

# Commit 2 : Système de notification
feat(notification): implement email and SMS notifications

Fichiers inclus :
- src/notification/email.js
- src/notification/sms.js
- src/api/notification-routes.js
- tests/notification.test.js

Raison : La fonctionnalité notification est une unité fonctionnelle indépendante

# Commit 3 : Widgets de tableau de bord
feat(dashboard): add interactive widgets and charts

Fichiers inclus :
- src/dashboard/widgets.js
- src/dashboard/charts.js
- tests/dashboard.test.js

Raison : La fonctionnalité tableau de bord est une unité fonctionnelle indépendante

# Commit 4 : Mise à jour des dépendances et infrastructure
chore: update dependencies for new features

Fichiers inclus :
- package.json

Raison : Mises à jour de dépendances communes committées ensemble à la fin
```

## Comparaison des effets de division

| Élément                     | Avant (Commit massif)                               | Après (Division appropriée)                                          |
| --------------------------- | --------------------------------------------------- | -------------------------------------------------------------------- |
| **Reviewabilité**           | ❌ Très difficile                                   | ✅ Chaque commit est petit et reviewable                             |
| **Suivi de bugs**           | ❌ Difficile d'identifier l'emplacement du problème | ✅ Les commits problématiques peuvent être immédiatement identifiés  |
| **Revert**                  | ❌ Besoin de tout reverter                          | ✅ Peut identifier et reverter uniquement les parties problématiques |
| **Développement parallèle** | ❌ Sujet aux conflits                               | ✅ Fusion basée sur les fonctionnalités est facile                   |
| **Déploiement**             | ❌ Toutes les fonctionnalités déployées en une fois | ✅ Déploiement par étapes possible                                   |

## Dépannage

### Quand le commit échoue

- Vérifier les hooks pre-commit
- Résoudre les dépendances
- Réessayer avec des fichiers individuels

### Quand la division est inappropriée

- Ajuster avec l'option `--max-commits`
- Utiliser le mode manuel `edit`
- Relancer avec une granularité plus fine
