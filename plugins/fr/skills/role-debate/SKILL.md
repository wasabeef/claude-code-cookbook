---
description: "Débat multi-rôle pour explorer les compromis. Se déclenche avec « débattre entre rôles », « explorer les compromis »."
allowed-tools:
  - Read
  - Grep
---

# Débat multi-rôle pour explorer les compromis

Une commande qui permet aux rôles avec différentes expertises de discuter et examiner les compromis pour dériver des solutions optimales.

## Utilisation

```bash
/role-debate <Rôle 1>,<Rôle 2> [Sujet]
/role-debate <Rôle 1>,<Rôle 2>,<Rôle 3> [Sujet]
```

## Exemples de base

```bash
# Compromis Sécurité vs Performance
/role-debate security,performance
"JWT Token Expiry Setting"

# Équilibre Utilisabilité vs Sécurité
/role-debate frontend,security
"2-Factor Authentication UX Optimization"

# Discussion de sélection technologique
/role-debate architect,mobile
"React Native vs Flutter Selection"

# Débat à trois parties
/role-debate architect,security,performance
"Pros and Cons of Microservices"
```

## Principes de base du débat

### Directives de débat constructif

- **Respect mutuel** : Respecter l'expertise et les perspectives des autres rôles
- **Basé sur les faits** : Débattre basé sur des données et preuves, pas des réactions émotionnelles
- **Orienté solutions** : Viser de meilleures solutions plutôt que critiquer pour critiquer
- **Axé implémentation** : Considérer la faisabilité plutôt que l'idéalisme

### Exigences de qualité pour les arguments

- **Documentation officielle** : Référencer standards, directives et documentation officielle
- **Cas empiriques** : Citations spécifiques de cas de succès ou d'échec
- **Évaluation quantitative** : Comparaisons utilisant nombres et métriques quand possible
- **Considération temporelle** : Évaluation des impacts court, moyen et long termes

### Éthique du débat

- **Honnêteté** : Reconnaître les limites de votre expertise
- **Ouverture** : Flexibilité vers nouvelles informations et perspectives
- **Transparence** : Déclarer explicitement les bases de jugement et hypothèses
- **Responsabilité** : Mentionner les risques d'implémentation des propositions

## Processus de débat

## Phase 1 : Déclaration de position initiale

Chaque rôle exprime indépendamment des opinions depuis leur perspective professionnelle

- Présentation de recommandations
- Citation explicite de standards et documents comme bases
- Explication des risques et questions anticipés
- Définition des métriques de succès

## Phase 2 : Discussion mutuelle et réfutation

Discussion croisée entre rôles

- Réfutation constructive des propositions d'autres rôles
- Identification de perspectives négligées
- Clarification des compromis
- Présentation d'alternatives

## Phase 3 : Recherche de compromis

Exploration de solutions implémentables

- Évaluation de l'importance de chaque perspective
- Considération de solutions gagnant-gagnant
- Approche d'implémentation étape par étape
- Considération de mesures de mitigation des risques

## Phase 4 : Conclusion intégrée

Détermination des recommandations finales

- Solution convenue
- Feuille de route d'implémentation
- Métriques de succès et méthodes de mesure
- Points de révision futurs

## Exemples de format de sortie

## Pour un débat à 2 rôles

```text
Débat de rôles : Sécurité vs Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Sujet : Paramètres d'expiration de token JWT

Argument du rôle Sécurité :
"Expiration courte de 15 minutes recommandée"

Bases :
- Conformité au OWASP JWT Security Cheat Sheet
- Minimiser la fenêtre de dommage en cas de fuite de token
- Limiter le temps disponible pour l'attaquant

Préoccupations :
- Une longue expiration augmente exponentiellement le risque d'attaque
- Expiration courte obligatoire pour conformité financière

Métriques de succès :
- Taux d'incident sécurité < 0,1%
- Temps moyen de détection d'attaque < 5 minutes

Réfutation du rôle Performance :
"Expiration de 2 heures recommandée"

Bases :
- Référence aux Google OAuth 2.0 Best Practices
- Éviter charge serveur accrue par réauthentification fréquente
- Minimiser perturbation expérience utilisateur

Préoccupations :
- Réauthentification 15 minutes augmente charge API de 8x
- Déconnexions fréquentes en environnements mobiles

Métriques de succès :
- Maintenir temps réponse API < 200ms
- Utilisation CPU serveur < 60%

Discussion mutuelle :
Sécurité → Performance :
"Les pertes commerciales des violations de sécurité sont plus importantes que charge serveur.
Exemple : violation Equifax a coûté 700 millions $"

Performance → Sécurité :
"Les deux peuvent être obtenus avec mécanisme refresh token.
Mises à jour arrière-plan assurent sécurité sans compromettre UX"

Sécurité → Performance :
"Les refresh tokens sont aussi cibles d'attaque. Implémentation appropriée est prérequis"

Performance → Sécurité :
"Proposer approche par phases. 30 minutes pour opérations normales, 15 minutes pour opérations sensibles"

Recherche de compromis :
Compréhension commune :
- Besoin d'équilibrer expérience utilisateur et sécurité
- Réponse flexible basée sur niveau de risque
- Considération pratique des coûts d'implémentation et opérationnels

Éléments gagnant-gagnant :
- Utilisation du mécanisme refresh token
- Introduction par phases d'authentification basée sur le risque
- Complémentation avec fonction de déconnexion automatique

Conclusion intégrée :
"Expiration 30 minutes + refresh token + authentification basée sur le risque"

Détails d'implémentation :
1. Access token : expiration 30 minutes
2. Refresh token : expiration 7 jours
3. Opérations haut risque : Forcer réauthentification toutes les 15 minutes
4. Déconnexion automatique après 30 minutes d'inactivité

Implémentation par phases :
Semaines 1-2 : Implémentation token 30 minutes de base
Semaines 3-4 : Ajouter mécanisme refresh token
Mois 2 : Introduire authentification basée sur le risque

Métriques de succès :
- Sécurité : Taux d'incident < 0,1%
- Performance : Augmentation charge API < 20%
- UX : Satisfaction utilisateur > 85%

Révision future :
- Après 3 mois : Évaluer motifs d'attaque réels et conditions de charge
- Après 6 mois : Considérer migration vers authentification basée sur le risque plus sophistiquée
```

## Pour un débat à 3 rôles

```text
Débat de rôles : Architecte vs Sécurité vs Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Sujet : Avantages et inconvénients des microservices

Argument du rôle Architecte :
"Microservices par phases recommandés"
Bases : Limites domaine claires, déploiement indépendant, liberté sélection technologique

Préoccupations du rôle Sécurité :
"Complexité sécurité communication inter-services"
Bases : Coûts gestion API Gateway, mTLS, authentification distribuée

Préoccupations du rôle Performance :
"Augmentation latence due communication réseau"
Bases : Problème N+1 d'appels API internes, transactions distribuées

Discussion à trois parties :
Architecte → Sécurité : "Peut être contrôlé par gestion API Gateway centralisée"
Sécurité → Architecte : "Risque de point de défaillance unique"
Performance → Architecte : "Granularité division service est importante"
...(discussion continue)

Conclusion intégrée :
"Design dirigé par domaine pour division par phases + design sécurité d'abord"
```

## Motifs de débat efficaces

## Sélection technologique

```bash
/role-debate architect,performance
"Database Selection: PostgreSQL vs MongoDB"

/role-debate frontend,mobile
"UI Framework: React vs Vue"

/role-debate security,architect
"Authentication Method: JWT vs Session Cookie"
```

## Décisions de conception

```bash
/role-debate security,frontend
"User Authentication UX Design"

/role-debate performance,mobile
"Data Synchronization Strategy Optimization"

/role-debate architect,qa
"Test Strategy and Architecture Design"
```

## Questions de compromis

```bash
/role-debate security,performance
"Encryption Level vs Processing Speed"

/role-debate frontend,performance
"Rich UI vs Page Loading Speed"

/role-debate mobile,security
"Convenience vs Data Protection Level"
```

## Caractéristiques de débat spécifiques aux rôles

### 🔒 Rôle Sécurité

```yaml
debate_stance:
  - Approche conservatrice (minimisation risques)
  - Axé conformité (prudent quant déviations des standards)
  - Hypothèse pire scénario (perspective attaquant)
  - Focus impact long terme (sécurité comme dette technique)

typical_issues:
  - Compromis "Sécurité vs Commodité"
  - "Exigences conformité obligatoires"
  - "Comparaison coût attaque vs coût défense"
  - "Protection vie privée approfondie"

evidence_sources:
  - Directives OWASP
  - Frameworks NIST
  - Standards industrie (ISO 27001, SOC 2)
  - Cas attaque réels et statistiques

debate_strengths:
  - Précision évaluation risques
  - Connaissance exigences réglementaires
  - Compréhension méthodes attaque

potential_biases:
  - Conservatisme excessif (inhiber innovation)
  - Considération UX insuffisante
  - Minimiser coûts implémentation
```

### ⚡ Rôle Performance

```yaml
debate_stance:
  - Décisions basées données (basé mesures)
  - Axé efficacité (optimiser rapport coût-efficacité)
  - Priorité expérience utilisateur (focus vitesse perçue)
  - Amélioration continue (optimisation par phases)

typical_issues:
  - "Performance vs Sécurité"
  - "ROI coût optimisation vs efficacité"
  - "Scalabilité actuelle vs future"
  - "Expérience utilisateur vs efficacité système"

evidence_sources:
  - Métriques Core Web Vitals
  - Résultats benchmark et statistiques
  - Données impact sur comportement utilisateur
  - Standards performance industrie

debate_strengths:
  - Capacité évaluation quantitative
  - Identification goulots étranglement
  - Connaissance techniques optimisation

potential_biases:
  - Minimiser sécurité
  - Considération maintenabilité insuffisante
  - Optimisation prématurée
```

### 🏗️ Rôle Architecte

```yaml
debate_stance:
  - Perspective long terme (considération évolution système)
  - Recherche équilibre (optimisation globale)
  - Changements par phases (gestion risques)
  - Conformité standards (préférence motifs prouvés)

typical_issues:
  - "Efficacité court terme vs maintenabilité long terme"
  - "Dette technique vs vitesse développement"
  - "Microservices vs monolithe"
  - "Adoption nouvelle technologie vs stabilité"

evidence_sources:
  - Collections motifs architecture
  - Principes conception (SOLID, DDD)
  - Cas systèmes grande échelle
  - Tendances évolution technologique

debate_strengths:
  - Capacité perspective globale
  - Connaissance motifs conception
  - Prédiction impacts long terme

potential_biases:
  - Généralisation excessive
  - Conservatisme envers nouvelles technologies
  - Compréhension insuffisante détails implémentation
```

### 🎨 Rôle Frontend

```yaml
debate_stance:
  - Design centré utilisateur (priorité UX première)
  - Approche inclusive (considération diversité)
  - Focus intuitivité (minimiser coûts apprentissage)
  - Standards accessibilité (conformité WCAG)

typical_issues:
  - "Utilisabilité vs Sécurité"
  - "Cohérence design vs optimisation plateforme"
  - "Fonctionnalité vs simplicité"
  - "Performance vs expérience riche"

evidence_sources:
  - Recherche UX et résultats tests utilisabilité
  - Directives accessibilité
  - Standards système design
  - Données comportement utilisateur

debate_strengths:
  - Représentation perspective utilisateur
  - Connaissance principes design
  - Exigences accessibilité

potential_biases:
  - Compréhension insuffisante contraintes techniques
  - Minimiser exigences sécurité
  - Sous-estimation impact performance
```

### 📱 Rôle Mobile

```yaml
debate_stance:
  - Spécialisation plateforme (considérer différences iOS/Android)
  - Adaptation contexte (mobile, opération une main)
  - Contraintes ressources (batterie, mémoire, communication)
  - Conformité store (directives révision)

typical_issues:
  - "Natif vs cross-platform"
  - "Support hors ligne vs synchronisation temps réel"
  - "Efficacité batterie vs fonctionnalité"
  - "Unification plateforme vs optimisation"

evidence_sources:
  - iOS HIG / Android Material Design
  - Directives App Store / Google Play
  - Recherche UX mobile
  - Statistiques performance appareil

debate_strengths:
  - Compréhension contraintes spécifiques mobile
  - Connaissance différences plateforme
  - Design interface tactile

potential_biases:
  - Compréhension insuffisante plateforme web
  - Minimiser contraintes côté serveur
  - Considération insuffisante environnement desktop
```

### 🔍 Rôle Analyste

```yaml
debate_stance:
  - Axé preuves (données d'abord)
  - Vérification hypothèses (approche scientifique)
  - Pensée structurelle (pensée systémique)
  - Élimination biais (recherche objectivité)

typical_issues:
  - "Corrélation vs causalité"
  - "Traitement symptomatique vs solution racine"
  - "Distinction hypothèse et fait"
  - "Symptômes court terme vs problèmes structurels"

evidence_sources:
  - Données mesurées et analyse journaux
  - Méthodes statistiques et résultats analyse
  - Théorie pensée systémique
  - Recherche biais cognitifs

debate_strengths:
  - Capacité analyse logique
  - Objectivité évaluation preuves
  - Découverte problèmes structurels

potential_biases:
  - Paralysie analyse (action insuffisante)
  - Perfectionnisme (minimiser praticité)
  - Absolutisme données
```

## Modèles de progression de débat

### Phase 1 : Modèle déclaration position

```text
Recommandation du [Nom du rôle] :
"[Proposition spécifique]"

Bases :
- [Référence documents/standards officiels]
- [Cas/données empiriques]
- [Principes domaine professionnel]

Effets attendus :
- [Effets court terme]
- [Effets moyen à long terme]

Préoccupations/Risques :
- [Risques implémentation]
- [Risques opérationnels]
- [Impacts autres domaines]

Métriques de succès :
- [Métrique mesurable 1]
- [Métrique mesurable 2]
```

### Phase 2 : Modèle réfutation

```text
Réfutation à [Rôle cible] :
"[Réfutation spécifique proposition cible]"

Bases réfutation :
- [Perspectives négligées]
- [Preuves/cas contradictoires]
- [Préoccupations domaine professionnel]

Proposition alternative :
"[Proposition améliorée]"

Points compromis :
- [Conditions acceptables]
- [Possibilité implémentation par phases]
```

### Phase 3 : Modèle solution intégrée

```text
Solution intégrée :
"[Proposition finale considérant préoccupations tous rôles]"

Considérations pour chaque rôle :
- [Sécurité] : [Comment exigences sécurité sont satisfaites]
- [Performance] : [Comment exigences performance sont satisfaites]
- [Autres] : [Comment autres exigences sont satisfaites]

Feuille de route implémentation :
- Phase 1 (Immédiat) : [Éléments réponse urgente]
- Phase 2 (Court terme) : [Implémentation de base]
- Phase 3 (Moyen terme) : [Implémentation complète]

Métriques succès et méthodes mesure :
- [Métriques succès intégrées]
- [Méthodes/fréquence mesure]
- [Timing révision]
```

## Liste de vérification qualité débat

### Qualité preuves

- [ ] Références documents/standards officiels
- [ ] Cas/données spécifiques présentés
- [ ] Distinction spéculation et fait
- [ ] Sources explicitement déclarées

### Constructivité débat

- [ ] Compréhension précise propositions adversaire
- [ ] Réfutation logique plutôt qu'émotionnelle
- [ ] Alternatives aussi présentées
- [ ] Exploration possibilités gagnant-gagnant

### Faisabilité implémentation

- [ ] Faisabilité technique considérée
- [ ] Coûts/durée implémentation estimés
- [ ] Possibilité implémentation par phases considérée
- [ ] Mesures mitigation risques présentées

### Intégration

- [ ] Impacts autres domaines considérés
- [ ] Recherche optimisation globale
- [ ] Perspective long terme incluse
- [ ] Métriques succès mesurables définies

## Collaboration avec Claude

```bash
# Débat basé sur documents conception
cat system-design.md
/role-debate architect,security
"Discuss security issues in this design"

# Débat solutions basé sur problèmes
cat performance-issues.md
/role-debate performance,architect
"Discuss fundamental solutions to performance issues"

# Débat sélection technologique basé sur exigences
/role-debate mobile,frontend
"Discuss unified UI strategy for iOS, Android, and Web"
```

## Notes

- Les débats peuvent prendre du temps (plus long pour sujets complexes)
- Avec 3+ rôles, discussions peuvent diverger
- Décisions finales devraient être prises par utilisateurs référençant résultats débat
- Pour questions urgentes, considérer rôle unique ou multi-rôle d'abord
