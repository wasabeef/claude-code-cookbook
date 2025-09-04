## Aide Rôles

Un guide de sélection et système d'aide quand vous n'êtes pas sûr du rôle à utiliser.

### Utilisation

```bash
/role-help                      # Guide général de sélection de rôle
/role-help <situation/problème>  # Rôles recommandés pour des situations spécifiques
/role-help compare <Rôle 1>,<Rôle 2> # Comparer les rôles
```

### Exemples de base

```bash
# Guidance générale
/role-help
→ Liste des rôles disponibles et leurs caractéristiques

# Recommandation spécifique à une situation
/role-help "Préoccupé par la sécurité API"
→ Recommandation et utilisation du rôle sécurité

# Comparaison de rôles
/role-help compare frontend,mobile
→ Différences et utilisation appropriée entre les rôles frontend et mobile
```

### Guide de sélection de rôle basé sur situation

### Sécurité

```
Utilisez le rôle security pour :
✅ Implémentation des fonctions de connexion/authentification
✅ Vérifications de vulnérabilités de sécurité pour les API
✅ Chiffrement des données et protection de la vie privée
✅ Vérification de conformité sécuritaire
✅ Tests de pénétration

Usage : /role security
```

### 🏗️ Architecture & Conception

```
Utilisez le rôle architect pour :
✅ Évaluation de la conception globale du système
✅ Décisions microservices vs monolithe
✅ Conception de base de données et sélection technologique
✅ Considérations de scalabilité et d'extensibilité
✅ Évaluation de la dette technique et planification d'amélioration

Usage : /role architect
```

### ⚡ Problèmes de performance

```
Utilisez le rôle performance pour :
✅ Applications lentes
✅ Optimisation des requêtes de base de données
✅ Amélioration de la vitesse de chargement des pages web
✅ Optimisation de l'utilisation mémoire et CPU
✅ Mise à l'échelle et contremesures de charge

Usage : /role performance
```

### 🔍 Investigation cause racine de problèmes

```
Utilisez le rôle analyzer pour :
✅ Analyse de cause racine des bugs et erreurs
✅ Investigation des pannes système
✅ Analyse structurelle de problèmes complexes
✅ Analyse de données et recherche statistique
✅ Comprendre pourquoi les problèmes surviennent

Usage : /role analyzer
```

### 🎨 Frontend & UI/UX

```
Utilisez le rôle frontend pour :
✅ Améliorations de l'interface utilisateur
✅ Conformité d'accessibilité
✅ Design responsive
✅ Amélioration de l'utilisabilité et facilité d'usage
✅ Technologies frontend web générales

Usage : /role frontend
```

### 📱 Développement d'applications mobiles

```
Utilisez le rôle mobile pour :
✅ Optimisation d'applications iOS et Android
✅ Conception UX spécifique mobile
✅ Optimisation d'interface tactile
✅ Support hors ligne et fonctions de synchronisation
✅ Conformité App Store et Google Play

Usage : /role mobile
```

### 👀 Revue de code & Qualité

```
Utilisez le rôle reviewer pour :
✅ Vérifications de qualité du code
✅ Évaluation de lisibilité et maintenabilité
✅ Vérification des conventions de codage
✅ Propositions de refactorisation
✅ Revues PR et commits

Usage : /role reviewer
```

### 🧪 Tests & Assurance qualité

```
Utilisez le rôle qa pour :
✅ Planification de stratégie de test
✅ Évaluation de couverture de test
✅ Directives d'implémentation de tests automatisés
✅ Mesures de prévention de bugs et d'amélioration de qualité
✅ Automatisation de tests en CI/CD

Usage : /role qa
```

### Quand plusieurs rôles sont nécessaires

### 🔄 multi-role (Analyse parallèle)

```
Utilisez multi-role pour :
✅ Évaluation depuis plusieurs perspectives professionnelles
✅ Création de plans d'amélioration intégrés
✅ Comparaison d'évaluations de différents domaines
✅ Organisation des contradictions et chevauchements

Exemple : /multi-role security,performance
```

### 🗣️ role-debate (Discussion)

```
Utilisez role-debate pour :
✅ Compromis entre domaines spécialisés
✅ Opinions divisées sur la sélection technologique
✅ Prise de décisions de conception par discussion
✅ Écouter des débats de différentes perspectives

Exemple : /role-debate security,performance
```

### 🤖 smart-review (Proposition automatique)

```
Utilisez smart-review pour :
✅ Incertitude sur quel rôle utiliser
✅ Vouloir connaître l'approche optimale pour la situation actuelle
✅ Choisir parmi plusieurs options
✅ Indécision de débutant

Exemple : /smart-review
```

### Tableau de comparaison des rôles

### Catégorie Sécurité

| Rôle     | Utilisation principale                    | Forces                                             | Faiblesses                                |
| -------- | ----------------------------------------- | -------------------------------------------------- | ----------------------------------------- |
| security | Vulnérabilités et contremesures d'attaque | Analyse des menaces, conception d'authentification | UX, performance                           |
| analyzer | Analyse de cause racine                   | Analyse logique, collecte de preuves               | Mesures préventives, planification future |

### Catégorie Conception

| Rôle      | Utilisation principale | Forces                                       | Faiblesses                                      |
| --------- | ---------------------- | -------------------------------------------- | ----------------------------------------------- |
| architect | Conception de système  | Perspective long terme, optimisation globale | Implémentation détaillée, solutions court terme |
| reviewer  | Qualité du code        | Niveau d'implémentation, maintenabilité      | Exigences métier, UX                            |

### Catégorie Performance

| Rôle        | Utilisation principale                  | Forces                                           | Faiblesses               |
| ----------- | --------------------------------------- | ------------------------------------------------ | ------------------------ |
| performance | Amélioration de vitesse et optimisation | Mesure, identification de goulots d'étranglement | Sécurité, UX             |
| qa          | Assurance qualité                       | Tests, automatisation                            | Conception, architecture |

### Catégorie Expérience utilisateur

| Rôle     | Utilisation principale | Forces                      | Faiblesses        |
| -------- | ---------------------- | --------------------------- | ----------------- |
| frontend | UI/UX Web              | Navigateur, accessibilité   | Côté serveur, DB  |
| mobile   | UX Mobile              | Tactile, support hors ligne | Côté serveur, Web |

### Organigramme de décision en cas d'incertitude

```
Quelle est la nature du problème ?
├─ Lié à la sécurité → security
├─ Problèmes de performance → performance
├─ Investigation bug/panne → analyzer
├─ Amélioration UI/UX → frontend ou mobile
├─ Conception/architecture → architect
├─ Qualité du code → reviewer
├─ Lié aux tests → qa
└─ Complexe/composite → smart-review pour proposition

S'étend sur plusieurs domaines ?
├─ Veux une analyse intégrée → multi-role
├─ Discussion/compromis → role-debate
└─ Incertain → smart-review
```

### Questions fréquemment posées

### Q : Quelle est la différence entre les rôles frontend et mobile ?

```
R :
frontend : Axé navigateur web, HTML/CSS/JavaScript
mobile : Axé applications mobiles, iOS/Android natif, React Native, etc.

Pour des problèmes liés aux deux, multi-role frontend,mobile est recommandé
```

### Q : Comment choisir entre les rôles security et analyzer ?

```
R :
security : Prévention des attaques et menaces, conception sécuritaire
analyzer : Analyse des causes de problèmes existants, investigation

Pour les investigations d'incidents de sécurité, utilisez multi-role security,analyzer
```

### Q : Quelle est la différence entre les rôles architect et performance ?

```
R :
architect : Conception long terme de systèmes entiers, scalabilité
performance : Améliorations spécifiques de vitesse et efficacité

Pour la conception de performance de systèmes à grande échelle, utilisez multi-role architect,performance
```

### Collaboration avec Claude

```bash
# Combiné avec description de situation
/role-help
"React app page loading is slow, receiving complaints from users"

# Combiné avec contenu de fichier
cat problem-description.md
/role-help
"Recommend the most suitable role for this problem"

# Quand incertain entre options spécifiques
/role-help compare security,performance
"Which role is appropriate for JWT token expiration issues?"
```

### Notes

- Pour les problèmes complexes, combiner plusieurs rôles est plus efficace
- Pour les urgences, utilisez un seul rôle pour une réponse rapide
- En cas d'incertitude, il est recommandé d'utiliser smart-review pour des propositions automatiques
- La décision finale devrait être prise par l'utilisateur en considérant la nature du problème
