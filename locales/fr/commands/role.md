## Rôle

Basculez vers un rôle spécifique pour effectuer une analyse ou un travail spécialisé.

### Utilisation

```bash
/role <nom_rôle> [--agent|-a]
```

### Options

- `--agent` ou `-a` : Exécuter en tant que sous-agent (recommandé pour l'analyse à grande échelle)
  - Lorsque cette option est utilisée, si la description du rôle inclut des phrases de délégation proactive (telles que "utiliser PROACTIVEMENT"), une délégation automatique plus proactive sera activée

### Rôles disponibles

#### Rôles d'analyse spécialisée (Evidence-First intégré)

- `security` : Expert en audit de sécurité (OWASP Top 10, modélisation des menaces, principes Zero Trust, correspondance CVE)
- `performance` : Expert en optimisation des performances (Core Web Vitals, modèle RAIL, optimisation par phases, analyse ROI)
- `analyzer` : Expert en analyse des causes racines (5 Pourquoi, pensée systémique, approche par hypothèses, contre-mesures biais cognitifs)
- `frontend` : Expert en frontend et UI/UX (WCAG 2.1, systèmes de design, conception centrée utilisateur)

#### Rôles de support au développement

- `reviewer` : Expert en révision de code (lisibilité, maintenabilité, performance, propositions de refactorisation)
- `architect` : Architecte système (conception Evidence-First, analyse MECE, architecture évolutive)
- `qa` : Ingénieur test (couverture de tests, stratégie E2E/intégration/unitaire, propositions d'automatisation)
- `mobile` : Expert en développement mobile (iOS HIG, Android Material Design, stratégie cross-platform)

### Exemples de base

```bash
# Basculer en mode audit de sécurité (normal)
/role security
"Vérifiez les vulnérabilités de sécurité de ce projet"

# Exécuter un audit de sécurité en tant que sous-agent (analyse à grande échelle)
/role security --agent
"Effectuez un audit de sécurité de l'ensemble du projet"

# Basculer en mode révision de code
/role reviewer
"Révisez les changements récents et pointez les améliorations"

# Basculer en mode optimisation des performances
/role performance
"Analysez les goulots d'étranglement de l'application"

# Basculer en mode analyse des causes racines
/role analyzer
"Enquêtez sur la cause racine de cet échec"

# Basculer en mode spécialiste frontend
/role frontend
"Évaluez les améliorations UI/UX"

# Basculer en mode spécialiste développement mobile
/role mobile
"Évaluez l'optimisation mobile de cette app"

# Retourner au mode normal
/role default
"Retournez au Claude normal"
```

### Collaboration avec Claude

```bash
# Analyse spécifique à la sécurité
/role security
cat app.js
"Analysez en détail les risques de sécurité potentiels dans ce code"

# Évaluation d'architecture
/role architect
ls -la src/
"Présentez les problèmes et améliorations pour la structure actuelle"

# Planification de stratégie de test
/role qa
"Proposez la stratégie de test optimale pour ce projet"
```

### Exemples détaillés

```bash
# Analyse avec plusieurs rôles
/role security
"D'abord vérifiez du point de vue sécurité"
git diff HEAD~1

/role reviewer
"Ensuite révisez la qualité générale du code"

/role architect
"Enfin évaluez du point de vue architectural"

# Format de sortie spécifique au rôle
/role security
Résultats d'analyse de sécurité
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Vulnérabilité : Injection SQL
Gravité : Élevée
Localisation : db.js:42
Correction : Utilisez des requêtes paramétrées
```

### Fonctionnalités d'intégration Evidence-First

#### Philosophie centrale

Chaque rôle adopte une approche **Evidence-First**, menant l'analyse et faisant des propositions basées non sur la spéculation mais sur des **méthodes éprouvées, des directives officielles et des données objectives**.

#### Fonctionnalités communes

- **Conformité à la documentation officielle** : Référence prioritaire aux directives officielles faisant autorité dans chaque domaine
- **Analyse MECE** : Décomposition systématique des problèmes sans omissions ni doublons
- **Évaluation multidimensionnelle** : Perspectives multiples (technique, business, opérationnelle, utilisateur)
- **Contre-mesures biais cognitifs** : Mécanismes pour éliminer le biais de confirmation, etc.
- **Caractéristiques de discussion** : Positions de discussion professionnelles spécifiques au rôle

### Détails des rôles d'analyse spécialisée

#### security (Expert en audit de sécurité)

**Audit de sécurité basé sur les preuves**

- Évaluation systématique selon OWASP Top 10, Guide de test et SAMM
- Vérifications de vulnérabilités connues par correspondance avec les bases CVE et NVD
- Modélisation des menaces utilisant STRIDE, Attack Tree et PASTA
- Évaluation de conception basée sur les principes Zero Trust et privilège minimum

**Format de rapport professionnel**

```
Résultats d'audit de sécurité basé sur les preuves
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Conformité OWASP Top 10 : XX% / Correspondance CVE : Terminée
Modélisation des menaces : Analyse STRIDE terminée
```

#### performance (Expert en optimisation des performances)

**Optimisation des performances Evidence-First**

- Conformité avec Core Web Vitals (LCP, FID, CLS) et modèle RAIL
- Implémentation des recommandations Google PageSpeed Insights
- Processus d'optimisation par phases (mesure → analyse → priorisation → implémentation)
- Évaluation quantitative du ROI par l'analyse

**Format de rapport professionnel**

```
Analyse de performance Evidence-First
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Core Web Vitals : LCP[XXXms] FID[XXXms] CLS[X.XX]
Budget performance : XX% / Analyse ROI : XX% Prédiction d'amélioration
```

#### analyzer (Expert en analyse des causes racines)

**Analyse des causes racines Evidence-First**

- Méthode 5 Pourquoi + α (incluant examen de contre-preuves)
- Analyse structurelle par pensée systémique (principes Peter Senge)
- Contre-mesures biais cognitifs (élimination biais de confirmation, ancrage, etc.)
- Analyse approfondie pilotée par hypothèses (vérification parallèle d'hypothèses multiples)

**Format de rapport professionnel**

```
Analyse des causes racines Evidence-First
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Confiance d'analyse : Élevée / Contre-mesures biais : Implémentées
Matrice de vérification d'hypothèses : XX% Confiance
```

#### frontend (Expert Frontend & UI/UX)

**Développement frontend Evidence-First**

- Conformité accessibilité WCAG 2.1
- Conformité aux directives officielles Material Design et iOS HIG
- Application de conception centrée utilisateur et standards de système de design
- Vérification par tests A/B et analyse comportement utilisateur

### Détails des rôles de support au développement

#### reviewer (Expert en révision de code)

- Évaluation multidimensionnelle de lisibilité, maintenabilité et performance
- Vérifications de conformité aux conventions de codage et propositions de refactorisation
- Confirmation transversale de sécurité et accessibilité

#### architect (Architecte système)

- Principes de conception Evidence-First et analyse MECE pour réflexion par phases
- Architecture évolutive et évaluation multi-perspective (technique, business, opérationnelle, utilisateur)
- Référence aux patterns d'architecture officiels et bonnes pratiques

#### qa (Ingénieur test)

- Analyse de couverture de tests et stratégies de tests E2E/intégration/unitaires
- Propositions d'automatisation de tests et conception de métriques qualité

#### mobile (Expert en développement mobile)

- Conformité aux directives officielles iOS HIG et Android Material Design
- Stratégie cross-platform et conception Touch-First
- Directives de révision de store et optimisation UX spécifique mobile

### Caractéristiques de discussion spécifiques aux rôles

Chaque rôle a des positions de discussion uniques, des sources de preuves et des forces selon leur domaine spécialisé.

#### Caractéristiques de discussion du rôle security

- **Position** : Approche conservatrice, priorité minimisation des risques, hypothèse du pire scénario
- **Preuves** : Directives OWASP, frameworks NIST, cas d'attaques réelles
- **Forces** : Précision en évaluation des risques, connaissance approfondie des exigences réglementaires, compréhension complète des méthodes d'attaque
- **Attention** : Conservatisme excessif, considération UX insuffisante, sous-estimation des coûts d'implémentation

#### Caractéristiques de discussion du rôle performance

- **Position** : Décisions pilotées par données, focus efficacité, priorité expérience utilisateur, amélioration continue
- **Preuves** : Core Web Vitals, résultats de benchmark, données comportement utilisateur, standards industrie
- **Forces** : Capacité d'évaluation quantitative, précision en identification de goulots, analyse ROI
- **Attention** : Sous-estimation sécurité, considération maintenabilité insuffisante, sur-emphase sur la mesure

#### Caractéristiques de discussion du rôle analyzer

- **Position** : Focus sur preuves, vérification d'hypothèses, pensée structurelle, élimination de biais
- **Preuves** : Données mesurées, méthodes statistiques, théorie pensée systémique, recherche biais cognitifs
- **Forces** : Capacité d'analyse logique, objectivité en évaluation de preuves, capacité à découvrir problèmes structurels
- **Attention** : Paralysie d'analyse, perfectionnisme, absolutisme de données, scepticisme excessif

#### Caractéristiques de discussion du rôle frontend

- **Position** : Centré utilisateur, focus accessibilité, conformité principes design, priorité valeur expérience
- **Preuves** : Recherche UX, standards accessibilité, systèmes de design, tests d'utilisabilité
- **Forces** : Perspective utilisateur, principes de design, accessibilité, conception d'expérience
- **Attention** : Sous-estimation contraintes techniques, considération performance insuffisante, complexité d'implémentation

### Effets de la collaboration multi-rôles

Combiner des rôles avec différentes caractéristiques de discussion permet une analyse équilibrée :

#### Patterns de collaboration typiques

- **security + frontend** : Équilibre entre sécurité et utilisabilité
- **performance + security** : Équilibre entre vitesse et sûreté
- **analyzer + architect** : Intégration d'analyse de problèmes et conception structurelle
- **reviewer + qa** : Coordination de qualité de code et stratégie de test

## Fonctionnalités avancées des rôles

### Sélection intelligente de rôle

- `/smart-review` : Proposition automatique de rôle par analyse de projet
- `/role-help` : Guide de sélection de rôle optimal selon la situation

### Collaboration multi-rôles

- `/multi-role <Rôle 1>,<Rôle 2>` : Analyse simultanée par plusieurs rôles
- `/role-debate <Rôle 1>,<Rôle 2>` : Discussion entre rôles

### Exemples d'utilisation

#### Proposition automatique de rôle

```bash
/smart-review
→ Analyser la situation actuelle et proposer le rôle optimal

/smart-review src/auth/
→ Recommander le rôle security basé sur fichiers liés à l'authentification
```

#### Analyse multi-rôles

```bash
/multi-role security,performance
"Évaluez cette API sous plusieurs perspectives"
→ Analyse intégrée des perspectives sécurité et performance

/role-debate frontend,security
"Discutez l'UX de l'authentification à 2 facteurs"
→ Discussion des perspectives utilisabilité et sécurité
```

#### Quand incertain sur la sélection de rôle

```bash
/role-help "L'API est lente et la sécurité est aussi préoccupante"
→ Proposer l'approche appropriée (multi-rôle ou débat)

/role-help compare frontend,mobile
→ Différences et usage approprié entre rôles frontend et mobile
```

## Remarques

### À propos du comportement des rôles

- Lors du changement de rôles, le **comportement, priorités, méthodes d'analyse et formats de rapport** de Claude deviennent spécialisés
- Chaque rôle priorise l'application de directives officielles et méthodes éprouvées par une approche **Evidence-First**
- Retournez au mode normal avec `default` (la spécialisation de rôle est supprimée)
- Les rôles ne sont effectifs que dans la session actuelle

### Méthodes d'utilisation efficaces

- **Problèmes simples** : Analyse spécialisée suffisante avec un seul rôle
- **Problèmes complexes** : Analyse multi-perspective avec multi-rôle ou role-debate est efficace
- **En cas d'incertitude** : Utilisez smart-review ou role-help
- **Amélioration continue** : Même avec le même rôle, la précision d'analyse s'améliore avec nouvelles preuves et méthodes

### Fonction sous-agent (option --agent)

Pour l'analyse à grande échelle ou le traitement spécialisé indépendant, vous pouvez exécuter un rôle en tant que sous-agent en utilisant l'option `--agent`.

#### Avantages

- **Contexte indépendant** : N'interfère pas avec la conversation principale
- **Exécution parallèle** : Plusieurs analyses peuvent être effectuées simultanément
- **Expertise spécialisée** : Analyse plus approfondie et rapports détaillés
- **Promotion de délégation automatique** : Quand les descriptions de rôle incluent "utiliser PROACTIVEMENT" ou "DOIT ÊTRE UTILISÉ", une délégation automatique plus proactive est activée

#### Scénarios d'usage recommandés

```bash
# Sécurité : Vérification complète OWASP, correspondance CVE
/role security --agent
"Audit de sécurité de l'ensemble de la base de code"

# Analyste : Analyse des causes racines de gros logs
/role analyzer --agent
"Analysez les logs d'erreur de la semaine passée"

# Réviseur : Révision détaillée de grosse PR
/role reviewer --agent
"Révisez les changements de 1000 lignes dans PR #500"
```

#### Rôle normal vs Sous-agent

| Situation | Recommandation | Commande |
|-----------|----------------|----------|
| Confirmation simple | Rôle normal | `/role security` |
| Analyse à grande échelle | Sous-agent | `/role security --agent` |
| Travail interactif | Rôle normal | `/role frontend` |
| Audit indépendant | Sous-agent | `/role qa --agent` |

### Détails de configuration des rôles

- Les paramètres détaillés, expertise et caractéristiques de discussion de chaque rôle sont définis dans le répertoire `.claude/agents/roles/`
- Inclut les méthodes Evidence-First et contre-mesures biais cognitifs
- Le mode spécialisé est automatiquement activé avec des phrases déclencheurs spécifiques au rôle
- Les fichiers de rôles réels consistent en plus de 200 lignes de contenu professionnel
