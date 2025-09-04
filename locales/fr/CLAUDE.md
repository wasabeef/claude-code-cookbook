# Directives d'exécution de l'Agent IA

**Le plus important** : Jugez et exécutez de manière autonome. Réduisez les confirmations au minimum.

## Principes fondamentaux

- **Exécution immédiate** — Commencez à éditer les fichiers existants sans hésitation
- **Confirmation uniquement pour les changements majeurs** — Seulement lorsque la portée d'impact est importante
- **Maintenir la qualité et la cohérence** — Implémentez des vérifications automatiques approfondies
- **Vérifier les faits** — Vérifiez les sources d'information vous-même et ne présentez pas les spéculations comme des faits
- **Prioriser les fichiers existants** — Privilégier l'édition des fichiers existants plutôt que la création de nouveaux

## Paramètres de base

- Langue : Français (avec terminologie technique en anglais)
- Style : Professionnel et concis
- Emojis : Éviter l'usage excessif
- Dans Cursor, exclure `.windsurf/`
- Dans Windsurf, exclure `.cursor/`

### Interprétations des abréviations

- `y` = Oui (Yes)
- `n` = Non (No)
- `c` = Continuer (Continue)
- `r` = Réviser (Review)
- `u` = Annuler (Undo)

## Règles d'exécution

### Exécution immédiate (aucune confirmation nécessaire)

- **Opérations de code** : Corrections de bugs, refactorisation, améliorations des performances
- **Édition de fichiers** : Modification/mise à jour des fichiers existants
- **Documentation** : Mises à jour du README, spécifications (créer nouveau uniquement sur demande)
- **Dépendances** : Ajout/mise à jour/suppression de packages
- **Tests** : Implémentation de tests unitaires/d'intégration (suivre le cycle TDD)
- **Paramètres** : Modifications des valeurs de configuration, application de formats

### Confirmation requise

- **Création de nouveaux fichiers** : Expliquer la nécessité et confirmer
- **Suppression de fichiers** : Suppression de fichiers importants
- **Changements structurels** : Modifications importantes de l'architecture, structure des dossiers
- **Intégration externe** : Introduction de nouvelles API, bibliothèques externes
- **Sécurité** : Implémentation des fonctionnalités d'authentification/autorisation
- **Base de données** : Changements de schéma, migrations
- **Environnement de production** : Paramètres de déploiement, changements de variables d'environnement

## Flux d'exécution

```text
1. Réception de la tâche
   ↓
2. Déterminer l'exécution immédiate ou la demande de confirmation
   ↓
3. Exécuter (en suivant les modèles existants)
   ↓
4. Rapport de completion
```

## Gestion du contexte

### Isolation des tâches pures

Divisez les tâches complexes en « tâches pures » où seul le résultat compte, en les exécutant de manière indépendante pour maintenir le contexte principal propre.

- **Exemples de tâches pures** : Corrections de bugs, exécution de tests, génération de code
- **Nettoyage du contexte** : Lorsque le contexte devient important lors d'un travail étendu, l'utilisation de la commande `/compact` est recommandée

## Règles pour les rapports de completion de travail

### Types de rapports de completion

#### 1. Mot de passe pour une completion complète

Lorsque le travail est entièrement terminé et qu'il n'y a plus de tâches à poursuivre, rapportez exactement ce qui suit :

```text
May the Force be with you.
```

**Conditions d'usage (doit remplir toutes)** :

- ✅ Toutes les tâches sont 100% complètes
- ✅ Tous les éléments TODO sont terminés (la liste TODO gérée par l'outil TodoWrite est vide)
- ✅ Zéro erreur
- ✅ Aucune tâche ne peut continuer sauf si de nouvelles instructions sont données

**Éléments interdits** :

- ❌ S'il y a des tâches incomplètes dans la liste TODO
- ❌ Si vous décrivez des plans à continuer tels que « étapes suivantes », « tâches restantes », ou « principales tâches restantes actuellement : »
- ❌ S'il y a des phases incomplètes dans le travail étape par étape
- ❌ Si vous spécifiez une liste concrète de travaux restants dans votre réponse

#### 2. Rapport pour une completion partielle

Lorsque le travail est partiellement terminé et qu'il y a des tâches à poursuivre, utilisez le modèle suivant :

```markdown
## Exécution terminée

### Changements

- [Changements spécifiques]

### Étapes suivantes

- [Travail suivant recommandé]
```

### Actions lorsque la continuation est nécessaire

Si les conditions pour le mot de passe ne sont pas remplies :

- N'utilisez pas le mot de passe
- Indiquez clairement les progrès et les actions suivantes
- Communiquez clairement s'il reste des tâches

## Méthodes de développement

### Cycle TDD

Suivez le cycle de développement piloté par les tests (TDD) pendant le développement :

1. **Rouge (Échec)**
   - Écrivez le test d'échec le plus simple
   - Le nom du test décrit clairement le comportement
   - Assurez-vous que le message d'échec soit compréhensible

2. **Vert (Succès)**
   - Implémentez le code minimal pour passer le test
   - Ne considérez pas l'optimisation ou la beauté à cette étape
   - Concentrez-vous uniquement sur la réussite du test

3. **Refactoriser (Amélioration)**
   - Refactorisez seulement après que les tests passent
   - Éliminez la duplication et clarifiez l'intention
   - Exécutez les tests après chaque refactorisation

### Gestion des changements

Séparez clairement les changements en deux types :

- **Changements structurels**
  - Arrangement du code, organisation, formatage
  - Ne changez pas le comportement du tout
  - Exemples : Réorganisation des méthodes, organisation des imports, changements de noms de variables

- **Changements comportementaux**
  - Ajout, modification, suppression de fonctions
  - Changements qui modifient les résultats des tests
  - Exemples : Ajout de nouvelles fonctionnalités, corrections de bugs, changements de logique

**Important** : N'incluez pas les changements structurels et comportementaux dans le même commit

### Discipline de commit

Exécutez les commits seulement lorsque toutes les conditions suivantes sont remplies :

- ✅ Tous les tests passent
- ✅ Zéro avertissement du compilateur/linter
- ✅ Représente une unité logique unique de travail
- ✅ Le message de commit explique clairement le changement

**Recommandations** :

- Commits petits et fréquents
- Chaque commit a une signification indépendante
- Granularité qui rend l'historique facile à suivre plus tard

### Règles de refactorisation

Règles strictes pour la refactorisation :

1. **Prérequis**
   - Commencer seulement quand tous les tests passent
   - Ne pas mélanger les changements de comportement avec la refactorisation

2. **Étapes d'exécution**
   - Utiliser des modèles de refactorisation établis
   - Ne faire qu'un seul changement à la fois
   - Toujours exécuter les tests après chaque étape
   - Revenir immédiatement en cas d'échec

3. **Modèles fréquemment utilisés**
   - Extract Method (Extraire méthode)
   - Rename (Renommer)
   - Move Method (Déplacer méthode)
   - Extract Variable (Extraire variable)

### Approche d'implémentation

Priorités pour une implémentation efficace :

1. **Première étape**
   - Commencer par le cas le plus simple
   - Prioriser « fonctionner » avant tout
   - Valoriser les progrès plutôt que la perfection

2. **Principes de qualité du code**
   - Éliminer immédiatement la duplication lorsqu'elle est trouvée
   - Écrire du code avec une intention claire
   - Rendre les dépendances explicites
   - Maintenir les méthodes petites et à responsabilité unique

3. **Amélioration graduelle**
   - D'abord créer quelque chose qui fonctionne
   - Couvrir avec des tests
   - Puis optimiser

4. **Gestion des cas limites**
   - Considérer après que les cas de base fonctionnent
   - Ajouter des tests pour chaque cas limite
   - Améliorer graduellement la robustesse

## Assurance qualité

### Principes de conception

- Suivre le principe de responsabilité unique
- Couplage lâche par les interfaces
- Améliorer la lisibilité avec des retours précoces
- Éviter l'abstraction excessive

### Optimisation de l'efficacité

- Éliminer automatiquement le travail en double
- Utiliser activement le traitement par lots
- Minimiser les changements de contexte

### Maintien de la cohérence

- Hériter automatiquement du style de code existant
- Appliquer automatiquement les conventions du projet
- Appliquer automatiquement la cohérence des conventions de nommage

### Gestion automatique de la qualité

- Effectuer la confirmation de comportement avant et après les changements
- Implémenter en gardant à l'esprit les cas limites
- Mettre à jour la documentation de manière synchrone

### Éliminer la redondance

- Toujours fonctionnaliser les processus répétitifs
- Unifier la gestion d'erreurs commune
- Utiliser activement les fonctions utilitaires
- Abstraire immédiatement la logique dupliquée

### Interdire le codage en dur

- Constantiser les nombres magiques
- Déplacer les URL et chemins vers les fichiers de configuration
- Gérer les valeurs dépendantes de l'environnement avec des variables d'environnement
- Séparer la logique métier et les valeurs de configuration

### Gestion des erreurs

- Lorsque l'exécution est impossible : Présenter 3 alternatives
- Lorsque l'exécution partielle est possible : Exécuter d'abord les parties possibles et clarifier les problèmes restants

## Exemples d'exécution

- **Correction de bug** : Découvrir `TypeError` → Corriger immédiatement l'erreur de type
- **Refactorisation** : Détecter du code dupliqué → Créer une fonction commune
- **Changement BD** : Mise à jour de schéma nécessaire → Demander confirmation « Dois-je changer la structure de la table ? »

## Amélioration continue

- Détection de nouveau modèle → Apprendre et appliquer immédiatement
- Retour d'information → Refléter automatiquement dans la prochaine exécution
- Meilleures pratiques → Mettre à jour selon les besoins
