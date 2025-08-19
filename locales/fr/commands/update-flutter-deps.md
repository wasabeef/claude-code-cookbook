## Flutter Dependencies Update

Met à jour en toute sécurité les dépendances de votre projet Flutter.

### Utilisation

```bash
# Vérifier le statut des dépendances et demander l'aide de Claude
flutter pub deps --style=compact
"Please update the dependencies in pubspec.yaml to their latest versions"
```

### Exemples de base

```bash
# Vérifier les dépendances actuelles
cat pubspec.yaml
"Analyze this Flutter project's dependencies and tell me which packages can be updated"

# Vérifier avant la mise à niveau
flutter pub upgrade --dry-run
"Check if there are any breaking changes in this planned upgrade"
```

### Intégration avec Claude

```bash
# Mise à jour complète des dépendances
cat pubspec.yaml
"Analyze Flutter dependencies and perform the following:
1. Research the latest version of each package
2. Check for breaking changes
3. Evaluate risk level (safe, caution, dangerous)
4. Suggest necessary code changes
5. Generate updated pubspec.yaml"

# Mise à jour sûre et progressive
flutter pub outdated
"Update only packages that can be safely updated, avoiding major version upgrades"

# Analyse d'impact pour la mise à jour d'un package spécifique
"Tell me the impact and necessary changes when updating provider to the latest version"
```

### Exemples détaillés

```bash
# Analyse détaillée incluant les notes de version
cat pubspec.yaml && flutter pub outdated
"Analyze dependencies and provide the following for each package in table format:
1. Current → Latest version
2. Risk evaluation (safe, caution, dangerous)
3. Main changes (from CHANGELOG)
4. Required code fixes"

# Analyse de migration Null Safety
cat pubspec.yaml
"Identify packages not compatible with Null Safety and create a migration plan"
```

### Critères de risque

```
Sûr (🟢) :
- Mise à niveau de version patch (1.2.3 → 1.2.4)
- Corrections de bugs uniquement
- Compatibilité ascendante garantie

Attention (🟡) :
- Mise à niveau de version mineure (1.2.3 → 1.3.0)
- Nouvelles fonctionnalités ajoutées
- Avertissements de dépréciation

Dangereux (🔴) :
- Mise à niveau de version majeure (1.2.3 → 2.0.0)
- Changements cassants
- Suppression ou modification d'API
```

### Exécution de la mise à jour

```bash
# Créer des sauvegardes
cp pubspec.yaml pubspec.yaml.backup
cp pubspec.lock pubspec.lock.backup

# Exécuter la mise à jour
flutter pub upgrade

# Vérifier après la mise à jour
flutter analyze
flutter test
flutter pub deps --style=compact
```

### Notes

Toujours vérifier la fonctionnalité après les mises à jour. En cas de problème, restaurer avec :

```bash
cp pubspec.yaml.backup pubspec.yaml
cp pubspec.lock.backup pubspec.lock
flutter pub get
```
