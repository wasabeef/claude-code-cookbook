## Plan

Vous aide à planifier avant de coder. Crée des stratégies détaillées pour faciliter le développement.

### Utilisation

```bash
# Demander le Mode Plan à Claude
"Créez un plan d'implémentation pour [contenu d'implémentation]"
```

### Exemples de base

```bash
# Plan d'implémentation pour une nouvelle fonctionnalité
"Créez un plan d'implémentation pour la fonctionnalité d'authentification utilisateur"

# Plan de conception système
"Créez un plan d'implémentation pour la division en microservices"

# Plan de refactorisation
"Créez un plan de refactorisation pour le code hérité"
```

### Collaboration avec Claude

```bash
# Implémentation de fonctionnalité complexe
"Créez un plan d'implémentation pour la fonctionnalité de chat, incluant WebSocket, notifications temps réel et gestion de l'historique"

# Conception de base de données
"Créez un plan de conception de base de données pour un site e-commerce, incluant la gestion des produits, commandes et utilisateurs"

# Conception d'API
"Créez un plan d'implémentation pour une API GraphQL, incluant authentification, cache et limitation de débit"

# Conception d'infrastructure
"Créez un plan d'implémentation pour la dockerisation, incluant environnement de développement, environnement de production et CI/CD"
```

### Comment fonctionne le Mode Plan

**Démarrage automatique**

- Démarre automatiquement quand vous décrivez ce qu'il faut construire
- Ou dites simplement "Créez un plan d'implémentation"

**Ce que vous obtenez**

- Exigences claires (user stories, critères de succès)
- Docs de conception (architecture, modèle de données, UI)
- Étapes d'implémentation (tâches, suivi, vérifications qualité)
- Analyse des risques et solutions

**Obtenir votre approbation**

- Je vous montrerai le plan en utilisant `exit_plan_mode`
- **Important** : J'attends toujours votre OK explicite
- Je ne coderai pas sans votre approbation
- Vous pouvez demander des changements à tout moment
- Le suivi TodoWrite commence après votre approbation

### Exemples détaillés

```bash
# Implémentation de système complexe
"Créez un plan d'implémentation pour un système de paiement en ligne, incluant intégration Stripe, sécurité et gestion d'erreurs"

# Implémentation frontend
"Créez un plan d'implémentation pour un tableau de bord React, incluant gestion d'état, conception de composants et tests"

# Implémentation backend
"Créez un plan d'implémentation pour une API RESTful, incluant authentification, validation et journalisation"

# Implémentation DevOps
"Créez un plan d'implémentation pour un pipeline CI/CD, incluant automatisation de tests, déploiement et surveillance"
```

### Flux de travail en 3 phases

#### Phase 1 : Exigences

- **User Stories** : Que construisons-nous et pourquoi ?
- **Critères de succès** : Comment savons-nous que c'est terminé ?
- **Contraintes** : Quelles limites avons-nous ?
- **Priorité** : Qu'est-ce qui est indispensable vs agréable à avoir ?

#### Phase 2 : Conception

- **Architecture** : Comment le système fonctionnera-t-il ?
- **Modèle de données** : Schéma de base de données et APIs
- **UI/UX** : Mises en page d'écran et flux utilisateur
- **Risques** : Qu'est-ce qui pourrait mal tourner et comment le prévenir

#### Phase 3 : Implémentation

- **Décomposition des tâches** : Diviser en blocs gérables
- **Suivi du progrès** : TodoWrite gère le statut
- **Vérifications qualité** : Plan de tests et de vérification
- **Votre approbation** : Montrer le plan et attendre votre OK

### Remarques

**Quand utiliser ceci**

- Idéal pour les projets complexes
- À éviter pour les corrections simples
- Excellent pour les tâches à 3+ étapes ou nouvelles fonctionnalités

**Notes techniques**

- Ne pas se fier aux valeurs de retour de `exit_plan_mode`
- Seule votre approbation explicite compte
- Fonctionne différemment du mode plan CLI

**Règles importantes**

- Ne jamais commencer à coder avant votre approbation
- Toujours attendre votre réponse
- Offrir des alternatives si quelque chose échoue

### Exemple d'exécution

```bash
# Exemple d'utilisation
"Créez un plan d'implémentation pour un système de gestion d'utilisateurs"

# Ce qui se passe :
# 1. Le Mode Plan démarre
# 2. Analyser les exigences et choisir la technologie
# 3. Structurer l'implémentation
# 4. Vous montrer le plan
# 5. Commencer à coder après votre approbation
```
