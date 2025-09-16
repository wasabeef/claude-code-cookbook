## Multi-rôle

Une commande qui analyse la même cible en parallèle avec plusieurs rôles et génère un rapport intégré.

### Utilisation

```bash
/multi-role <rôle1>,<rôle2> [--agent|-a] [cible_analyse]
/multi-role <rôle1>,<rôle2>,<rôle3> [--agent|-a] [cible_analyse]
```

**Important** :

- Placez l'option `--agent` immédiatement après avoir spécifié les rôles
- Écrivez votre message après `--agent`
- Exemple correct : `/multi-role qa,architect --agent Évaluez le plan`
- Exemple incorrect : `/multi-role qa,architect Évaluez le plan --agent`

### Options

- `--agent` ou `-a` : Exécuter chaque rôle en tant que sous-agent en parallèle (recommandé pour l'analyse à grande échelle)
  - Lors de l'utilisation de cette option, si les descriptions de rôle incluent des phrases de délégation proactive (comme "utiliser PROACTIVEMENT"), une délégation automatique plus agressive devient activée

### Exemples de base

```bash
# Analyse double de sécurité et performance (normal)
/multi-role security,performance
"Évaluez ce point de terminaison API"

# Analyse parallèle de système à grande échelle (sous-agents)
/multi-role security,performance --agent
"Analysez de manière exhaustive la sécurité et les performances du système"

# Analyse intégrée de frontend, mobile et performance
/multi-role frontend,mobile,performance
"Considérez les propositions d'optimisation pour cet écran"

# Évaluation multifacette de conception d'architecture (sous-agents)
/multi-role architect,security,performance --agent
"Évaluez la conception de microservices"
```

### Processus d'analyse

### Phase 1 : Analyse parallèle

Chaque rôle analyse indépendamment la même cible

- Effectuer une évaluation depuis une perspective spécialisée
- Porter des jugements basés sur des critères spécifiques au rôle
- Générer des recommandations indépendantes

### Phase 2 : Analyse intégrée

Structurer et intégrer les résultats

- Organiser les résultats d'évaluation de chaque rôle
- Identifier les chevauchements et contradictions
- Clarifier les relations complémentaires

### Phase 3 : Rapport intégré

Générer les recommandations finales

- Plan d'action priorisé
- Compromis explicites
- Feuille de route d'implémentation

### Exemples de format de sortie

### Pour une analyse à 2 rôles

```text
Analyse multi-rôles : Sécurité + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Cible d'analyse : Point de terminaison API /api/users

Résultats d'analyse de sécurité :
Authentification : Vérification JWT correctement implémentée
Autorisation : Contrôle d'accès basé sur les rôles incomplet
Chiffrement : Clés API journalisées en texte brut

Score d'évaluation : 65/100
Importance : Élevée (due à l'accès aux données sensibles)

Résultats d'analyse de performance :
Temps de réponse : Moyenne 180ms (dans l'objectif de 200ms)
Requêtes base de données : Problème N+1 détecté
Cache : Cache Redis non implémenté

Score d'évaluation : 70/100
Importance : Moyenne (actuellement dans la plage acceptable)

Analyse interconnectée :
Opportunités synergiques :
- Considérer le chiffrement lors de l'implémentation du cache Redis
- Améliorer la journalisation pour des gains en sécurité et performance

Points de compromis :
- Renforcement vérification autorisation ↔ Impact sur le temps de réponse
- Chiffrement des logs ↔ Efficacité de débogage réduite

Priorités intégrées :
Critique : Corriger la sortie en texte brut des clés API
Élevé : Résoudre les requêtes N+1
Moyen : Implémenter cache Redis + chiffrement
Faible : Affiner le contrôle d'autorisation

Feuille de route d'implémentation :
Semaine 1 : Implémenter le masquage des clés API
Semaine 2 : Optimisation des requêtes base de données
Semaines 3-4 : Conception et implémentation de la couche cache
Mois 2 : Renforcement progressif du contrôle d'autorisation
```

### Pour une analyse à 3 rôles

```text
Analyse multi-rôles : Frontend + Mobile + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Cible d'analyse : Écran de profil utilisateur

Résultats d'analyse frontend :
Utilisabilité : Mise en page intuitive
Accessibilité : 85% de conformité WCAG 2.1
Responsive : Problèmes avec l'affichage tablette

Résultats d'analyse mobile :
Cibles tactiles : 44pt+ assurés
Utilisation à une main : Boutons importants placés en haut
Support hors ligne : Non implémenté

Résultats d'analyse performance :
Affichage initial : LCP 2.1s (bon)
Optimisation d'images : WebP non supporté
Chargement paresseux : Non implémenté

Recommandations intégrées :
1. Optimisation mobile (utilisation à une main + support hors ligne)
2. Optimisation d'images (WebP + chargement paresseux)
3. Améliorations UI tablette

Priorité : Mobile > Performance > Frontend
Période d'implémentation : 3-4 semaines
```

### Patterns de combinaison efficaces

### Focus sécurité

```bash
/multi-role security,architect
"Conception système d'authentification"

/multi-role security,frontend
"Sécurité écran de connexion"

/multi-role security,mobile
"Protection des données d'application mobile"
```

### Focus performance

```bash
/multi-role performance,architect
"Conception d'évolutivité"

/multi-role performance,frontend
"Optimisation vitesse de page web"

/multi-role performance,mobile
"Optimisation performance d'app"
```

### Focus expérience utilisateur

```bash
/multi-role frontend,mobile
"UI cross-platform"

/multi-role frontend,performance
"Équilibre entre UX et performance"

/multi-role mobile,performance
"Optimisation UX mobile"
```

### Analyse complète

```bash
/multi-role architect,security,performance
"Évaluation système globale"

/multi-role frontend,mobile,performance
"Évaluation exhaustive expérience utilisateur"

/multi-role security,performance,mobile
"Diagnostic exhaustif application mobile"
```

### Collaboration avec Claude

```bash
# Combiner avec analyse de fichier
cat src/components/UserProfile.tsx
/multi-role frontend,mobile
"Évaluez ce composant sous multiples perspectives"

# Évaluer documents de conception
cat architecture-design.md
/multi-role architect,security,performance
"Évaluez cette conception à travers multiples spécialités"

# Analyse d'erreur
cat performance-issues.log
/multi-role performance,analyzer
"Analysez les problèmes de performance sous multiples angles"
```

### Choisir entre multi-role et role-debate

### Quand utiliser multi-role

- Vous voulez des évaluations indépendantes de chaque spécialité
- Vous voulez créer un plan d'amélioration intégré
- Vous voulez organiser les contradictions et chevauchements
- Vous voulez déterminer les priorités d'implémentation

### Quand utiliser role-debate

- Il y a des compromis entre spécialités
- Les opinions pourraient différer sur la sélection de technologie
- Vous voulez décider les politiques de conception par discussion
- Vous voulez entendre des débats de différentes perspectives

### Exécution parallèle de sous-agents (--agent)

L'utilisation de l'option `--agent` exécute chaque rôle en tant que sous-agent indépendant en parallèle.

#### Promotion de délégation automatique

Si les descriptions de fichier de rôle incluent des phrases comme celles-ci, une délégation automatique plus proactive est activée lors de l'utilisation de `--agent` :

- "utiliser PROACTIVEMENT"
- "DOIT ÊTRE UTILISÉ"
- Autres expressions d'emphase

#### Flux d'exécution

```text
Exécution normale :
Rôle 1 → Rôle 2 → Rôle 3 → Intégration
(Exécution séquentielle, approx. 3-5 minutes)

Exécution --agent :
Rôle 1 ─┐
Rôle 2 ─┼→ Intégration
Rôle 3 ─┘
(Exécution parallèle, approx. 1-2 minutes)
```

#### Exemples d'usage efficaces

```bash
# Évaluation exhaustive de système à grande échelle
/multi-role architect,security,performance,qa --agent
"Évaluation exhaustive du nouveau système"

# Analyse détaillée sous multiples perspectives
/multi-role frontend,mobile,performance --agent
"Analyse complète d'optimisation UX écran"
```

#### Comparaison de performance

| Nombre de rôles | Exécution normale | Exécution --agent | Taux de réduction |
| --------------- | ----------------- | ----------------- | ----------------- |
| 2 rôles         | 2-3 minutes       | 1 minute          | 50%               |
| 3 rôles         | 3-5 minutes       | 1-2 minutes       | 60%               |
| 4 rôles         | 5-8 minutes       | 2-3 minutes       | 65%               |

### Remarques

- L'exécution simultanée de 3 rôles ou plus résulte en une sortie plus longue
- Les analyses complexes peuvent prendre plus de temps à exécuter
- Si des recommandations contradictoires surviennent, considérez l'utilisation de role-debate
- Les jugements finaux doivent être faits par l'utilisateur en référence aux résultats intégrés
- **Lors de l'utilisation de --agent** : Consomme plus de ressources mais est efficace pour les analyses à grande échelle
