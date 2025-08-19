## Correction d'erreur

Analyse les messages d'erreur pour identifier les causes racines et suggérer des corrections éprouvées.

### Utilisation

```bash
/fix-error [options]
```

### Options

- Aucune : Analyse d'erreur standard
- `--deep` : Analyse approfondie incluant les dépendances et l'environnement
- `--preventive` : Focus sur la prévention des occurrences futures
- `--quick` : Corrections rapides uniquement

### Exemples de base

```bash
# Analyse d'erreur standard
npm run build 2>&1
/fix-error
"Analysez cette erreur de build et suggérez des corrections"

# Mode analyse approfondie
python app.py 2>&1
/fix-error --deep
"Trouvez la cause racine, y compris les problèmes d'environnement"

# Corrections rapides uniquement
cargo test 2>&1
/fix-error --quick
"Donnez-moi juste une correction rapide"

# Focus sur la prévention
./app 2>&1 | tail -50
/fix-error --preventive
"Corrigez ceci et aidez-moi à le prévenir la prochaine fois"
```

### Collaboration avec Claude

```bash
# Analyser les journaux d'erreur
cat error.log
/fix-error
"Qu'est-ce qui cause cette erreur et comment la corriger ?"

# Résoudre les échecs de test
npm test 2>&1
/fix-error --quick
"Ces tests échouent - j'ai besoin d'une correction rapide"

# Analyser les traces de pile
python script.py 2>&1
/fix-error --deep
"Creusez dans cette trace de pile et vérifiez les problèmes d'environnement"

# Gérer plusieurs erreurs
grep -E "ERROR|WARN" app.log | tail -20
/fix-error
"Triez celles-ci par priorité et dites-moi comment corriger chacune"
```

### Priorités d'analyse des erreurs

#### 🔴 Urgence : Élevée (À corriger maintenant !)

- **Arrêt de l'application** : Plantages, boucles infinies, interblocages
- **Risque de perte de données** : Erreurs de base de données, corruption de fichiers
- **Vulnérabilités de sécurité** : Échecs d'authentification, erreurs de permissions, injections
- **Impact en production** : Échecs de déploiement, pannes de service

#### 🟡 Urgence : Moyenne (À corriger bientôt)

- **Problèmes de performance** : Fuites mémoire, délais, timeouts
- **Échec partiel de fonctionnalité** : Erreurs dans des fonctionnalités spécifiques, bugs d'interface
- **Réduction de l'efficacité de développement** : Erreurs de build, échecs de tests

#### 🟢 Urgence : Faible (À corriger quand c'est pratique)

- **Messages d'avertissement** : Dépréciation, erreurs de lint
- **Environnement de développement uniquement** : Problèmes seulement dans les environnements locaux
- **Risques futurs** : Dette technique, problèmes de maintenabilité

### Processus d'analyse

#### Phase 1 : Collecte d'informations sur l'erreur

```bash
🔴 Indispensable :
- Message d'erreur complet
- Trace de pile
- Étapes pour reproduire

🟡 Souhaitable :
- Détails d'environnement (OS, versions, dépendances)
- Changements récents (git log, commits)
- Journaux associés

🟢 Bonus :
- Ressources système
- État réseau
- Services externes
```

#### Phase 2 : Analyse des causes racines

1. **Identifier les symptômes**
   - Message d'erreur exact
   - Quand et comment cela arrive
   - Ce qui est affecté

2. **Trouver les causes racines**
   - Utiliser l'analyse des 5 Pourquoi
   - Vérifier les dépendances
   - Comparer les environnements

3. **Tester votre théorie**
   - Créer une reproduction minimale
   - Isoler le problème
   - Confirmer la cause

#### Phase 3 : Implémentation de la solution

```bash
🔴 Correction rapide (hotfix) :
- Arrêter l'hémorragie
- Appliquer des contournements
- Se préparer à déployer

🟡 Correction de la cause racine :
- Corriger le problème réel
- Ajouter des tests
- Mettre à jour la documentation

🟢 Prévenir les problèmes futurs :
- Meilleure gestion d'erreurs
- Ajouter la surveillance
- Améliorer CI/CD
```

### Exemple de sortie

```
🚨 Rapport d'analyse d'erreur
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 Aperçu de l'erreur
├─ Type : [Compilation/Runtime/Logique/Environnemental]
├─ Urgence : 🔴 Élevée / 🟡 Moyenne / 🟢 Faible
├─ Portée d'impact : [Nom de fonctionnalité/Composant]
└─ Reproductibilité : [100% / Intermittent / Conditions spécifiques]

🔍 Cause racine
├─ Cause directe : [Cause spécifique]
├─ Facteurs contextuels : [Environnement/Configuration/Dépendances]
└─ Déclencheur : [Conditions d'occurrence]

💡 Solutions
🔴 Réponse immédiate :
1. [Commande/code de correction spécifique]
2. [Contournement temporaire]

🟡 Solution fondamentale :
1. [Méthode de correction essentielle]
2. [Refactorisation nécessaire]

🟢 Mesures préventives :
1. [Amélioration de la gestion d'erreurs]
2. [Ajouter des tests]
3. [Configuration de surveillance]

📝 Procédure de vérification
1. [Méthode pour confirmer après application de la correction]
2. [Commande d'exécution de test]
3. [Éléments de vérification d'opération]
```

### Méthodes d'analyse par type d'erreur

#### Erreurs de compilation/build

```bash
# Erreurs de type TypeScript
À vérifier (élevé) :
- Paramètres tsconfig.json
- Présence des fichiers de définition de type (.d.ts)
- Exactitude des déclarations d'import

# Erreurs de durée de vie Rust
À vérifier (élevé) :
- Mouvement de propriété
- Périodes de validité des références
- Conflits de mutabilité
```

#### Erreurs d'exécution

```bash
# Références Null/Undefined
À vérifier (élevé) :
- Chaînage optionnel insuffisant
- Timing d'initialisation
- Attente de complétion de traitement async

# Erreurs liées à la mémoire
À vérifier (élevé) :
- Acquisition de dump heap
- Analyse des journaux GC
- Détection de références circulaires
```

#### Erreurs de dépendances

```bash
# Conflits de versions
À vérifier (élevé) :
- Cohérence du fichier de verrouillage
- Exigences des dépendances pairs
- Dépendances transitives

# Erreurs de résolution de modules
À vérifier (élevé) :
- Paramètres NODE_PATH
- Configuration d'alias de chemin
- Liens symboliques
```

### Remarques

- **Absolument interdit** : Porter des jugements basés uniquement sur une partie d'un message d'erreur, appliquer des solutions Stack Overflow sans vérification
- **Conditions d'exception** : Les contournements temporaires ne sont autorisés que dans ces 3 conditions :
  1. Réponse d'urgence en environnement de production (solution racine requise dans les 24 heures)
  2. Pannes de service externe (moyens alternatifs en attendant la récupération)
  3. Bugs connus du framework (en attendant la sortie de version corrigée)
- **Recommandation** : Priorisez l'identification des causes racines et évitez les corrections superficielles

### Bonnes pratiques

1. **Collecte d'informations complète** : Vérifiez les messages d'erreur du début à la fin
2. **Confirmation de reproductibilité** : Priorisez la création de code de reproduction minimal
3. **Approche étape par étape** : Commencez par de petites corrections et vérifiez
4. **Documentation** : Enregistrez le processus de solution pour le partage de connaissances

#### Pièges courants

- **Traitement des symptômes** : Corrections superficielles qui ratent les causes racines
- **Surgénéralisation** : Application large de solutions pour des cas spécifiques
- **Vérification omise** : Ne pas vérifier les effets de bord après les corrections
- **Individualisation des connaissances** : Ne pas documenter les méthodes de solution

### Commandes associées

- `/design-patterns` : Analyser les problèmes de structure de code et suggérer des patterns
- `/tech-debt` : Analyser les causes racines d'erreurs du point de vue de la dette technique
- `/analyzer` : Pour les cas nécessitant une analyse plus approfondie des causes racines
