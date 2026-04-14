# Claude Code Cookbook

[🏠 Home](../../README.md) | [🇺🇸 English](../en/README.md) | [🇯🇵 日本語](../ja/README.md) | [🇰🇷 한국어](../ko/README.md) | [🇨🇳 简体中文](../zh-cn/README.md) | [🇹🇼 繁體中文](../zh-tw/README.md) | [🇪🇸 Español](../es/README.md) | [🇫🇷 Français](../fr/README.md) | [🇧🇷 Português](../pt/README.md)

Une collection de configurations pour utiliser Claude Code plus efficacement.

En supprimant les confirmations détaillées et en automatisant les tâches, vous pouvez vous concentrer sur l'essentiel. Claude Code évalue et exécute les tâches courantes comme la correction de code, l'exécution de tests et la mise à jour de la documentation.

## Fonctionnalités principales

Vous pouvez personnaliser le comportement de Claude Code grâce à trois fonctionnalités :

- **Commands** : Commandes personnalisées commençant par `/`
- **Roles** : Configuration de rôles pour répondre du point de vue d'experts
- **Hooks** : Exécution automatique de scripts à des moments spécifiques

---

## Liste des fonctionnalités

### Commands (Commandes personnalisées)

Stockées sous forme de fichiers Markdown dans le répertoire `/commands`. Vous les exécutez en saisissant `/` suivi du nom du fichier.

| Commande                | Description                                                                                                                                   |
| :---------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------- |
| `/analyze-dependencies` | Analyser les dépendances du projet et visualiser les dépendances cycliques et problèmes structurels.                                          |
| `/analyze-performance`  | Analyser les problèmes de performance de l'application et proposer des améliorations du point de vue de la dette technique.                   |
| `/check-fact`           | Vérifier l'exactitude des informations données en référençant le codebase et la documentation du projet.                                      |
| `/pr-checks`      | Surveiller l'état CI des GitHub Actions et suivre jusqu'à la completion.                                                                      |
| `/check-prompt`         | Réviser le contenu du prompt actuel et présenter des propositions d'amélioration.                                                             |
| `/commit-message`       | Générer uniquement des messages de commit basés sur le contenu des modifications.                                                             |
| `/context7`             | Effectuer la gestion de contexte en utilisant Context7 MCP.                                                                                   |
| `/design-patterns`      | Proposer et réviser des implémentations basées sur les design patterns.                                                                       |
| `/explain-code`         | Expliquer clairement les fonctions et la logique du code sélectionné.                                                                         |
| `/fix-error`            | Présenter des propositions de correction du code basées sur les messages d'erreur.                                                            |
| `/multi-role`           | Combiner plusieurs rôles pour analyser en parallèle le même sujet et générer un rapport intégré.                                              |
| `/plan`                 | Lancer le mode de planification avant implémentation et élaborer une stratégie d'implémentation détaillée.                                    |
| `/pr-auto-update`       | Mettre à jour automatiquement le contenu des Pull Request (description, labels).                                                              |
| `/pr-create`            | Réaliser un workflow de Pull Request efficace avec la création automatique de PR basée sur l'analyse des changements Git.                     |
| `/pr-fix`          | Répondre efficacement aux commentaires de révision des Pull Request et résoudre à la racine avec une approche d'analyse d'erreur en 3 étapes. |
| `/pr-issue`             | Afficher la liste des Issues ouvertes du dépôt actuel avec priorisation.                                                                      |
| `/pr-list`              | Afficher la liste des PR ouvertes du dépôt actuel avec priorisation.                                                                          |
| `/pr-review`            | Assurer la qualité du code et la santé architecturale avec une révision systématique des Pull Request.                                        |
| `/refactor`             | Effectuer une refactorisation de code sûre et progressive et évaluer la conformité aux principes SOLID.                                       |
| `/role-debate`          | Faire débattre plusieurs rôles sur un thème spécifique.                                                                                       |
| `/role-help`            | Afficher la liste et les descriptions des Roles disponibles.                                                                                  |
| `/role`                 | Se comporter comme le rôle spécifié.                                                                                                          |
| `/screenshot`           | Prendre et analyser des captures d'écran                                                                                                      |
| `/search-gemini`        | Effectuer une recherche Web en utilisant Gemini.                                                                                              |
| `/semantic-commit`      | Diviser les grands changements en unités minimales significatives et les commiter séquentiellement avec des messages de commit sémantiques.   |
| `/sequential-thinking`  | Utiliser Sequential Thinking MCP pour réfléchir progressivement étape par étape à des problèmes complexes et tirer des conclusions.           |
| `/show-plan`            | Afficher le plan d'exécution actuel.                                                                                                          |
| `/smart-review`         | Effectuer une révision avancée et améliorer la qualité du code.                                                                               |
| `/spec`                 | Créer progressivement des spécifications détaillées conformes au spec-driven development de Kiro à partir des exigences.                      |
| `/style-ai-writing`     | Détecter et corriger les textes non naturels générés par l'IA.                                                                                |
| `/task`                 | Lancer un agent dédié pour exécuter de façon autonome des tâches complexes de recherche, enquête et analyse.                                  |
| `/tech-debt`            | Analyser la dette technique du projet et créer un plan d'amélioration priorisé.                                                               |
| `/ultrathink`           | Exécuter un processus de réflexion progressif et structuré pour des défis complexes et des décisions importantes.                             |
| `/update-dart-doc`      | Gérer systématiquement les commentaires DartDoc des fichiers Dart et maintenir une documentation française de haute qualité.                  |
| `/update-doc-string`    | Gérer et mettre à jour de façon unifiée les chaînes de documentation multilingues.                                                            |
| `/update-flutter-deps`  | Mettre à jour en sécurité les dépendances des projets Flutter.                                                                                |
| `/update-node-deps`     | Mettre à jour en sécurité les dépendances des projets Node.js.                                                                                |
| `/update-rust-deps`     | Mettre à jour en sécurité les dépendances des projets Rust.                                                                                   |

### Roles (Configuration de rôles)

Définis par des fichiers Markdown dans le répertoire `agents/roles/`. Ils permettent à Claude d'avoir le point de vue d'experts pour obtenir des réponses plus précises.

Chaque rôle peut également **s'exécuter de façon indépendante comme sous-agent**. En utilisant l'option `--agent`, vous pouvez exécuter en parallèle des analyses à grande échelle ou des traitements spécialisés sans perturber le contexte de conversation principal.

| Rôle                | Description                                                                                                                                      |
| :------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------- |
| `/role analyzer`    | En tant qu'expert d'analyse système, analyser le code ou l'architecture.                                                                         |
| `/role architect`   | En tant qu'architecte logiciel, effectuer des révisions et propositions liées à la conception.                                                   |
| `/role backend`     | En tant qu'expert en développement backend, conseiller sur la conception d'API, les microservices, le cloud-native et l'architecture serverless. |
| `/role frontend`    | En tant qu'expert frontend, donner des conseils sur UI/UX et les performances.                                                                   |
| `/role mobile`      | En tant qu'expert en développement d'applications mobiles, répondre basé sur les meilleures pratiques iOS/Android.                               |
| `/role performance` | En tant qu'expert en optimisation de performance, proposer des améliorations de vitesse et d'utilisation mémoire.                                |
| `/role qa`          | En tant qu'ingénieur QA, réviser du point de vue des plans de test et de l'assurance qualité.                                                    |
| `/role reviewer`    | En tant que réviseur de code, évaluer le code du point de vue de la lisibilité et de la maintenabilité.                                          |
| `/role security`    | En tant qu'expert en sécurité, pointer les vulnérabilités et risques de sécurité.                                                                |

#### Exemples d'exécution de sous-agent

```bash
# Mode normal (exécution dans le contexte principal)
/cook-fr:role security
« Vérification de sécurité de ce projet »

# Mode sous-agent (exécution dans un contexte indépendant)
/cook-fr:role security --agent
« Exécuter un audit de sécurité complet du projet »

# Analyse parallèle de multiples rôles
/cook-fr:multi-role security,performance --agent
« Analyser de façon globale la sécurité et les performances de tout le système »
```

### Hooks (Scripts d'automatisation)

Configurés dans `settings.json`, ils permettent d'automatiser le travail de développement.

| Script d'exécution             | Événement                    | Description                                                                                                                              |
| :----------------------------- | :--------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| `preserve-file-permissions.sh` | `PreToolUse` / `PostToolUse` | Sauvegarder les permissions originales avant édition de fichier et les restaurer après. Empêcher Claude Code de changer les permissions. |

---

## Guide de flux de développement et d'utilisation des commandes

### Exemple d'utilisation des commandes dans un flux de développement général

```mermaid
flowchart TB
    Start([Vérification des tâches]) --> PRList["/cook-fr:pr-list<br/>Liste des PR ouvertes"]
    Start --> PRIssue["/cook-fr:pr-issue<br/>Liste des Issues ouvertes"]

    PRList --> TaskType{Type ?}
    PRIssue --> TaskType

    TaskType -->|Nouvelle fonctionnalité| Plan["/cook-fr:spec<br/>Définition des exigences ・Conception"]
    TaskType -->|Correction de bug| Fix["/cook-fr:fix-error<br/>Analyse d'erreur"]
    TaskType -->|Refactorisation| Refactor["/cook-fr:refactor<br/>Amélioration"]
    TaskType -->|Révision| Review["/cook-fr:pr-review<br/>Révision"]

    Plan --> Design["/cook-fr:role architect<br/>/cook-fr:role-debate<br/>Consultation de conception"]
    Design --> Implementation[Implémentation ・Tests]
    Fix --> Implementation
    Refactor --> Implementation
    Review --> Implementation

    Implementation --> Check["/cook-fr:smart-review<br/>Vérification de qualité"]
    Check --> Commit["/cook-fr:semantic-commit<br/>Commit par unité d'objectif"]
    Commit --> PR["/cook-fr:pr-create<br/>Création automatique de PR"]
    PR --> CI["/cook-fr:pr-checks<br/>Vérification de l'état CI"]

    CI --> Status{Problème ?}
    Status -->|Oui| Feedback["Réponse de correction<br/>/cook-fr:pr-fix<br/>/cook-fr:fix-error"]
    Status -->|Non| End([Terminé])

    Feedback --> Implementation

    classDef commandBox fill:#e0f2fe,stroke:#0369a1,stroke-width:2px,rx:5,ry:5,color:#0c4a6e
    classDef processBox fill:#f0f9ff,stroke:#0ea5e9,stroke-width:1px,rx:5,ry:5,color:#075985
    classDef decisionBox fill:#fef3c7,stroke:#f59e0b,stroke-width:2px,rx:5,ry:5,color:#78350f
    classDef startEnd fill:#86efac,stroke:#22c55e,stroke-width:2px,rx:20,ry:20,color:#14532d

    class PRList,PRIssue,Plan,Fix,Refactor,Review,Design,Check,CI,Commit,PR,Feedback commandBox
    class Implementation processBox
    class TaskType,Status decisionBox
    class Start,End startEnd

    %%{init: {'theme':'base', 'themeVariables': { 'primaryColor':'#e0f2fe', 'primaryTextColor':'#0c4a6e', 'primaryBorderColor':'#0369a1', 'lineColor':'#64748b', 'secondaryColor':'#f0f9ff', 'background':'#ffffff', 'mainBkg':'#ffffff', 'fontSize': '14px'}}}%%
```

---

## Installation

### Étape 1 : Ajouter le Marketplace

Tout d'abord, ajoutez ce dépôt en tant que marketplace de plugins :

```bash
/plugin marketplace add wasabeef/claude-code-cookbook
```

### Étape 2 : Installer le Plugin Français

Ensuite, installez le plugin en version française :

```bash
/plugin install cook-fr@claude-code-cookbook
```

Cette commande installe la version française des Commands et Roles.

### Utilisation

Après l'installation, les commandes et agents sont appelés avec le préfixe `cook-fr:`:

#### Exécution des Commandes

```bash
# Exécuter avec préfixe
/cook-fr:check-fact

# Utiliser la complétion automatique
/cook-fr:
```

#### Appel des Agents

```bash
# Rechercher des agents commençant par @
@agent-cook-fr:frontend

# Peut également être utilisé via la commande role
/cook-fr:role frontend
```

**Remarque**: Le nom du plugin est automatiquement ajouté comme préfixe. Cela évite les conflits de noms lorsque plusieurs plugins de langue sont installés simultanément.

### Personnalisation

- **Ajout de commandes** : Il suffit d'ajouter un fichier `.md` dans `commands/`
- **Ajout de rôles** : Il suffit d'ajouter un fichier `.md` dans `agents/roles/`
- **Édition des Hooks** : Vous pouvez modifier les traitements d'automatisation en éditant `settings.json`
