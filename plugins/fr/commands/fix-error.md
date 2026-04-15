# Identifier la cause racine et suggérer des solutions

Identifie la cause racine du message d'erreur, prédit le temps de résolution et propose des solutions éprouvées. Apprend les modèles d'erreurs similaires et présente immédiatement la solution appropriée.

## Utilisation

```bash
/fix-error [options]
```

## Options

- Aucune : Analyse d'erreur standard
- `--deep` : Mode d'analyse approfondie (inclut les dépendances et facteurs environnementaux)
- `--preventive` : Analyse axée sur les mesures préventives
- `--quick` : Présente uniquement les corrections applicables immédiatement

## Exemples de Base

```bash
# Analyse d'erreur standard
npm run build 2>&1
/fix-error
「Analyser l'erreur de compilation et présenter la méthode de correction」

# Mode d'analyse approfondie
python app.py 2>&1
/fix-error --deep
「Analyser la cause racine de l'erreur y compris les facteurs environnementaux」

# Focus sur la correction immédiate
cargo test 2>&1
/fix-error --quick
「Présenter la méthode de correction applicable immédiatement」

# Focus sur les mesures préventives
./app 2>&1 | tail -50
/fix-error --preventive
「Présenter la correction de l'erreur et les mesures préventives futures」
```

## Collaboration avec Claude

```bash
# Analyse de log d'erreur
cat error.log
/fix-error
「Identifier la cause racine de l'erreur et proposer la méthode de correction」

# Résolution d'échec de test
npm test 2>&1
/fix-error --quick
「Analyser le test échoué et présenter une proposition de correction applicable immédiatement」

# Analyse de stack trace
python script.py 2>&1
/fix-error --deep
「Identifier l'emplacement du problème à partir de cette stack trace et analyser y compris les facteurs environnementaux」

# Résoudre plusieurs erreurs ensemble
grep -E "ERROR|WARN" app.log | tail -20
/fix-error
「Classer ces erreurs et avertissements par priorité et proposer la méthode de résolution pour chacun」
```

## Prédiction du Temps de Résolution d'Erreur

```text
🚀 Correction immédiate (dans les 5 minutes)
├─ Fautes de frappe, imports oubliés
├─ Variables d'environnement non configurées
├─ Référence de variables non définies
└─ Temps prédit : 2-5 minutes

⚡ Correction rapide (dans les 30 minutes)
├─ Incohérence des dépendances
├─ Erreur de fichier de configuration
├─ Discordance de types
└─ Temps prédit : 10-30 minutes

🔧 Investigation nécessaire (dans les 2 heures)
├─ Erreur de logique complexe
├─ Conflit de traitement asynchrone
├─ Problème d'intégration API
└─ Temps prédit : 30 minutes-2 heures

🔬 Analyse approfondie (demi-journée ou plus)
├─ Originaire de l'architecture
├─ Collaboration de multiples systèmes
├─ Dégradation des performances
└─ Temps prédit : 4 heures-plusieurs jours
```

## Base de Données de Modèles d'Erreurs Similaires

```text
Erreurs fréquentes et solutions immédiates
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 "Cannot read property 'X' of undefined/null" (fréquence : extrêmement élevée)
├─ Cause principale : Manque de vérification null de l'objet
├─ Temps de résolution : 5-10 minutes
└─ Solution : Ajouter optional chaining (?.) ou vérification null

📊 "ECONNREFUSED" / "ENOTFOUND" (fréquence : élevée)
├─ Cause principale : Service non démarré ou erreur de configuration URL
├─ Temps de résolution : 5-15 minutes
└─ Solution : Confirmer le démarrage du service, vérifier les variables d'environnement

📊 "Module not found" / "Cannot resolve" (fréquence : élevée)
├─ Cause principale : Package non installé, erreur de spécification de chemin
├─ Temps de résolution : 2-5 minutes
└─ Solution : Exécuter npm install, vérifier le chemin relatif

📊 "Unexpected token" / "SyntaxError" (fréquence : moyenne)
├─ Cause principale : Discordance des parenthèses/guillemets, utilisation de mot réservé
├─ Temps de résolution : 2-10 minutes
└─ Solution : Vérifier le syntax highlighting, exécuter Linter

📊 "CORS policy" / "Access-Control-Allow-Origin" (fréquence : moyenne)
├─ Cause principale : Manque de configuration CORS côté serveur
├─ Temps de résolution : 15-30 minutes
└─ Solution : Configuration CORS du serveur, configuration proxy

📊 "Maximum call stack size exceeded" (fréquence : faible)
├─ Cause principale : Boucle infinie/récursion, référence circulaire
├─ Temps de résolution : 30 minutes-2 heures
└─ Solution : Vérifier la condition de terminaison de récursion, résoudre la référence circulaire
```

## Matrice de Priorité d'Analyse d'Erreur

| Priorité          | Icône                | Portée d'Impact | Difficulté de Résolution | Délai de Réponse       | Description                                                    |
| ----------------- | -------------------- | --------------- | ------------------------ | ---------------------- | -------------------------------------------------------------- |
| **Critical**      | 🔴 Réponse urgente   | Large           | Faible                   | Début dans 15 min      | Arrêt total du système, risque de perte de données             |
| **High Priority** | 🟠 Réponse précoce   | Large           | Élevée                   | Début dans 1 heure     | Arrêt de fonction principale, affecte de nombreux utilisateurs |
| **Medium**        | 🟡 Réponse planifiée | Limitée         | Élevée                   | Réponse le jour même   | Restriction de fonction partielle, solution alternative existe |
| **Low**           | 🟢 Observation       | Limitée         | Faible                   | Prochaine modification | Défaut mineur, petit impact sur UX                             |

## Processus d'Analyse

### Phase 1 : Collecte d'Informations d'Erreur

```bash
🔴 Exécution obligatoire :
- Obtention complète du message d'erreur
- Vérification de la stack trace
- Identification des conditions d'occurrence (reproductibilité)

🟡 Exécution précoce :
- Collecte d'informations d'environnement (OS, version, dépendances)
- Historique des changements immédiats (git log, commits récents)
- Vérification des logs connexes

🟢 Exécution supplémentaire :
- État des ressources système
- État du réseau
- État des services externes
```

### Phase 2 : Analyse de Cause Racine

1. **Organisation des symptômes de surface**
   - Contenu exact du message d'erreur
   - Timing et modèle d'occurrence
   - Identification de la portée d'impact

2. **Identification de la cause profonde**
   - Application de l'analyse 5 Pourquoi
   - Traçage des dépendances
   - Vérification des différences environnementales

3. **Vérification d'hypothèse**
   - Création de code minimal de reproduction
   - Exécution de test d'isolement
   - Affinement des causes

### Phase 3 : Implémentation de Solution

```bash
🔴 Gestion immédiate (hotfix) :
- Correction minimale pour supprimer les symptômes
- Application de solution temporaire
- Préparation pour déploiement d'urgence

🟡 Résolution fondamentale :
- Correction essentielle pour la cause
- Ajout de cas de test
- Mise à jour de documentation

🟢 Implémentation de mesures préventives :
- Renforcement de la gestion d'erreurs
- Configuration de surveillance/alertes
- Amélioration du pipeline CI/CD
```

## Exemple de Sortie

```text
🚨 Rapport d'Analyse d'Erreur
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 Résumé de l'Erreur
├─ Type : [Compilation/Temps d'exécution/Logique/Environnemental]
├─ Urgence : 🔴 Élevée / 🟡 Moyenne / 🟢 Faible
├─ Portée d'impact : [Nom de fonction/Composant]
└─ Reproductibilité : [100% / Intermittent / Condition spécifique]

🔍 Cause Racine
├─ Cause directe : [Cause spécifique]
├─ Facteur de contexte : [Environnement/Configuration/Dépendances]
└─ Déclencheur : [Condition d'occurrence]

💡 Solution
🔴 Gestion immédiate :
1. [Commande/code de correction spécifique]
2. [Mesure temporaire]

🟡 Résolution fondamentale :
1. [Méthode de correction essentielle]
2. [Refactoring nécessaire]

🟢 Mesures préventives :
1. [Amélioration de la gestion d'erreurs]
2. [Ajout de tests]
3. [Configuration de surveillance]

📝 Procédure de Vérification
1. [Méthode de vérification après application de correction]
2. [Commande d'exécution de tests]
3. [Éléments de vérification de fonctionnement]
```

## Méthode d'Analyse par Type d'Erreur

### Erreur de Compilation/Build

```bash
# Erreur de type TypeScript
Vérification obligatoire (élevée) :
- Configuration de tsconfig.json
- Existence de fichiers de définition de type (.d.ts)
- Exactitude des déclarations import

# Erreur de lifetime Rust
Vérification obligatoire (élevée) :
- Mouvement d'ownership
- Période de validité de référence
- Conflit de mutabilité
```

### Erreur de Temps d'Exécution

```bash
# Référence Null/Undefined
Vérification obligatoire (élevée) :
- Manque d'optional chaining
- Timing d'initialisation
- Attente de complétion de traitement asynchrone

# Erreur liée à la mémoire
Vérification obligatoire (élevée) :
- Obtention de heap dump
- Analyse de log GC
- Détection de référence circulaire
```

### Erreur de Dépendances

```bash
# Conflit de version
Vérification obligatoire (élevée) :
- Cohérence du fichier lock
- Exigences des peer dependencies
- Dépendances transitives

# Erreur de résolution de module
Vérification obligatoire (élevée) :
- Configuration NODE_PATH
- Configuration d'alias de chemin
- Liens symboliques
```

## Précautions

- **Absolument interdit** : Jugement basé sur une partie seulement du message d'erreur, application de solution Stack Overflow sans vérification
- **Conditions d'exception** : Mesures temporaires autorisées uniquement sous ces 3 conditions :
  1. Réponse d'urgence en environnement de production (résolution fondamentale obligatoire dans les 24 heures)
  2. Panne de service externe (moyen alternatif pendant l'attente de récupération)
  3. Bug connu du framework (en attente de sortie de version corrigée)
- **Recommandation** : Prioriser l'identification de la cause racine, éviter la correction superficielle

## Meilleures Pratiques

1. **Collecte complète d'informations** : Vérifier le message d'erreur du début à la fin
2. **Vérification de reproductibilité** : Prioriser la création de code minimal de reproduction
3. **Approche graduelle** : Commencer par de petites corrections et vérifier
4. **Documentation** : Enregistrer le processus de résolution pour partager les connaissances

### Pièges Courants

- **Gestion des symptômes** : Correction superficielle qui ignore la cause racine
- **Généralisation excessive** : Appliquer largement la solution d'un cas spécifique
- **Omission de vérification** : Ne pas confirmer les effets secondaires après correction
- **Personnalisation des connaissances** : Ne pas documenter la méthode de résolution

## Commandes Connexes

- `/design-patterns` : Analyser les problèmes de structure de code et proposer des modèles
- `/tech-debt` : Analyser la cause racine des erreurs du point de vue de la dette technique
- `/analyzer` : Quand une analyse de cause racine plus approfondie est nécessaire
