## PR Review

Assure la qualité du code et la solidité architecturale grâce à des revues systématiques de Pull Requests.

### Utilisation

```bash
# Revue complète de PR
gh pr view 123 --comments
"Systematically review this PR and provide feedback from code quality, security, and architecture perspectives"

# Revue axée sur la sécurité
gh pr diff 123
"Focus on reviewing security risks and vulnerabilities"

# Revue de perspective architecturale
gh pr checkout 123 && find . -name "*.js" | head -10
"Evaluate the architecture from the perspectives of layer separation, dependencies, and SOLID principles"
```

### Exemples de base

```bash
# Évaluation quantitative de la qualité du code
find . -name "*.js" -exec wc -l {} + | sort -rn | head -5
"Evaluate code complexity, function size, and duplication, and point out improvements"

# Vérification des vulnérabilités de sécurité
grep -r "password\|secret\|token" . --include="*.js" | head -10
"Check for risks of sensitive information leakage, hardcoding, and authentication bypass"

# Détection de violations architecturales
grep -r "import.*from.*\.\./\.\." . --include="*.js"
"Evaluate layer violations, circular dependencies, and coupling issues"
```

### Système de classification des commentaires

```
🔴 critical.must : Questions critiques
├─ Vulnérabilités de sécurité
├─ Problèmes d'intégrité des données
└─ Risques de panne système

🟡 high.imo : Améliorations haute priorité
├─ Risque de dysfonctionnement
├─ Problèmes de performance
└─ Diminution significative de la maintenabilité

🟢 medium.imo : Améliorations priorité moyenne
├─ Amélioration de la lisibilité
├─ Amélioration de la structure du code
└─ Amélioration de la qualité des tests

🟢 low.nits : Points mineurs
├─ Unification du style
├─ Corrections de typos
└─ Ajout de commentaires

🔵 info.q : Questions/informations
├─ Confirmation d'intention d'implémentation
├─ Contexte des décisions de conception
└─ Partage de bonnes pratiques
```

### Perspectives de revue

#### 1. Correction du code

- **Erreurs logiques** : Valeurs limites, vérifications null, gestion des exceptions
- **Intégrité des données** : Sécurité de type, validation
- **Gestion d'erreurs** : Complétude, traitement approprié

#### 2. Sécurité

- **Authentification/autorisation** : Vérifications appropriées, gestion des permissions
- **Validation d'entrée** : Contremesures injection SQL, XSS
- **Informations sensibles** : Restrictions de journalisation, chiffrement

#### 3. Performance

- **Algorithmes** : Complexité temporelle, efficacité mémoire
- **Base de données** : Requêtes N+1, optimisation d'index
- **Ressources** : Fuites mémoire, utilisation du cache

#### 4. Architecture

- **Séparation des couches** : Direction des dépendances, séparation appropriée
- **Couplage** : Couplage serré, utilisation d'interfaces
- **Principes SOLID** : Responsabilité unique, ouvert-fermé, inversion de dépendances

### Flux de revue

1. **Pré-vérification** : Informations PR, diff des changements, issues liées
2. **Vérifications systématiques** : Sécurité → Correction → Performance → Architecture
3. **Feedback constructif** : Suggestions d'amélioration spécifiques et exemples de code
4. **Suivi** : Confirmation des corrections, statut CI, approbation finale

### Exemples de commentaires efficaces

**Problèmes de sécurité**

```markdown
**critical.must.** Le mot de passe est stocké en texte brut

```javascript
// Correction proposée
const bcrypt = require('bcrypt');
const hashedPassword = await bcrypt.hash(password, 12);
```

Le hachage est requis pour prévenir les risques de sécurité.

```

**Amélioration des performances**
```markdown
**high.imo.** Problème de requête N+1 survient

```javascript
// Amélioration : Chargement anticipé
const users = await User.findAll({ include: [Post] });
```

Ceci peut réduire significativement le nombre de requêtes.

```

**Violation architecturale**
```markdown
**high.must.** Violation de couche survenue

La couche domaine dépend directement de la couche infrastructure.
Veuillez introduire une interface suivant le principe d'inversion de dépendances.
```

### Notes

- **Ton constructif** : Communication collaborative plutôt qu'agressive
- **Suggestions spécifiques** : Fournir des solutions en plus de signaler les problèmes
- **Priorisation** : Traiter dans l'ordre Critique → Haute → Moyenne → Basse
- **Amélioration continue** : Documenter les résultats de revue dans une base de connaissances
