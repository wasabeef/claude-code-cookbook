---
description: "Répondre efficacement aux commentaires de revue. Se déclenche avec « corriger les commentaires de revue », « répondre au feedback »."
allowed-tools:
  - Bash(gh *)
  - Read
  - Edit
  - Grep
  - Glob
---

# Répondre efficacement aux commentaires de revue

Gérez efficacement les commentaires de revue de Pull Requests et obtenez une résolution de cause racine en utilisant une approche d'analyse d'erreurs en 3 étapes.

## Utilisation

```bash
# Récupérer et analyser les commentaires de revue
gh pr view --comments
"Classify review comments by priority and create an action plan"

# Analyse détaillée des commentaires liés aux erreurs
gh pr checks
"Analyze CI errors using a 3-stage approach to identify root causes"

# Confirmation de qualité après corrections
npm test && npm run lint
"Fixes are complete - please check regression tests and code quality"
```

## Exemples de base

```bash
# Classer les commentaires
gh pr view 123 --comments | head -20
"Classify review comments into must/imo/nits/q categories and determine response order"

# Collecter les informations d'erreur
npm run build 2>&1 | tee error.log
"Identify the root cause of build errors and suggest appropriate fixes"

# Vérifier l'implémentation des corrections
git diff HEAD~1
"Evaluate whether this fix appropriately addresses the review comments"
```

## Système de classification des commentaires

```text
🔴 must : Corrections requises
├─ Problèmes de sécurité
├─ Bugs fonctionnels
├─ Violations des principes de conception
└─ Violations des conventions

🟡 imo : Suggestions d'amélioration
├─ Meilleures méthodes d'implémentation
├─ Améliorations de performance
├─ Améliorations de lisibilité
└─ Propositions de refactorisation

🟢 nits : Points mineurs
├─ Corrections de typos
├─ Ajustements d'indentation
├─ Ajouts de commentaires
└─ Raffinements de nommage

🔵 q : Questions/confirmations
├─ Vérification d'intention d'implémentation
├─ Clarification de spécification
├─ Contexte des décisions de conception
└─ Considération de solutions alternatives
```

## Approche d'analyse d'erreurs en 3 étapes

### Étape 1 : Collecte d'informations

**Actions requises**

- Capture complète du message d'erreur
- Revue de la pile d'appels
- Identification des conditions de reproduction

**Actions recommandées**

- Collecte d'informations d'environnement
- Historique des changements récents
- Revue des journaux associés

### Étape 2 : Analyse de cause racine

- Application de l'analyse des 5 pourquoi
- Suivi des dépendances
- Vérification des différences d'environnement
- Création de code de reproduction minimal

### Étape 3 : Implémentation de solution

- Réponse immédiate (hotfix)
- Résolution de cause racine (correction essentielle)
- Mesures préventives (prévention de récurrence)

## Flux de réponse

1. **Analyse de commentaires** : Classification par priorité
2. **Plan de correction** : Détermination de l'ordre de réponse
3. **Corrections par phases** : Critique → Haute → Moyenne → Basse
4. **Confirmation de qualité** : Tests, linting, construction
5. **Rapport de progression** : Description des corrections spécifiques

## Vérification post-correction

```bash
# Vérifications de base
npm test
npm run lint
npm run build

# Tests de régression
npm run test:e2e

# Qualité du code
npm run test:coverage
```

## Modèles de réponse

**Rapport d'achèvement de correction**

```markdown
@reviewer Merci pour vos retours.
Les corrections sont terminées :

- [Détails de correction spécifiques]
- [Résultats des tests]
- [Méthode de vérification]
```

**Explication de décision technique**

```markdown
Contexte d'implémentation : [Raison]
Alternatives considérées : [Options et raisonnement de la décision]
Avantages de la solution adoptée : [Avantages]
```

## Notes

- **Adhérer à la priorité** : Traiter dans l'ordre Critique → Haute → Moyenne → Basse
- **Tests d'abord** : Confirmer les tests de régression avant de faire des corrections
- **Rapport clair** : Décrire spécifiquement les détails de correction et méthodes de vérification
- **Dialogue constructif** : Communication polie basée sur des bases techniques
