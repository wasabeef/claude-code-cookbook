## Analyser les dépendances du projet et évaluer la santé architecturale

Analyse les dépendances de votre projet et vérifie la santé architecturale.

### Utilisation

```bash
/dependency-analysis [options]
```

### Options

- `--visual` : Afficher visuellement les dépendances
- `--circular` : Détecter uniquement les dépendances circulaires
- `--depth <number>` : Spécifier la profondeur d'analyse (défaut : 3)
- `--focus <path>` : Se concentrer sur un module/répertoire spécifique

### Exemples de base

```bash
# Analyser les dépendances pour tout le projet
/dependency-analysis

# Détecter les dépendances circulaires
/dependency-analysis --circular

# Analyse détaillée d'un module spécifique
/dependency-analysis --focus src/core --depth 5
```

### Ce qui est analysé

#### 1. Matrice de dépendances

Montre comment les modules se connectent les uns aux autres :

- Dépendances directes
- Dépendances indirectes
- Profondeur des dépendances
- Fan-in/fan-out

#### 2. Violations architecturales

- Violations de couches (quand les couches inférieures dépendent des supérieures)
- Dépendances circulaires
- Couplage excessif (trop de connexions)
- Modules orphelins

#### 3. Vérification de Clean Architecture

- La couche domaine est-elle indépendante ?
- L'infrastructure est-elle correctement séparée ?
- Les dépendances de cas d'usage s'écoulent-elles correctement ?
- Les interfaces sont-elles utilisées correctement ?

### Exemple de sortie

```text
Rapport d'analyse de dépendances
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Vue d'ensemble des métriques
├─ Modules totaux : 42
├─ Dépendances moyennes : 3,2
├─ Profondeur maximale de dépendances : 5
└─ Dépendances circulaires : 2 détectées

⚠️  Violations architecturales
├─ [HAUTE] src/domain/user.js → src/infra/database.js
│  └─ La couche domaine dépend directement de la couche infrastructure
├─ [MOY] src/api/auth.js ⟲ src/services/user.js
│  └─ Dépendance circulaire détectée
└─ [BASSE] src/utils/helper.js → 12 modules
   └─ Fan-out excessif

✅ Actions recommandées
1. Introduire l'interface UserRepository
2. Repenser les responsabilités du service d'authentification
3. Diviser les fonctions d'aide par fonctionnalité

📈 Graphique de dépendances
[Diagramme de dépendances visuelles affiché en art ASCII]
```

### Exemples d'utilisation avancée

```bash
# Vérifications automatiques CI/CD
/dependency-analysis --circular --fail-on-violation

# Vérifier contre les règles d'architecture
/dependency-analysis --rules .architecture-rules.yml

# Voir comment les dépendances ont changé
/dependency-analysis --compare HEAD~10
```

### Exemple de fichier de configuration (.dependency-analysis.yml)

```yaml
rules:
  - name: "Indépendance du domaine"
    source: "src/domain/**"
    forbidden: ["src/infra/**", "src/api/**"]

  - name: "Dépendances couche API"
    source: "src/api/**"
    allowed: ["src/domain/**", "src/application/**"]
    forbidden: ["src/infra/**"]

thresholds:
  max_dependencies: 8
  max_depth: 4
  coupling_threshold: 0.7

ignore:
  - "**/test/**"
  - "**/mocks/**"
```

### Outils que nous utilisons

- `madge` : Montre visuellement les dépendances JavaScript/TypeScript
- `dep-cruiser` : Vérifie les règles de dépendances
- `nx` : Gère les dépendances de monorepo
- `plato` : Analyse la complexité et les dépendances ensemble

### Collaboration avec Claude

```bash
# Vérifier les dépendances avec package.json
cat package.json
/analyze-dependencies
"Find dependency issues in this project"

# Plongée profonde dans un module spécifique
ls -la src/core/
/analyze-dependencies --focus src/core
"Check the core module's dependencies in detail"

# Comparer conception vs réalité
cat docs/architecture.md
/analyze-dependencies --visual
"Does our implementation match the architecture docs?"
```

### Notes

- **Exécuter depuis** : Répertoire racine du projet
- **Soyez patient** : Les gros projets prennent du temps à analyser
- **Agissez rapidement** : Corrigez les dépendances circulaires dès que vous les trouvez

### Bonnes pratiques

1. **Vérifier hebdomadairement** : Gardez un œil sur la santé des dépendances
2. **Écrire les règles** : Mettre les règles d'architecture dans les fichiers de configuration
3. **Petites étapes** : Corriger les choses progressivement, pas tout d'un coup
4. **Suivre les tendances** : Observer comment la complexité évolue dans le temps
