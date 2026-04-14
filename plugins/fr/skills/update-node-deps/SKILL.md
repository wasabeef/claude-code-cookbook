---
description: "Mettre à jour les dépendances Node.js en toute sécurité"
---

## Mettre à jour les dépendances Node.js en toute sécurité

Met à jour en toute sécurité les dépendances de votre projet Node.js.

### Utilisation

```bash
# Vérifier le statut des dépendances et demander l'aide de Claude
npm outdated
"Please update the dependencies in package.json to their latest versions"
```

### Exemples de base

```bash
# Vérifier les dépendances actuelles
cat package.json
"Analyze this Node.js project's dependencies and tell me which packages can be updated"

# Vérifier la liste des packages à mettre à jour
npm outdated
"Analyze the risk level of updating these packages"
```

### Intégration avec Claude

```bash
# Mise à jour complète des dépendances
cat package.json
"Analyze Node.js dependencies and perform the following:
1. Research the latest version of each package
2. Check for breaking changes
3. Evaluate risk level (safe, caution, dangerous)
4. Suggest necessary code changes
5. Generate updated package.json"

# Mise à jour sûre et progressive
npm outdated
"Update only packages that can be safely updated, avoiding major version upgrades"

# Analyse d'impact pour la mise à jour d'un package spécifique
"Tell me the impact and necessary changes when updating express to the latest version"
```

### Exemples détaillés

```bash
# Analyse détaillée incluant les notes de version
cat package.json && npm outdated
"Analyze dependencies and provide the following for each package in table format:
1. Current → Latest version
2. Risk evaluation (safe, caution, dangerous)
3. Main changes (from CHANGELOG)
4. Required code fixes"

# Projet TypeScript avec considération des définitions de type
cat package.json tsconfig.json
"Update dependencies including TypeScript type definitions and create an update plan that avoids type errors"
```

### Critères de risque

```text
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
cp package.json package.json.backup
cp package-lock.json package-lock.json.backup

# Exécuter la mise à jour
npm update

# Vérifier après la mise à jour
npm test
npm run build
npm audit
```

### Notes

Toujours vérifier la fonctionnalité après les mises à jour. En cas de problème, restaurer avec :

```bash
cp package.json.backup package.json
cp package-lock.json.backup package-lock.json
npm install
```
