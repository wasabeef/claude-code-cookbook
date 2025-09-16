## Tâche

Lance un agent intelligent pour gérer les recherches et investigations complexes. Excellent pour le travail à grande échelle sans consommer le contexte.

### Utilisation

```bash
# Demander une Tâche à Claude
"Enquêtez sur [tâche] en utilisant Task"
```

### Ce que fait Task

**Fonctionne de manière indépendante**

- Combine plusieurs outils automatiquement
- Collecte et analyse étape par étape
- Assemble les résultats en rapports clairs

**Économise le contexte**

- Utilise moins de mémoire que la recherche manuelle
- Recherche efficacement dans de nombreux fichiers
- Extrait les données de sources externes

**Assure la qualité**

- Vérifie si les sources sont fiables
- Vérifie sous différents angles
- Comble les lacunes manquantes

### Exemples de base

```bash
# Investigation complexe de base de code
"Enquêtez sur quels fichiers implémentent cette fonctionnalité en utilisant Task"

# Recherche de fichiers à grande échelle
"Identifiez les incohérences des fichiers de configuration en utilisant Task"

# Collecte d'informations externes
"Enquêtez sur les dernières tendances technologiques IA en utilisant Task"
```

### Collaboration avec Claude

```bash
# Analyse de problème complexe
"Analysez la cause des fuites mémoire en utilisant Task, incluant les résultats de profiling et les journaux"

# Investigation de dépendances
"Enquêtez sur les vulnérabilités de ce package npm en utilisant Task"

# Analyse de concurrents
"Enquêtez sur les spécifications API des services concurrents en utilisant Task"

# Analyse d'architecture
"Analysez les dépendances de ce microservice en utilisant Task"
```

### Task vs Autres commandes

#### Quand utiliser quoi

| Commande            | Cas d'usage principal               | Méthode d'exécution       | Collecte d'informations            |
| ------------------- | ----------------------------------- | ------------------------- | ---------------------------------- |
| **Task**            | Investigation, analyse, recherche   | Exécution autonome        | Sources multiples                  |
| ultrathink          | Réflexion profonde, jugement        | Réflexion structurée      | Focus sur connaissances existantes |
| sequential-thinking | Résolution de problèmes, conception | Réflexion étape par étape | Selon les besoins                  |
| plan                | Planification d'implémentation      | Processus d'approbation   | Analyse des exigences              |

#### Guide de décision rapide

```text
Besoin de collecter des infos ?
├─ Oui → De nombreux endroits ou beaucoup de fichiers ?
│          ├─ Oui → **Utilisez Task**
│          └─ Non → Demandez simplement normalement
└─ Non → Besoin de réflexion profonde ?
          ├─ Oui → Utilisez ultrathink/sequential-thinking
          └─ Non → Demandez simplement normalement
```

### Quand Task fonctionne le mieux

**Excellent pour**

- Explorer des bases de code complexes (dépendances, architecture)
- Rechercher dans de nombreux fichiers (patterns, configs)
- Rassembler des infos externes (tendances tech, bibliothèques)
- Combiner des données de multiples endroits (logs, métriques)
- Investigations répétitives (audits, vérifications de dette)
- Grandes recherches qui consommeraient trop de contexte

**Pas excellent pour**

- Questions simples que je connais déjà
- Tâches ponctuelles rapides
- Choses nécessitant des discussions interactives
- Décisions de conception (utilisez plan ou commandes de réflexion à la place)

### Exemples détaillés par catégorie

#### Analyse et investigation système

```bash
# Analyse de système complexe
"Identifiez les goulots d'étranglement dans le site e-commerce en utilisant Task, en enquêtant sur la base de données, l'API et le frontend"

# Analyse d'architecture
"Analysez les dépendances de ce microservice en utilisant Task, incluant la communication API et le flux de données"

# Investigation de dette technique
"Analysez la dette technique dans le code hérité en utilisant Task, incluant les priorités de refactorisation"
```

#### Sécurité et conformité

```bash
# Audit de sécurité
"Enquêtez sur les vulnérabilités de cette application en utilisant Task, basé sur OWASP Top 10"

# Investigation de licence
"Enquêtez sur les problèmes de licence dans les dépendances du projet en utilisant Task"

# Audit des fichiers de configuration
"Identifiez les incohérences de configuration de sécurité en utilisant Task, incluant les différences d'environnement"
```

#### Performance et optimisation

```bash
# Analyse de performance
"Identifiez les requêtes lourdes dans l'application en utilisant Task, incluant les plans d'exécution et propositions d'optimisation"

# Investigation d'usage des ressources
"Enquêtez sur les causes des fuites mémoire en utilisant Task, incluant les résultats de profiling et l'analyse de code"

# Analyse de la taille du bundle
"Enquêtez sur les problèmes de taille du bundle frontend en utilisant Task, incluant les suggestions d'optimisation"
```

#### Collecte d'informations externes

```bash
# Investigation de tendances technologiques
"Enquêtez sur les tendances des frameworks JavaScript 2024 en utilisant Task"

# Analyse de concurrents
"Enquêtez sur les spécifications API des services concurrents en utilisant Task, incluant un tableau de comparaison de fonctionnalités"

# Évaluation de bibliothèque
"Comparez les bibliothèques de gestion d'état en utilisant Task, incluant performance et coûts d'apprentissage"
```

### Flux d'exécution et assurance qualité

#### Flux d'exécution de Task

```text
1. Analyse initiale
   ├─ Décomposition de la tâche et identification de la portée d'investigation
   ├─ Sélection des outils nécessaires et sources d'information
   └─ Développement du plan d'exécution

2. Collecte d'informations
   ├─ Recherche de fichiers et analyse de code
   ├─ Collecte d'informations externes
   └─ Structuration des données

3. Analyse et intégration
   ├─ Analyse de pertinence des informations collectées
   ├─ Identification de patterns et problèmes
   └─ Vérification des hypothèses

4. Rapport et proposition
   ├─ Structuration des résultats
   ├─ Création de propositions d'amélioration
   └─ Présentation des actions suivantes
```

#### Assurance qualité

- **Vérification de fiabilité des sources d'information** : Confirmation des faits à partir de multiples sources
- **Vérification de complétude** : Vérification qu'il n'y a pas de lacunes dans les cibles d'investigation
- **Vérification de cohérence** : Confirmation de cohérence dans les informations contradictoires
- **Évaluation de praticabilité** : Évaluation de la faisabilité et de l'efficacité des propositions

### Gestion d'erreurs et contraintes

#### Contraintes communes

- **Limites d'usage des API externes** : Limites de débit et erreurs d'authentification
- **Limites de traitement de gros fichiers** : Contraintes de mémoire et timeout
- **Problèmes de permissions d'accès** : Restrictions sur l'accès aux fichiers et répertoires

#### Gestion d'erreurs

- **Rapport de résultats partiels** : Analyse avec seulement les informations obtenables
- **Propositions alternatives** : Suggestion de méthodes d'investigation alternatives sous contraintes
- **Exécution par étapes** : Division des tâches à grande échelle pour l'exécution

### Remarques

- Task est optimal pour les tâches d'investigation et d'analyse complexes et autonomes
- Pour les questions simples ou quand des réponses immédiates sont nécessaires, utilisez le format de question normal
- Traitez les résultats d'investigation comme informations de référence et vérifiez toujours les décisions importantes
- Lors de la collecte d'informations externes, portez attention à la fraîcheur et à l'exactitude des informations

### Exemple d'exécution

```bash
# Exemple d'usage
"Enquêtez sur les problèmes dans le schéma GraphQL en utilisant Task"

# Comportement attendu
# 1. L'agent dédié démarre
# 2. Recherche des fichiers liés à GraphQL
# 3. Analyse des définitions de schéma
# 4. Compare avec les bonnes pratiques
# 5. Identifie les problèmes et propose des améliorations
# 6. Crée un rapport structuré
```
