## Message de commit

Génère des messages de commit à partir des modifications indexées (git diff --staged). Cette commande ne fait que créer des messages et les copie dans votre presse-papiers—elle n'exécute aucune commande git.

### Usage

```bash
/commit-message [options]
```

### Options

- `--format <format>` : Choisir le format du message (conventional, gitmoji, angular)
- `--lang <language>` : Définir la langue explicitement (en, fr)
- `--breaking` : Inclure la détection de changements cassants

### Exemples de base

```bash
# Générer un message à partir des modifications indexées (langue auto-détectée)
# La suggestion principale est automatiquement copiée dans votre presse-papiers
/commit-message

# Spécifier la langue explicitement
/commit-message --lang fr
/commit-message --lang en

# Inclure la détection de changements cassants
/commit-message --breaking
```

### Prérequis

**Important** : Cette commande ne fonctionne qu'avec les modifications indexées. Exécutez d'abord `git add` pour indexer vos modifications.

```bash
# Si rien n'est indexé, vous verrez :
$ /commit-message
Aucune modification indexée trouvée. Veuillez d'abord exécuter git add.
```

### Fonctionnalité de presse-papiers automatique

La suggestion principale est copiée dans votre presse-papiers comme commande complète : `git commit -m "message"`. Il suffit de la coller et l'exécuter dans votre terminal.

**Notes d'implémentation** :

- Exécuter `pbcopy` dans un processus séparé de la sortie du message
- Utiliser `printf` au lieu de `echo` pour éviter les sauts de ligne indésirables

### Détection automatique des conventions de projet

**Important** : Si des conventions spécifiques au projet existent, elles ont la priorité.

#### 1. Vérification de la configuration CommitLint

Détecte automatiquement les paramètres des fichiers suivants :

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `package.json` avec section `commitlint`

```bash
# Rechercher les fichiers de configuration
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

#### 2. Détection de types personnalisés

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
        "wip", // travail en cours
        "hotfix", // correction urgente
        "release", // version
        "deps", // mise à jour de dépendance
        "config", // changement de configuration
      ],
    ],
  },
};
```

#### 3. Détection des paramètres de langue

```javascript
// Quand le projet utilise des messages français
export default {
  rules: {
    "subject-case": [0], // Désactivé pour le support français
    "subject-max-length": [2, "always", 72], // Limite de caractères ajustée pour le français
  },
};
```

#### 4. Analyse de l'historique des commits existants

```bash
# Apprendre les modèles des commits récents
git log --oneline -50 --pretty=format:"%s"

# Statistiques d'utilisation des types
git log --oneline -100 --pretty=format:"%s" | \
grep -oE '^[a-z]+(\([^)]+\))?' | \
sort | uniq -c | sort -nr
```

### Détection automatique de la langue

Bascule automatiquement entre français/anglais basé sur :

1. **Configuration CommitLint** paramètres de langue
2. **Analyse git log** détection automatique
3. **Fichier de projet** paramètres de langue
4. **Fichier modifié** analyse des commentaires et chaînes

Par défaut c'est l'anglais. Génère en français si détecté comme projet français.

### Format de message

#### Commits conventionnels (Par défaut)

```text
<type>: <description>
```

**Important** : Génère toujours des messages de commit sur une seule ligne. Ne génère pas de messages multi-lignes.

**Note** : Les conventions spécifiques au projet ont la priorité si elles existent.

### Types standards

**Types requis** :

- `feat` : Nouvelle fonctionnalité (ajout de fonctionnalité visible pour l'utilisateur)
- `fix` : Correction de bug

**Types optionnels** :

- `build` : Changements du système de build ou dépendances externes
- `chore` : Autres changements (aucun impact sur la version)
- `ci` : Changements des fichiers de configuration et scripts CI
- `docs` : Changements de documentation uniquement
- `style` : Changements qui n'affectent pas la signification du code (espaces, formatage, points-virgules, etc.)
- `refactor` : Changements de code sans corrections de bugs ni ajouts de fonctionnalités
- `perf` : Améliorations de performances
- `test` : Ajout ou correction de tests

### Exemple de sortie (Projet anglais)

```bash
$ /commit-message

📝 Suggestions de message de commit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidat principal :
feat: implement JWT-based authentication system

📋 Alternatives :
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

✅ `git commit -m "feat: implement JWT-based authentication system"` copié dans le presse-papiers
```

**Exemple d'implémentation (Corrigé)** :

```bash
# Copier d'abord la commande commit dans le presse-papiers (pas de saut de ligne)
printf 'git commit -m "%s"' "$COMMIT_MESSAGE" | pbcopy

# Puis afficher le message
cat << EOF
📝 Suggestions de message de commit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidat principal :
$COMMIT_MESSAGE

📋 Alternatives :
1. ...
2. ...
3. ...

✅ \`git commit -m "$COMMIT_MESSAGE"\` copié dans le presse-papiers
EOF
```

### Exemple de sortie (Projet français)

```bash
$ /commit-message

📝 Suggestions de message de commit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidat principal :
feat: système d'authentification JWT implémenté

📋 Alternatives :
1. feat: ajouter authentification utilisateur avec tokens JWT
2. fix: résoudre erreur de validation de token dans middleware auth
3. docs: séparer logique auth dans module différent

✅ `git commit -m "feat: système d'authentification JWT implémenté"` copié dans le presse-papiers
```

### Vue d'ensemble du fonctionnement

1. **Analyse** : Analyser le contenu de `git diff --staged`
2. **Génération** : Générer un message de commit approprié
3. **Copie** : Copier automatiquement le candidat principal dans le presse-papiers

**Note** : Cette commande n'exécute pas git add ou git commit. Elle ne fait que générer des messages de commit et les copie dans le presse-papiers.

### Fonctionnalités intelligentes

#### 1. Classification automatique des changements (Fichiers indexés uniquement)

- Ajout de nouveau fichier → `feat`
- Modèles de correction d'erreur → `fix`
- Fichiers de test uniquement → `test`
- Changements de fichiers de configuration → `chore`
- Mises à jour README/docs → `docs`

#### 2. Détection automatique des conventions de projet

- Fichier `.gitmessage`
- Conventions dans `CONTRIBUTING.md`
- Modèles d'historique de commits passés

#### 3. Détails de détection de langue (Modifications indexées uniquement)

```bash
# Critères de détection (ordre de priorité)
1. Détecter la langue à partir du contenu git diff --staged
2. Analyse des commentaires des fichiers indexés
3. Analyse de langue de git log --oneline -20
4. Paramètres de langue principale du projet
```

#### 4. Détails de l'analyse d'indexation

Informations utilisées pour l'analyse (lecture seule) :

- `git diff --staged --name-only` - Liste des fichiers modifiés
- `git diff --staged` - Contenu réel des changements
- `git status --porcelain` - Statut des fichiers

### Détection de changements cassants

Pour les changements d'API cassants :

**Français** :

```bash
feat!: changer format de réponse API utilisateur

BREAKING CHANGE: la réponse utilisateur inclut maintenant des métadonnées supplémentaires
```

Ou :

```bash
feat(api)!: changer flux d'authentification
```

**Anglais** :

```bash
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

Ou :

```bash
feat(api)!: change authentication flow
```

### Meilleures pratiques

1. **Correspondre au projet** : Suivre la langue de commit existante
2. **Concision** : Clair en moins de 50 caractères
3. **Cohérence** : Ne pas mélanger les langues (rester cohérent en français)
4. **OSS** : Anglais recommandé pour l'open source
5. **Ligne unique** : Toujours message de commit sur une ligne (compléter avec PR pour explications détaillées)

### Modèles communs

**Français** :

```text
feat: ajouter endpoint d'inscription utilisateur
fix: résoudre fuite mémoire dans gestionnaire cache
docs: mettre à jour documentation API
```

**Anglais** :

```text
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

### Intégration avec Claude

```bash
# Utiliser avec les modifications indexées
git add -p  # Indexation interactive
/commit-message
"Générer message de commit optimal"

# Indexer et analyser des fichiers spécifiques
git add src/auth/*.js
/commit-message --lang fr
"Générer message pour changements d'authentification"

# Détection et gestion de changement cassant
git add -A
/commit-message --breaking
"Marquer appropriément s'il y a des changements cassants"
```

### Notes importantes

- **Prérequis** : Les modifications doivent être indexées avec `git add` au préalable
- **Limitation** : Les modifications non indexées ne sont pas analysées
- **Recommandation** : Vérifier d'abord les conventions de commit du projet existant
