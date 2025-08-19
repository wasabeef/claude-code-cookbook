## Analyze Performance

Trouve les goulots d'étranglement de performance et suggère des corrections basées sur l'analyse de la dette technique.

### Utilisation

```bash
# Trouver les problèmes de performance de manière globale
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Show me the big files and performance problems, then suggest fixes"

# Repérer les motifs inefficaces
grep -r "for.*await\|forEach.*await" . --include="*.js"
"Find N+1 queries and other performance killers"

# Vérifier les fuites mémoire
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
"Where might we have memory leaks and how do we fix them?"
```

### Exemples de base

```bash
# Vérifier la taille du bundle et le temps de chargement
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"How can we shrink bundles and optimize assets?"

# Performance des requêtes base de données
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"Which database queries need optimization?"

# Impact performance des dépendances
npm outdated && npm audit
"Are outdated dependencies slowing us down?"
```

### Ce que nous recherchons

#### 1. Problèmes au niveau du code

- **Algorithmes O(n²)** : Opérations de tableau lentes qui ne passent pas à l'échelle
- **I/O synchrone** : Opérations bloquantes qui figent tout
- **Traitement redondant** : Faire le même travail encore et encore
- **Fuites mémoire** : Écouteurs d'événements et timers laissés en marche

#### 2. Problèmes d'architecture

- **Requêtes N+1** : Trop d'allers-retours vers la base de données
- **Cache manquant** : Répéter des opérations coûteuses
- **Gonflement du bundle** : Livrer du code dont les utilisateurs n'ont pas besoin
- **Gaspillage de ressources** : Mauvaise gestion des connexions et threads

#### 3. Impact de la dette technique

- **Code legacy** : Anciennes implémentations qui nous ralentissent
- **Conception défaillante** : Tout est trop étroitement couplé
- **Tests manquants** : Les régressions de performance passent inaperçues
- **Angles morts** : On ne peut pas voir les problèmes avant qu'il ne soit trop tard

### Priorités d'amélioration

```
🔴 Critique : Risque de panne système
├─ Fuites mémoire (plantages serveur)
├─ Requêtes N+1 (charge base de données)
└─ I/O synchrone (retards de réponse)

🟡 Haute : Impact sur l'expérience utilisateur
├─ Taille du bundle (temps chargement initial)
├─ Optimisation d'images (vitesse d'affichage)
└─ Stratégie de mise en cache (vitesse de réponse)

🟢 Moyenne : Efficacité opérationnelle
├─ Mises à jour de dépendances (sécurité)
├─ Duplication de code (maintenabilité)
└─ Surveillance améliorée (charge opérationnelle)
```

### Mesures et outils

#### Node.js / JavaScript

```bash
# Profilage
node --prof app.js
clinic doctor -- node app.js

# Analyse de bundle
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### Base de données

```sql
-- Analyse des requêtes
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```

#### Frontend

```bash
# Performance React
grep -r "useMemo\|useCallback" . --include="*.jsx"

# Analyse des ressources
find ./src -name "*.png" -o -name "*.jpg" | xargs ls -lh
```

### Amélioration continue

- **Vérifications hebdomadaires** : Exécuter régulièrement les tests de performance
- **Suivre les métriques** : Observer les temps de réponse et l'utilisation mémoire
- **Définir des alertes** : Être notifié quand les choses ralentissent
- **Partager les connaissances** : Documenter ce qui fonctionne et ce qui ne fonctionne pas
