## Tech Debt

Analyse quantitativement la dette technique du projet et visualise les scores de santé avec l'impact sur l'efficacité de développement. Suit les améliorations grâce à l'analyse de tendances, calcule les coûts temporels et crée un plan d'amélioration priorisé.

### Utilisation

```bash
# Vérifier la configuration du projet pour analyser la dette technique
ls -la
"Analyser la dette technique de ce projet et créer un plan d'amélioration"
```

### Tableau de Bord de Santé du Projet

```
Score de Santé du Projet: 72/100
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Scores par Catégorie
├─ Fraîcheur des dépendances: ████████░░ 82% (À jour: 45/55)
├─ Complétude de documentation: ███░░░░░░░ 35% (Manque README, docs API)
├─ Couverture de tests: ██████░░░░ 65% (Objectif: 80%)
├─ Sécurité: ███████░░░ 78% (Vulnérabilités: 2 Medium)
├─ Architecture: ██████░░░░ 60% (Dépendances circulaires: 3 emplacements)
└─ Qualité du code: ███████░░░ 70% (Complexité élevée: 12 fichiers)

📈 Tendances (30 derniers jours)
├─ Score global: 68 → 72 (+4) ↗️
├─ Éléments améliorés: 12 ✅
├─ Nouvelle dette: 3 ⚠️
├─ Dette résolue: 8 🎉
└─ Vitesse d'amélioration: +0.13/jour

⏱️ Impact temporel de la dette
├─ Ralentissement du développement: -20% (développement de nouvelles fonctionnalités prend 1.25x le temps normal)
├─ Temps de correction de bugs: +15% (temps de correction moyen 2h → 2.3h)
├─ Revue de code: +30% (temps supplémentaire par complexité de compréhension)
├─ Intégration: +50% (temps nécessaire pour que les nouveaux membres comprennent)
└─ Temps de retard cumulé: Équivalent à 40 heures/semaine

🎯 Effets attendus d'amélioration (basés sur le temps)
├─ Effet immédiat: Vitesse de développement +10% (après 1 semaine)
├─ Effet à court terme: Taux de bugs -25% (après 1 mois)
├─ Effet à moyen terme: Vitesse de développement +30% (après 3 mois)
├─ Effet à long terme: Temps de maintenance -50% (après 6 mois)
└─ ROI: Investissement 40 heures → Récupération 120 heures (3 mois)
```

### Exemples de Base

```bash
# Analyse détaillée du score de santé
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Calculer le score de santé du projet et évaluer par catégories"

# Analyse d'impact de dette TODO/FIXME
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"Évaluer ces TODOs par impact de dette (temps×importance)"

# Vérification de santé des dépendances
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"Calculer le score de fraîcheur des dépendances et analyser les risques et effets des mises à jour"
```

### Collaboration avec Claude

```bash
# Analyse intégrale de dette technique
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"Analyser la dette technique de ce projet sous ces perspectives:
1. Qualité du code (complexité, duplication, maintenabilité)
2. Santé des dépendances
3. Risques de sécurité
4. Problèmes de performance
5. Manque de couverture de tests"

# Analyse de dette architecturale
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"Identifier la dette technique au niveau architectural et proposer un plan de refactorisation"

# Plan d'amélioration priorisé
"Évaluer la dette technique selon ces critères et présenter en format tableau:
- Impact (Élevé/Moyen/Faible)
- Coût de correction (temps)
- Risque technique (possibilité de panne système, perte de données)
- Effet de réduction de temps par amélioration
- Moment recommandé d'implémentation"
```

### Exemples Détaillés

```bash
# Détection automatique du type de projet et analyse
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"Basé sur le type de projet détecté, analyser:
1. Dette technique spécifique au langage/framework
2. Écarts des meilleures pratiques
3. Opportunités de modernisation
4. Stratégie d'amélioration graduelle"

# Analyse de métriques de qualité du code
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"Analyser la qualité du code du projet et présenter ces métriques:
- Fonctions avec haute complexité cyclomatique
- Détection de code dupliqué
- Fichiers/fonctions trop longs
- Manque de gestion d'erreur appropriée"

# Détection de dette de sécurité
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"Détecter la dette technique liée à la sécurité et proposer la priorité de correction et les contre-mesures"

# Analyse de manque de tests
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"Analyser la dette technique de couverture de tests et proposer une stratégie de tests"
```

### Matrice de Priorités de Dette

```
Priorité = (Impact × Fréquence) ÷ Coût de correction
```

| Priorité                   | Impact sur développement | Coût de correction | Effet de réduction de temps | Retour sur investissement         | Délai de réponse |
| -------------------------- | ------------------------ | ------------------ | --------------------------- | --------------------------------- | ---------------- |
| **[P0] Réponse immédiate** | Élevé                    | Faible             | > 5x                        | Investissement 1h→Réduction 5h+   | Immédiat         |
| **[P1] Cette semaine**     | Élevé                    | Moyen              | 2-5x                        | Investissement 1h→Réduction 2-5h  | Dans 1 semaine   |
| **[P2] Ce mois**           | Faible                   | Élevé              | 1-2x                        | Investissement 1h→Réduction 1-2h  | Dans 1 mois      |
| **[P3] Ce trimestre**      | Faible                   | Faible             | < 1x                        | Investissement=temps de réduction | Dans 3 mois      |

### Critères d'Évaluation par Type de Dette

| Type de dette                | Méthode de détection                    | Impact sur développement                                     | Temps de correction |
| ---------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------- |
| **Dette architecturale**     | Dépendances circulaires, couplage élevé | Grande portée d'impact lors de changements, tests difficiles | 40-80h              |
| **Dette de sécurité**        | Scan CVE, OWASP                         | Risque de vulnérabilités, conformité                         | 8-40h               |
| **Dette de performance**     | N+1, fuites mémoire                     | Augmentation temps de réponse, consommation ressources       | 16-40h              |
| **Dette de tests**           | Couverture < 60%                        | Détection tardive de bugs, qualité instable                  | 20-60h              |
| **Dette de documentation**   | Manque README, docs API                 | Temps d'intégration augmenté                                 | 8-24h               |
| **Dette de dépendances**     | Non mises à jour depuis 2+ ans          | Risque de sécurité, problèmes de compatibilité               | 4-16h               |
| **Dette de qualité du code** | Complexité > 10                         | Temps de compréhension/correction augmenté                   | 2-8h                |

### Calcul d'Impact de Dette Technique

```
Impact = Σ(poids de chaque élément × valeur mesurée)

📊 Indicateurs d'impact mesurables:
├─ Impact sur la vitesse de développement
│  ├─ Temps de compréhension du code: +X% (proportionnel à la complexité)
│  ├─ Portée d'impact lors de changements: Y fichiers (mesuré par couplage)
│  └─ Temps d'exécution de tests: Z minutes (pipeline CI/CD)
│
├─ Impact sur la qualité
│  ├─ Taux d'occurrence de bugs: +25% pour chaque 10 de complexité
│  ├─ Temps de révision: lignes de code × coefficient de complexité
│  └─ Risque par manque de tests: Haut risque si couverture < 60%
│
└─ Impact sur l'efficacité de l'équipe
   ├─ Temps d'intégration: +100% par manque de documentation
   ├─ Concentration de connaissances: Attention nécessaire si taux de contributeur unique >80%
   └─ Lieux de correction par duplication de code: taux de duplication × fréquence de changement
```

### Calcul de ROI basé sur le temps

```
ROI = (temps réduit - temps d'investissement) ÷ temps d'investissement × 100

Exemple: Résolution de dépendances circulaires
├─ Temps d'investissement: 16 heures (refactorisation)
├─ Effet de réduction (mensuel):
│  ├─ Temps de compilation: -10 min/jour × 20 jours = 200 min
│  ├─ Temps de débogage: -2 heures/semaine × 4 semaines = 8 heures
│  └─ Ajout de nouvelles fonctionnalités: -30% réduction de temps = 12 heures
├─ Temps de réduction mensuel: 23.3 heures
└─ ROI en 3 mois: (70 - 16) ÷ 16 × 100 = 337%
```

### Notes

- Auto-détecte le langage et framework du projet pour réaliser des analyses spécifiques
- Évalue le score de santé sur une échelle de 0-100 points, considérant sain 70+ points et nécessitant amélioration <50 points
- Calcule les coûts temporels et effets d'amélioration de manière spécifique, soutenant la prise de décision basée sur les données
- Pour la conversion monétaire, spécifier séparément le salaire horaire moyen de l'équipe ou coefficients spécifiques au projet
