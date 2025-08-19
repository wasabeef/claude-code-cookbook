## Check Prompt

Une collection complète de meilleures pratiques pour évaluer et améliorer la qualité des prompts pour les agents IA. Elle systématise les connaissances acquises lors de processus d'amélioration de prompts réels, couvrant tous les aspects importants comme l'élimination d'ambiguïtés, l'intégration d'informations, le renforcement d'application, les systèmes de suivi et l'amélioration continue.

### Utilisation

```bash
# Vérifier la qualité d'un fichier prompt
cat your-prompt.md
/check-prompt
"Check the quality of this prompt and suggest improvements"
```

### Options

- Aucune : Analyser le fichier actuel ou le texte sélectionné
- `--category <name>` : Vérifier seulement une catégorie spécifique (structure/execution/restrictions/quality/roles/improvement)
- `--score` : Calculer seulement le score de qualité
- `--fix` : Suggérer automatiquement des corrections pour les problèmes détectés
- `--deep` : Mode d'analyse approfondie (focus sur l'ambiguïté, la dispersion d'informations et l'application)

### Exemples de base

```bash
# Évaluer la qualité globale du prompt
cat devin/playbooks/code-review.md
/check-prompt
"Evaluate this prompt across 6 categories and suggest improvements"

# Mode d'analyse approfondie
/check-prompt --deep
"Focus on checking ambiguity, information dispersion, and lack of enforcement to suggest fundamental improvements"

# Vérifier une catégorie spécifique
/check-prompt --category structure
"Check this prompt from the perspective of structure and clarity"

# Détecter et corriger les expressions ambiguës
/check-prompt --fix
"Detect ambiguous expressions and suggest corrections for clarity"
```

---

## Principes de conception de base

### Principe 1 : Éliminer complètement la place à l'interprétation

- **Absolument interdit** : "En principe", "Recommandé", "Si possible", "Selon la situation", "Utilisez votre jugement"
- **Doit utiliser** : "Toujours", "Absolument", "Respecter strictement", "Sans exception", "Obligatoire"
- **Conditions d'exception** : Strictement limitées par nombres ("Seulement sous les 3 conditions suivantes", "Sauf dans ces 2 cas")

### Principe 2 : Intégration stratégique d'informations

- Intégrer complètement les informations importantes liées dans une section
- Résumer la vue d'ensemble dans une liste de contrôle d'exécution
- Éliminer complètement les références circulaires et la dispersion

### Principe 3 : Construire une application progressive

- Hiérarchie claire de 🔴 (Niveau d'arrêt d'exécution) → 🟡 (Qualité importante) → 🟢 (Éléments recommandés)
- Mise à niveau progressive du niveau recommandé au niveau obligatoire
- Indication explicite de l'impact et des contremesures pour les violations

### Principe 4 : Assurer la traçabilité

- Tous les résultats d'exécution peuvent être enregistrés et vérifiés
- Prévenir techniquement les faux rapports
- Critères objectifs pour le jugement de succès/échec

### Principe 5 : Amélioration pilotée par feedback

- Apprendre des cas d'échec réels
- Vérification continue de l'efficacité
- Détection automatique de nouveaux motifs

---

## 📋 Éléments de vérification complète

### 1. 📐 Structure et clarté (Poids : 25 points)

#### 1.1 Indication de priorité des instructions (8 points)

- [ ] Les priorités 🔴🟡🟢 sont clairement indiquées pour toutes les instructions importantes
- [ ] Les conditions de niveau d'arrêt d'exécution sont spécifiquement et clairement définies
- [ ] Les critères pour chaque niveau de priorité sont objectifs et vérifiables
- [ ] La hiérarchie des priorités est appliquée de manière cohérente

#### 1.2 Élimination complète d'expressions ambiguës (9 points)

- [ ] **Expressions ambiguës fatales** : 0 instances de "En principe", "Recommandé", "Si possible"
- [ ] **Utilisation d'expressions obligatoires** : Utilisation appropriée de "Toujours", "Absolument", "Respecter strictement", "Sans exception"
- [ ] **Limitation numérique des conditions d'exception** : Limites claires comme "Seulement 3 conditions"
- [ ] **Élimination de place au jugement** : Utiliser seulement des expressions qui ne peuvent être interprétées de multiples façons
- [ ] **Élimination des zones grises** : Critères de jugement clairs pour toutes les situations

#### 1.3 Intégration stratégique d'informations (8 points)

- [ ] La dispersion multiple d'informations importantes est complètement éliminée
- [ ] Les instructions liées sont logiquement intégrées dans une section
- [ ] La vue d'ensemble est complètement résumée dans la liste de contrôle d'exécution
- [ ] Il n'y a pas de références circulaires ou de boucles infinies

### 2. 🎯 Exécutabilité (Poids : 20 points)

#### 2.1 Complétude des procédures spécifiques (7 points)

- [ ] Tous les exemples de commandes sont effectivement exécutables et vérifiés
- [ ] Variables d'environnement, prérequis et dépendances sont clairement déclarés sans omissions
- [ ] Les méthodes de gestion d'erreur sont spécifiques et exécutables
- [ ] L'ordre des procédures est logique et nécessaire

#### 2.2 Assurer la vérifiabilité (7 points)

- [ ] Le succès/échec des résultats d'exécution peut être déterminé objectivement
- [ ] Exemples de sortie, formats de journaux et valeurs attendues sont spécifiquement montrés
- [ ] Les méthodes de test et procédures de vérification peuvent être implémentées
- [ ] Les points de contrôle pour confirmer les résultats intermédiaires sont appropriés

#### 2.3 Adaptabilité à l'automatisation (6 points)

- [ ] Format permettant facilement l'intégration scripting et CI/CD
- [ ] Séparation claire entre points de jugement humain et d'exécution IA
- [ ] Support pour traitement par lots et exécution parallèle

### 3. 🚫 Clarification des éléments interdits (Poids : 15 points)

#### 3.1 Systématisation des interdictions absolues (8 points)

- [ ] Liste complète des opérations qui ne doivent pas être effectuées
- [ ] Indication explicite du niveau d'impact (mineur/majeur/fatal) pour chaque violation d'élément interdit
- [ ] Présentation spécifique d'alternatives et méthodes d'évitement
- [ ] Explication de la base technique pour les éléments interdits

#### 3.2 Limitation stricte des conditions d'exception (7 points)

- [ ] Les conditions permettant les exceptions sont spécifiques et limitées (spécification numérique)
- [ ] Critères de jugement objectifs comme "Complètement dupliqué", "Explicitement déclaré"
- [ ] Limites claires sans laisser de zones grises
- [ ] Indication explicite de conditions supplémentaires et contraintes lors de l'application d'exceptions

### 4. 📊 Mécanismes d'assurance qualité (Poids : 20 points)

#### 4.1 Complétude du système de suivi (8 points)

- [ ] Fonction d'enregistrement automatique et collecte de statistiques pour tous les résultats d'exécution
- [ ] Fonction de vérification pour prévenir techniquement les faux rapports
- [ ] Fonctions de surveillance en temps réel et d'alerte
- [ ] Fonction de prévention de falsification des journaux d'audit

#### 4.2 Application de conformité aux modèles (7 points)

- [ ] Définition claire et fonction de vérification pour les éléments obligatoires
- [ ] Restrictions techniques sur les zones interdites de personnalisation
- [ ] Points de contrôle automatisés pour confirmation de conformité
- [ ] Fonctions de correction automatique et d'avertissement en cas de violation

#### 4.3 Exhaustivité de la gestion d'erreurs (5 points)

- [ ] Catalogage complet des motifs d'erreur attendus
- [ ] Processus de gestion étape par étape pour les erreurs
- [ ] Prévention technique de rapporter les échecs comme succès

### 5. 🎭 Clarification des rôles et responsabilités (Poids : 10 points)

#### 5.1 Portée d'autorité de l'agent IA (5 points)

- [ ] Limites claires entre opérations exécutables et interdites
- [ ] Portée spécifique et contraintes de l'autorité de jugement
- [ ] Séparation claire des opérations nécessitant confirmation humaine

#### 5.2 Unification du système de classification (5 points)

- [ ] Clarté, unicité et exclusivité des définitions de classification
- [ ] Explications explicites pour prévenir les malentendus d'importance entre classifications
- [ ] Exemples d'utilisation spécifiques et organigrammes de décision pour chaque classification

### 6. 🔄 Amélioration continue (Poids : 10 points)

#### 6.1 Automatisation de la collecte de feedback (5 points)

- [ ] Extraction automatique de points d'amélioration depuis les journaux d'exécution
- [ ] Analyse basée sur apprentissage machine des motifs d'échec
- [ ] Mécanisme de mise à jour automatique pour les meilleures pratiques

#### 6.2 Implémentation de fonctions d'apprentissage (5 points)

- [ ] Détection et classification automatiques de nouveaux motifs
- [ ] Surveillance continue de l'efficacité des règles existantes
- [ ] Suggestions automatiques pour améliorations progressives

---

## 🚨 Motifs de problèmes fatals (Correction immédiate requise)

### ❌ Niveau 1 : Ambiguïté fatale (Niveau d'arrêt d'exécution)

- **Instructions avec interprétations multiples** : "Utilisez votre jugement", "Selon la situation", "En principe"
- **Conditions d'exception ambiguës** : "Dans des cas spéciaux", "Au besoin"
- **Critères de jugement subjectifs** : "Approprié", "Suffisant", "Autant que possible"
- **Concepts importants non définis** : "Standard", "Général", "De base"

### ❌ Niveau 2 : Défauts structurels (Niveau de qualité important)

- **Dispersion d'informations** : Informations importantes liées dispersées dans 3 endroits ou plus
- **Références circulaires** : Boucles infinies de section A→B→C→A
- **Instructions contradictoires** : Instructions contradictoires dans différentes sections
- **Ordre d'exécution peu clair** : Procédures avec dépendances peu claires

### ❌ Niveau 3 : Dégradation de qualité (Niveau d'amélioration recommandée)

- **Non-vérifiabilité** : Critères peu clairs pour jugement de succès/échec
- **Difficulté d'automatisation** : Conception dépendante du jugement subjectif humain
- **Difficulté de maintenance** : Structure où la portée d'impact lors des mises à jour ne peut être prédite
- **Difficulté d'apprentissage** : Complexité qui prend du temps aux nouveaux arrivants pour comprendre

---

## 🎯 Méthodes d'amélioration éprouvées

### ✅ Approche d'amélioration progressive

1. **Analyse de situation actuelle** : Classification, priorisation et évaluation d'impact des problèmes
2. **Priorité aux problèmes fatals** : Priorité absolue sur résolution complète des problèmes Niveau 1
3. **Implémentation progressive** : Implémenter en unités vérifiables sans faire tous les changements à la fois
4. **Mesure d'effet** : Comparaison quantitative avant et après amélioration
5. **Surveillance continue** : Confirmation de durabilité des effets d'amélioration

### ✅ Méthodes pratiques pour élimination d'ambiguïté

```markdown
# ❌ Avant amélioration (Ambigu)

"Les commentaires doivent être, en principe, écrits comme commentaires inline aux points de changement correspondants sur GitHub"

# ✅ Après amélioration (Clair)

"Les commentaires doivent être écrits comme commentaires inline aux points de changement correspondants sur GitHub. Les exceptions sont seulement les 3 conditions définies en section 3.3"
```

### ✅ Méthodes pratiques pour intégration d'informations

```markdown
# ❌ Avant amélioration (Dispersé)

Section 2.1 : "Utiliser 6 sections obligatoires"
Section 3.5 : "📊 Évaluation complète, 📋 Commentaires..."
Section 4.2 : "Interdiction de suppression de section"

# ✅ Après amélioration (Intégré)

Liste de contrôle d'exécution :
□ 10. Poster commentaire résumé (utilisant 6 sections obligatoires)
🔴 6 sections obligatoires : 1) 📊 Évaluation complète 2) 📋 Classification des commentaires 3) ⚠️ Principales préoccupations 4) ✅ Points évaluables 5) 🎯 Conclusion 6) 🤖 Auto-évaluation de qualité de revue IA
❌ Absolument interdit : Suppression, ajout, changement de nom de section
```

### ✅ Motifs d'implémentation pour systèmes de suivi

```bash
# Suivi strict des résultats d'exécution
POSTED_COMMENTS=0
FAILED_COMMENTS=0
TOTAL_COMMENTS=0

# Enregistrer résultats de chaque opération
if [ $? -eq 0 ]; then
    echo "✅ Succès : $OPERATION" >> /tmp/execution_log.txt
    POSTED_COMMENTS=$((POSTED_COMMENTS + 1))
else
    echo "❌ Échec : $OPERATION" >> /tmp/execution_log.txt
    FAILED_COMMENTS=$((FAILED_COMMENTS + 1))
fi

# Prévenir faux rapports
if [ $POSTED_COMMENTS -ne $REPORTED_COMMENTS ]; then
    echo "🚨 Avertissement : Désaccord entre commentaires rapportés et postés réellement"
    exit 1
fi
```

---

## 📈 Calcul de score de qualité (Version améliorée)

### Calcul de score global

```
Score de base = Σ(score catégorie × poids) / 100

Pénalités problèmes fatals :
- Problème Niveau 1 : -20 points par cas
- Problème Niveau 2 : -10 points par cas
- Problème Niveau 3 : -5 points par cas

Éléments bonus :
- Support automatisation : +5 points
- Implémentation fonction apprentissage : +5 points
- Cas d'amélioration éprouvés : +5 points

Score final = Score de base + Bonus - Pénalités
```

### Évaluation niveau de qualité

```
95-100 points : Standard mondial le plus élevé (Recommandé comme standard industrie)
90-94 points : Excellent (Prêt pour production)
80-89 points : Bon (Prêt pour opération avec améliorations mineures)
70-79 points : Moyen (Nécessite améliorations)
60-69 points : Nécessite améliorations (Requiert corrections significatives)
50-59 points : Nécessite corrections majeures (Requiert révision fondamentale)
49 points ou moins : Interdit d'usage (Requiert refonte complète)
```

---

## 🔧 Processus d'amélioration pratique

### Phase 1 : Diagnostic/Analyse (1-2 jours)

1. **Compréhension structure globale** : Visualisation de composition des sections, flux d'informations et dépendances
2. **Détection d'ambiguïté** : Extraction de toutes expressions avec place à l'interprétation
3. **Analyse dispersion d'informations** : Cartographie des motifs dispersés d'informations liées
4. **Évaluation d'application** : Évaluation de classification recommandé/obligatoire et efficacité
5. **Confirmation traçabilité** : Évaluation des fonctions d'enregistrement et vérification des résultats d'exécution

### Phase 2 : Priorisation/Planification (Demi-journée)

1. **Classification de fatalité** : Classification des problèmes en Niveaux 1-3 et évaluation d'impact
2. **Détermination ordre d'amélioration** : Ordre optimal considérant les interdépendances
3. **Allocation ressources** : Optimisation de l'équilibre entre effets d'amélioration et coûts
4. **Évaluation des risques** : Prédiction des effets secondaires et problèmes de compatibilité lors de l'amélioration

### Phase 3 : Implémentation progressive (2-5 jours)

1. **Résolution problèmes Niveau 1** : Élimination complète d'ambiguïtés fatales
2. **Implémentation intégration d'informations** : Agrégation stratégique d'informations dispersées
3. **Amélioration d'application** : Mise à niveau progressive de recommandé à obligatoire
4. **Implémentation système de suivi** : Fonctions d'enregistrement automatique et vérification pour résultats d'exécution
5. **Amélioration de modèles** : Clarification d'éléments obligatoires et application de conformité

### Phase 4 : Vérification/Ajustement (1-2 jours)

1. **Tests de fonctionnement** : Confirmation d'opération de tous les changements
2. **Tests d'intégration** : Confirmation de cohérence à l'échelle du système
3. **Tests de performance** : Confirmation d'efficacité d'exécution et réponse
4. **Tests d'utilisabilité** : Vérification dans des scénarios d'utilisation réels

### Phase 5 : Opération/Surveillance (Continue)

1. **Mesure d'effet** : Comparaison quantitative avant et après amélioration
2. **Surveillance continue** : Détection précoce de dégradation de qualité
3. **Collecte de feedback** : Extraction de problèmes en opération réelle
4. **Optimisation continue** : Cycle d'amélioration continue

---

## 📊 Cas d'amélioration réels (Version détaillée)

### Étude de cas : Amélioration qualité de prompts à grande échelle

#### Situation avant amélioration

```bash
Score de qualité : 70/100 points
- Expressions ambiguës : 15 détectées
- Dispersion d'informations : Informations importantes dispersées dans 6 endroits
- Manque d'application : 80% des expressions au niveau recommandé
- Fonction de suivi : Aucun enregistrement de résultats d'exécution
- Gestion d'erreurs : Contremesures peu claires pour les échecs
```

#### Améliorations implémentées

```bash
# 1. Élimination d'ambiguïté (2 jours)
- "En principe" → "Exceptions sont seulement les 3 conditions en section 3.3"
- "Recommandé" → "Obligatoire" (pour niveau d'importance 2 et plus)
- "Selon approprié" → Indication explicite de critères de jugement spécifiques

# 2. Intégration d'informations (1 jour)
- Informations 6 sections obligatoires dispersées → Intégrées dans liste de contrôle d'exécution
- Éléments interdits liés → Agrégés dans une section
- Élimination références circulaires → Flux d'informations linéaire

# 3. Implémentation système de suivi (1 jour)
- Enregistrement automatique de journaux des résultats d'exécution
- Fonction de vérification pour prévenir faux rapports
- Affichage de statistiques en temps réel

# 4. Amélioration gestion d'erreurs (Demi-journée)
- Catalogage complet des motifs d'erreur attendus
- Documentation des processus de gestion étape par étape
- Implémentation de fonctions de récupération automatique
```

#### Résultats après amélioration

```bash
Score de qualité : 90/100 points (+20 points d'amélioration)
- Expressions ambiguës : 0 (complètement éliminées)
- Intégration d'informations : Informations importantes agrégées dans 3 endroits
- Application : 95% des expressions au niveau obligatoire
- Fonction de suivi : Entièrement automatisée
- Gestion d'erreurs : 90% des problèmes résolus automatiquement

Effets d'amélioration réels :
- Erreurs d'évaluation : 85% de réduction
- Temps d'exécution : 40% de réduction
- Taux d'occurrence d'erreurs : 70% de réduction
- Satisfaction utilisateur : 95% d'amélioration
```

### Leçons/Meilleures pratiques

#### Facteurs de succès

1. **Approche progressive** : Implémenter en unités vérifiables sans faire tous les changements à la fois
2. **Piloté par données** : Améliorer basé sur données mesurées plutôt que jugement subjectif
3. **Surveillance continue** : Confirmer régulièrement la durabilité des effets d'amélioration
4. **Orienté feedback** : Collecter activement les opinions des utilisateurs réels

#### Mesures d'évitement d'échec

1. **Perfectionnisme excessif** : Commencer l'opération une fois atteint 90 points, viser 100 points par amélioration continue
2. **Dangers de changements par lots** : Toujours implémenter les changements à grande échelle progressivement
3. **Compatibilité ascendante** : Minimiser l'impact sur les flux de travail existants
4. **Documentation insuffisante** : Enregistrer et partager tous les changements en détail

---

### Collaboration avec Claude

```bash
# Vérification qualité combinée avec fichier prompt
cat your-prompt.md
/check-prompt
"Evaluate the quality of this prompt and suggest improvements"

# Comparaison de plusieurs fichiers prompt
cat prompt-v1.md && echo "---" && cat prompt-v2.md
/check-prompt
"Compare the two versions and analyze improved points and remaining issues"

# Analyse combinée avec journaux d'erreur réels
cat execution-errors.log
/check-prompt --deep
"Identify potential prompt issues that may have caused this error"
```

### Notes

- **Prérequis** : Il est recommandé d'écrire les fichiers prompt en format Markdown
- **Limitation** : Pour les prompts à grande échelle (10 000 lignes ou plus), il est recommandé d'analyser par parties
- **Recommandation** : Vérifier régulièrement la qualité des prompts et améliorer continuellement

---

_Cette liste de contrôle est une version complète de connaissances éprouvées dans des projets d'amélioration de prompts réels et continue d'évoluer._
