## Spec

**"Donner de la structure avant d'écrire le code"** - Entièrement conforme au développement piloté par spécifications de Kiro

Contrairement aux outils traditionnels de génération de code, il réalise le développement piloté par spécifications de Kiro focalisé sur l'apport de structure au chaos du développement. À partir d'une saisie minimale d'exigences, il se développe progressivement des spécifications détaillées de niveau product manager à des conceptions implémentables, assurant une qualité cohérente du **prototype à la production**.

### Utilisation

```bash
# Demander le Mode Spec à Claude (saisie minimale d'exigences)
"Créez un spec pour [description de fonctionnalité]"

# Développement étape par étape de Kiro :
# 1. Exigences simples → Génération automatique de user stories détaillées
# 2. Descriptions d'exigences structurées utilisant la notation EARS
# 3. Raffinement des spécifications par dialogue étape par étape
# 4. Génération de 3 fichiers indépendants :
#    - requirements.md : Définitions d'exigences utilisant la notation EARS
#    - design.md : Conception incluant diagrammes Mermaid et interfaces TypeScript
#    - tasks.md : Plan d'implémentation avec application automatique des bonnes pratiques
```

### Résultats éprouvés (Historique de Kiro)

**Application de partage de fichiers sécurisée en 2 jours**

```bash
"Créez un spec pour un système de partage de fichiers (avec chiffrement)"
→ Application de partage de fichiers chiffrés de niveau production terminée en 2 jours
→ Application automatique des bonnes pratiques de sécurité
→ Aucune invite supplémentaire nécessaire
```

**Développement de jeu en une nuit (Pour débutants)**

```bash
"Créez un spec pour un jeu de puzzle 2D"
→ Développeur open source sans expérience en développement de jeu
→ Jeu terminé en une nuit
→ Kiro gère la logique d'implémentation, permettant aux développeurs de se concentrer sur la créativité
```

**Prototype weekend→Production**

```bash
"Créez un spec pour un système de gestion de produits de site e-commerce"
→ Du concept au prototype fonctionnel en un weekend
→ Qualité cohérente du prototype à la production
→ Approche structurée par développement piloté par spécifications
```

### Exemples de base

```bash
# Créer un spec pour une nouvelle fonctionnalité (saisie minimale)
"Système d'avis produits
- Fonctionnalité de notation par étoiles
- Publication de commentaires
- Upload d'images"

# Créer un spec pour une fonctionnalité système
"Authentification utilisateur
- Support OAuth
- Authentification multi-facteurs"

# Créer un spec pour une fonctionnalité API
"API système de paiement
- Intégration Stripe
- Focus sécurité"
```

### Collaboration avec Claude

```bash
# Spec de fonctionnalité complexe
"Créez un spec pour la fonctionnalité de chat incluant WebSocket, notifications temps réel et gestion d'historique"

# Spec de fonctionnalité d'intégration base de données
"Créez un spec pour la fonctionnalité de gestion d'inventaire de site e-commerce incluant ajout de produits, mises à jour d'inventaire et fonctionnalité d'alerte"

# Spec de fonctionnalité frontend
"Créez un spec pour un tableau de bord React incluant affichage de graphiques, filtrage et fonctionnalité d'export"

# Spec de fonctionnalité backend
"Créez un spec pour une API RESTful incluant authentification, validation et journalisation"
```

### Fonctionnalités du Mode Spec

**Flux de dialogue étape par étape**

- Reproduit entièrement la valeur originale de Kiro de discussion étape par étape
- Raffine les spécifications de manière collaborative avec les utilisateurs à chaque phase
- Génère des fichiers par résolution de questions, discussion d'options et processus d'approbation

**Trois phases de développement interactif**

- **Phase 1** : Découverte d'exigences → Discussion → Approbation → génération `requirements.md`
- **Phase 2** : Exploration de conception → Discussion → Approbation → génération `design.md`
- **Phase 3** : Planification d'implémentation → Discussion → Approbation → génération `tasks.md`

**Développement de spécification dynamique**

- Résout les ambiguïtés d'exigences par le dialogue
- Présente et discute les options techniques
- Explique les compromis et confirme les décisions

### Exemples détaillés

```bash
# Fonctionnalité système complexe
"Créez un spec pour un système de paiement en ligne incluant intégration Stripe, sécurité et gestion d'erreurs"

# Fonctionnalité frontend
"Créez un spec pour un composant React incluant gestion d'état, conception de propriétés et tests"

# Fonctionnalité backend
"Créez un spec pour une API GraphQL incluant conception de schéma, resolvers et authentification"

# Fonctionnalité DevOps
"Créez un spec pour un pipeline CI/CD incluant automatisation de tests, déploiement et surveillance"
```

### Flux de dialogue phase par phase

#### Phase 1 : Découverte et discussion des exigences

**1. Expansion automatique à partir de saisie minimale (Style Kiro)**

```
Utilisateur : "Système de gestion d'utilisateurs
- Fonctionnalité de connexion
- Édition de profil
- Permissions administrateur"

Claude : "Je vais générer des user stories détaillées à partir de vos exigences.
Cette compréhension est-elle correcte ?

User stories générées automatiquement :
- Inscription et authentification utilisateur (compatible OAuth)
- Gestion de profil (avatar, paramètres)
- Gestion des permissions (RBAC)
- Fonctionnalité de réinitialisation de mot de passe
- Journaux d'audit de sécurité

J'ai ajouté quelques détails que vous n'avez pas mentionnés. Autre chose nécessaire ?"
```

**2. Description d'exigences structurées utilisant la notation EARS**

```
Claude : "Laissez-moi structurer ceci en utilisant la notation EARS :

Voici les exigences au format EARS :

WHEN un utilisateur tente de se connecter
GIVEN il saisit la bonne adresse email et mot de passe
THEN le système shall confirmer l'authentification
AND rediriger vers le tableau de bord en cas de succès

WHILE un utilisateur est sur l'écran d'édition de profil
THE SYSTEM SHALL effectuer une validation temps réel
AND afficher un aperçu des changements

WHERE l'accès est tenté à une fonctionnalité nécessitant des privilèges administrateur
IS when le système shall vérifier les niveaux de permission
AND refuser l'accès si insuffisant"
```

**3. Complétion automatique des cas limites et exigences de sécurité**

```
Claude : "Suivant les bonnes pratiques, j'ai aussi pensé à ceci :

Exigences de sécurité (auto-ajoutées) :
- Protection force brute
- Gestion de session et timeouts
- Protection CSRF et XSS
- Règles de force de mot de passe

Cas limites (auto-détectés) :
- Gestion de connexions multiples
- Verrouillage de compte
- Cohérence des données pendant migration
- Gestion trafic élevé

Cela vous semble-t-il correct ?"
```

**5. Complétion et approbation Phase 1**

```
Claude : "Phase exigences terminée.
Dois-je créer requirements.md ?"
→ "Oui" → génère requirements.md
```

#### Phase 2 : Exploration et discussion de conception

**1. Analyse de base de code + Proposition de conception automatique (Style Kiro)**

```
Claude : "Après analyse de votre base de code, voici mon architecture recommandée :

Résultats d'analyse de base de code :
- Authentification : JWT + Express.js (v4.18.x)
- Base de données : PostgreSQL (v14+)
- Frontend : React + TypeScript (v18+)
- Patterns existants : Pattern Repository, séparation couche service

Architecture recommandée Kiro :
- Conforme Clean Architecture
- Éléments Domain-Driven Design
- Application partielle pattern CQRS
- Bonnes pratiques de sécurité automatisées

Devons-nous procéder avec cette conception ?"
```

**2. Conception visuelle avec diagrammes Mermaid**

````
Claude : "J'ai automatiquement généré une conception système utilisant les diagrammes Mermaid :

Diagramme d'architecture généré automatiquement :

```text
graph TB
    Client[Client React] --> API[Express API Gateway]
    API --> Auth[Service Auth]
    API --> User[Service Utilisateur]
    API --> Profile[Service Profil]

    Auth --> AuthDB[(Base Auth)]
    User --> UserDB[(Base Utilisateur)]
    Profile --> ProfileDB[(Base Profil)]

    Auth --> JWT[Service JWT]
    Auth --> OAuth[Fournisseur OAuth]
````

Dois-je également générer un diagramme de flux de données ?"

```

**3. Génération automatique d'interfaces TypeScript**

```

Claude : "Je vais automatiquement générer les interfaces TypeScript basées sur la conception :

Interfaces TypeScript générées automatiquement :

```text
// Entités de domaine
interface User {
  readonly id: UserId;
  readonly email: Email;
  readonly profile: UserProfile;
  readonly auth: AuthSettings;
  readonly permissions: Permission[];
  readonly createdAt: Date;
  readonly updatedAt: Date;
}

interface UserProfile {
  readonly displayName: string;
  readonly avatar: AvatarUrl;
  readonly preferences: UserPreferences;
}

interface AuthSettings {
  readonly passwordHash: PasswordHash;
  readonly mfaEnabled: boolean;
  readonly lastLoginAt: Date;
  readonly failedAttempts: number;
}

// Cas d'usage
interface UserRepository {
  findById(id: UserId): Promise<User | null>;
  findByEmail(email: Email): Promise<User | null>;
  save(user: User): Promise<void>;
}

interface AuthenticationService {
  authenticate(credentials: LoginCredentials): Promise<AuthResult>;
  refreshToken(token: RefreshToken): Promise<AccessToken>;
}
```

Devons-nous procéder avec cette conception d'interface ?"

```

**4. Complétion et approbation Phase 2**
```

Claude : "La Phase de Conception est terminée.
Puis-je générer design.md ?"
→ "Procéder" → génération design.md

```

#### Phase 3 : Planification et discussion d'implémentation

**1. Application automatique des bonnes pratiques (Style Kiro)**
```

Claude : "J'ai généré un plan d'implémentation avec application automatique des bonnes pratiques de Kiro :

Stratégie d'implémentation générée automatiquement :

1. Développement sécurité-d'abord
   - Incorporation automatique des contre-mesures OWASP Top 10
   - Implémentation automatique du chiffrement et hachage
   - Génération automatique de tests de sécurité

2. Enforcement d'architecture propre
   - Implémentation automatique de séparation de couches
   - Application automatique d'inversion de dépendance
   - Enforcement de conception testable

3. Optimisation performance
   - Implémentation automatique de stratégie de cache
   - Optimisation base de données
   - Utilisation du traitement asynchrone

Devons-nous procéder avec cette approche ?"

```

**2. Paramétrage automatique de points de contrôle qualité**
```

Claude : "J'ai automatiquement défini des points de contrôle qualité pour chaque phase d'implémentation :

Processus d'assurance qualité automatique :

Phase 3a : Implémentation backend

- [ ] Scan sécurité (SAST/DAST)
- [ ] Test spécification API (conforme OpenAPI)
- [ ] Test performance (charge/réponse)
- [ ] Scan vulnérabilités (dépendances/CVE)

Phase 3b : Implémentation frontend

- [ ] Test accessibilité (WCAG 2.1 AA)
- [ ] Test compatibilité navigateur
- [ ] Vérification design responsive
- [ ] Confirmation headers sécurité

Phase 3c : Intégration/Déploiement

- [ ] Suite de tests E2E
- [ ] Configuration pipeline CI/CD
- [ ] Configuration surveillance/journalisation
- [ ] Audit sécurité environnement production

Tous seront exécutés automatiquement. Y a-t-il des standards qualité supplémentaires ?"

```

**3. Analyse automatique des dépendances et atténuation des risques**
```

Claude : "J'ai automatiquement analysé l'ordre d'implémentation et les mesures d'atténuation des risques :

Ordre d'implémentation optimisé :

Semaine 1 : Infrastructure et fondation sécurité

- Conception base de données et création schéma
- Fondation authentification (JWT + gestion session)
- Implémentation middleware sécurité
- Points terminaison API de base

Semaine 2 : Implémentation fonctionnalité centrale

- Fonctionnalité gestion utilisateurs
- Fonctionnalité gestion profil
- Système gestion permissions
- Validation et gestion d'erreurs

Semaine 3 : Fonctionnalités avancées et optimisation

- Implémentation authentification multi-facteurs
- Fonctionnalité journaux d'audit
- Optimisation performance
- Intégration frontend

Mesures d'atténuation des risques automatiquement détectées :

- Authentification multi-facteurs : Déploiement graduel (SMS→authentification app)
- Gestion session : Configuration cluster Redis
- Trafic élevé : Limitation débit + utilisation CDN
- Cohérence données : Gestion transaction renforcée

Ce plan est-il acceptable ?"

```

**4. Complétion et approbation Phase 3**
```

Claude : "La Phase de Planification d'Implémentation est terminée.
Puis-je générer tasks.md ?"
→ "Procéder" → génération tasks.md

````

### Fonctionnalités spécifiques à Kiro

**Notation EARS (Easy Approach to Requirements Syntax)**

```text
# Patterns de notation EARS standard Kiro

WHEN [situation/déclencheur]
GIVEN [précondition]
THEN [comportement système]
AND [comportement supplémentaire]

WHILE [état/processus]
THE SYSTEM SHALL [comportement obligatoire]
AND [comportement lié]

WHERE [fonction/composant]
IS [condition/état]
THE SYSTEM SHALL [comportement correspondant]
````

**Fonctionnalités de génération automatique**

- **Diagrammes Mermaid** : Génération automatique de diagrammes d'architecture et flux de données
- **Interfaces TypeScript** : Création automatique de définitions de types basées sur conception
- **Bonnes pratiques** : Incorporation automatique de mesures sécurité et performance
- **Points contrôle qualité** : Définition automatique de standards qualité spécifiques aux phases

**Intégration Hooks**

- Vérifications qualité automatiques à la sauvegarde fichier
- Application automatique de standards de code
- Exécution automatique de scans sécurité
- Vérification automatique des contre-mesures OWASP Top 10

**Assurance qualité Prototype→Production**

- Conception cohérente par approche structurée
- Enforcement du développement sécurité-d'abord
- Application automatique d'architecture évolutive
- Intégration de gestion qualité continue

### Remarques

**Portée d'application**

- Le Mode Spec est optimisé pour l'implémentation de fonctionnalités
- Utilisez le format d'implémentation normal pour corrections simples ou petites modifications
- Recommandé pour développement nouvelles fonctionnalités ou modifications complexes

**Assurance qualité**

- Clarification des critères de complétion à chaque étape
- Révision conception avant implémentation
- Standards qualité complets incluant tests et accessibilité

**Notes opérationnelles**

- Résoudre ambiguïtés exigences avant phase conception
- Générer tâches implémentation après complétion conception
- Mettre l'accent sur processus approbation à chaque étape

### Phrases déclencheuses et contrôles

#### Contrôle flux de travail étape par étape

**Déclencheurs de démarrage**

- "Créez un spec pour [nom fonctionnalité]"
- "Je veux développer [nom fonctionnalité] en utilisant développement piloté par spécifications"
- "Concevez [nom fonctionnalité] à partir de spécifications"

**Contrôle progression phase**

- **"Procéder"** : Compléter phase actuelle, générer fichier, passer à phase suivante
- **"Réviser"** : Ajuster ou améliorer contenu dans phase actuelle
- **"Redémarrer"** : Redémarrer phase actuelle depuis le début
- **"Expliquer en détail"** : Fournir explications plus détaillées ou options
- **"Ignorer"** : Ignorer phase actuelle et passer à suivante (non recommandé)

**Timing génération fichier**

```
Complétion Phase 1 → "Procéder" → génération requirements.md
Complétion Phase 2 → "Procéder" → génération design.md
Complétion Phase 3 → "Procéder" → génération tasks.md
```

### Exemple d'exécution (Flux étape par étape)

```bash
# Exemple d'usage
Utilisateur : "Créez un spec pour un système de gestion d'utilisateurs"

# Phase 1 : Découverte exigences
Claude : [Commence confirmation et discussion exigences]
Utilisateur : [Répond, discute, fait révisions]
Claude : "La Phase Exigences est terminée. Puis-je procéder ?"
Utilisateur : "Procéder"
→ génération requirements.md

# Phase 2 : Exploration conception
Claude : [Commence proposition et discussion conception]
Utilisateur : [Discute sélection technologie et architecture]
Claude : "La Phase Conception est terminée. Puis-je procéder ?"
Utilisateur : "Procéder"
→ génération design.md

# Phase 3 : Planification implémentation
Claude : [Commence discussion plan implémentation]
Utilisateur : [Discute priorités, risques et effort]
Claude : "La Phase Implémentation est terminée. Puis-je procéder ?"
Utilisateur : "Procéder"
→ génération tasks.md

# Complétion
Claude : "La préparation du développement piloté par spécifications est terminée. Vous pouvez commencer l'implémentation."
```

### Différences avec /plan

| Fonctionnalité       | /plan                           | /spec                                                           |
| -------------------- | ------------------------------- | --------------------------------------------------------------- |
| Cible                | Plan d'implémentation général   | Développement piloté par spécifications de fonctionnalité       |
| Format de sortie     | Document de plan unique         | 3 fichiers indépendants (requirements.md, design.md, tasks.md)  |
| Définition exigences | Organisation exigences de base  | Critères d'acceptation détaillés utilisant notation EARS        |
| Conception           | Focalisée sélection technologie | Basée analyse base de code                                      |
| Implémentation       | Décomposition tâches générale   | Séquence consciente dépendances                                 |
| Assurance qualité    | Stratégie test de base          | Exigences qualité complètes (tests, accessibilité, performance) |
| Synchronisation      | Plan statique                   | Mises à jour spec dynamiques                                    |

### Cas d'usage recommandés

**Recommandé pour usage spec**

- Développement nouvelles fonctionnalités
- Modifications fonctionnalités complexes
- Conception API
- Conception base de données
- Implémentation UI/UX

**Recommandé pour usage plan**

- Conception système globale
- Construction infrastructure
- Refactorisation
- Sélection technologie
- Changements architecture
