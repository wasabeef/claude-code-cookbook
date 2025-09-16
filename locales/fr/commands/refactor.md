## Refactor

Implémente une refactorisation de code sûre et progressive, évalue quantitativement le respect des principes SOLID. Visualise la dette technique et clarifie les priorités d'amélioration.

### Utilisation

```bash
# Identification de code complexe et plan de refactorisation
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"Refactorisez ces gros fichiers pour réduire la complexité"

# Détection et intégration de code dupliqué
grep -r "function processUser" . --include="*.js"
"Unifiez ces fonctions dupliquées avec Extract Method"

# Détection des violations des principes SOLID
grep -r "class.*Service" . --include="*.js" | head -10
"Évaluez si ces classes suivent le principe de responsabilité unique"
```

### Exemples de base

```bash
# Détection de méthodes longues
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"Divisez les méthodes de plus de 50 lignes avec Extract Method"

# Complexité des branchements conditionnels
grep -r "if.*if.*if" . --include="*.js"
"Améliorez ces déclarations conditionnelles imbriquées avec le pattern Strategy"

# Détection des code smells
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"Résolvez les commentaires qui sont devenus de la dette technique"
```

### Techniques de refactorisation

#### Extract Method (Extraction de méthode)

```javascript
// Avant : Méthode étendue
function processOrder(order) {
  // 50 lignes de traitement complexe
}

// Après : Séparation des responsabilités
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### Replace Conditional with Polymorphism

```javascript
// Avant : instruction switch
function getPrice(user) {
  switch (user.type) {
    case "premium":
      return basePrice * 0.8;
    case "regular":
      return basePrice;
  }
}

// Après : pattern Strategy
class PremiumPricing {
  calculate(basePrice) {
    return basePrice * 0.8;
  }
}
```

### Score des principes SOLID (0-100 points)

#### Critères d'évaluation et notation

```text
S - Single Responsibility (20 points)
├─ Nombre de responsabilités de classe : 1 (20 pts) | 2 (15 pts) | 3 (10 pts) | 4+ (5 pts)
├─ Nombre de méthodes : <7 (+5 pts) | 7-15 (+3 pts) | >15 (0 pts)
├─ Clarté de la raison de changement : Claire (+5 pts) | Ambiguë (0 pts)
└─ Exemple de score : UserService(authentification+traitement de données) = 10 points

O - Open/Closed (20 points)
├─ Points d'extension : Strategy/Template Method (20 pts) | Héritage seul (10 pts) | Aucun (5 pts)
├─ Changements de code existant lors de l'ajout de nouvelles fonctions : Non nécessaire (+5 pts) | Minimal (+3 pts) | Nécessaire (0 pts)
├─ Utilisation d'interfaces : Appropriée (+5 pts) | Partielle (+3 pts) | Aucune (0 pts)
└─ Exemple de score : PaymentProcessor(Strategy) = 20 points

L - Liskov Substitution (20 points)
├─ Adhésion au contrat des classes dérivées : Complète (20 pts) | Partielle (10 pts) | Violation (0 pts)
├─ Renforcement des préconditions : Aucun (+5 pts) | Existe (-5 pts)
├─ Affaiblissement des postconditions : Aucun (+5 pts) | Existe (-5 pts)
└─ Exemple de score : Square extends Rectangle = 0 points (violation)

I - Interface Segregation (20 points)
├─ Taille d'interface : 1-3 méthodes (20 pts) | 4-7 (15 pts) | 8+ (5 pts)
├─ Implémentation de méthodes non utilisées : Aucune (+5 pts) | 1-2 (+2 pts) | 3+ (0 pts)
├─ Clarté du rôle : Rôle unique (+5 pts) | Multiples rôles (0 pts)
└─ Exemple de score : Séparation Readable/Writable = 20 points

D - Dependency Inversion (20 points)
├─ Direction de dépendance : Abstraction seule (20 pts) | Mixte (10 pts) | Concrète seule (5 pts)
├─ Utilisation de DI : Constructor Injection (+5 pts) | Setter (+3 pts) | Aucune (0 pts)
├─ Capacité de test : Mockable (+5 pts) | Difficile (0 pts)
└─ Exemple de score : Repository Pattern = 20 points

Score total = S + O + L + I + D
├─ 90-100 points : Excellent (Conformité SOLID complète)
├─ 70-89 points : Bon (Marge d'amélioration légère)
├─ 50-69 points : Acceptable (Refactorisation recommandée)
├─ 30-49 points : Pauvre (Amélioration à grande échelle nécessaire)
└─ 0-29 points : Critique (Révision de conception obligatoire)
```

### Quantification de la dette technique

#### Formule de calcul de la dette

```text
Dette technique (temps) = Score de complexité × Portée d'impact × Difficulté de correction

Score de complexité :
├─ Complexité cyclomatique : 1-5(faible) | 6-10(moyenne) | 11-20(élevée) | 21+(dangereuse)
├─ Complexité cognitive : Profondeur d'imbrication × Nombre de branchements conditionnels
├─ Lignes de code : <50(1 pt) | 50-200(2 pts) | 200-500(3 pts) | 500+(5 pts)
└─ Taux de duplication : 0-10%(1 pt) | 10-30%(2 pts) | 30-50%(3 pts) | 50%+(5 pts)

Portée d'impact :
├─ Nombre de modules dépendants : Dépendance directe + Dépendance indirecte × 0.5
├─ Fréquence d'utilisation : Nombre d'appels API/jour
├─ Importance métier : Critique(×3) | Élevée(×2) | Moyenne(×1) | Faible(×0.5)
└─ Connaissance de l'équipe : 1 personne qui comprend(×3) | 2-3(×2) | 4+(×1)

Difficulté de correction :
├─ Couverture de tests : 0%(×3) | <50%(×2) | 50-80%(×1.5) | >80%(×1)
├─ Documentation : Aucune(×2) | Insuffisante(×1.5) | Suffisante(×1)
├─ Relations de dépendance : Couplage fort(×3) | Modéré(×2) | Couplage faible(×1)
└─ Risque de changement : Breaking Change(×3) | Considération de compatibilité(×2) | Sûr(×1)

Conversion de coûts :
├─ Coût de temps : Temps de dette × Salaire horaire du développeur
├─ Coût d'opportunité : Jours de retard dans le développement de nouvelles fonctionnalités × Impact quotidien sur les ventes
├─ Coût de qualité : Probabilité d'apparition de bugs × Coût de correction × Fréquence d'apparition
└─ Coût total : Temps + Coût d'opportunité + Coût de qualité
```

#### Matrice de priorités

| Priorité                          | Degré d'impact | Coût de correction | Délai de réponse            | Exemple concret                                                           | Action recommandée                                       |
| --------------------------------- | -------------- | ------------------ | --------------------------- | ------------------------------------------------------------------------- | -------------------------------------------------------- |
| **Critical (Réponse immédiate)**  | Élevé          | Faible             | Dans 1 semaine              | God Object, dépendance circulaire                                         | Commencer la refactorisation immédiatement               |
| **Important (Réponse planifiée)** | Élevé          | Élevé              | Dans 1 mois                 | Séparation de responsabilités à grande échelle, changement d'architecture | Incorporer dans la planification de sprint               |
| **Watch (Objet de surveillance)** | Faible         | Élevé              | Dans 3 mois                 | Traitement interne de haute complexité                                    | Surveillance des métriques, réponse en cas d'aggravation |
| **Acceptable (Gamme acceptable)** | Faible         | Faible             | Ne nécessite pas de réponse | Code smells légers                                                        | Réponse avec refactorisation normale                     |

### Procédure de refactorisation

1. **Analyse et mesure de l'état actuel**
   - Mesure de complexité (cyclomatique ・ cognitive)
   - Calcul du score SOLID (0-100 points)
   - Quantification de la dette technique (temps/coût)
   - Création de matrice de priorités

2. **Exécution progressive**
   - Petites étapes (unités de 15-30 minutes)
   - Exécution de tests après chaque changement
   - Commits fréquents
   - Mesure continue du score SOLID

3. **Confirmation de qualité**
   - Maintien de la couverture de tests
   - Mesure de performance
   - Confirmation de réduction de la dette technique
   - Révision de code

### Code smells courants et score de dette

| Code Smell              | Critère de détection                     | Score de dette | Méthode d'amélioration         |
| ----------------------- | ---------------------------------------- | -------------- | ------------------------------ |
| **God Object**          | Responsabilités >3, méthodes >20         | Élevé (15-20h) | Extract Class, application SRP |
| **Long Method**         | Lignes >50, complexité >10               | Moyen (5-10h)  | Extract Method                 |
| **Duplicate Code**      | Taux de duplication >30%                 | Élevé (10-15h) | Extract Method/Class           |
| **Large Class**         | Lignes >300, méthodes >15                | Élevé (10-20h) | Extract Class                  |
| **Long Parameter List** | Paramètres >4                            | Faible (2-5h)  | Parameter Object               |
| **Feature Envy**        | Références à autres classes >5           | Moyen (5-10h)  | Move Method                    |
| **Data Clumps**         | Répétition du même groupe d'arguments    | Faible (3-5h)  | Extract Class                  |
| **Primitive Obsession** | Utilisation excessive de types primitifs | Moyen (5-8h)   | Replace with Object            |
| **Switch Statements**   | case >5                                  | Moyen (5-10h)  | Strategy Pattern               |
| **Shotgun Surgery**     | Zones affectées lors du changement >3    | Élevé (10-15h) | Move Method/Field              |

### Exemple pratique : Évaluation du score SOLID

```javascript
// Objet d'évaluation : classe UserService
class UserService {
  constructor(db, cache, logger, emailService) { // 4 dépendances
    this.db = db;
    this.cache = cache;
    this.logger = logger;
    this.emailService = emailService;
  }

  // Responsabilité 1 : authentification
  authenticate(username, password) { /* ... */ }
  refreshToken(token) { /* ... */ }

  // Responsabilité 2 : gestion des utilisateurs
  createUser(data) { /* ... */ }
  updateUser(id, data) { /* ... */ }
  deleteUser(id) { /* ... */ }

  // Responsabilité 3 : notification
  sendWelcomeEmail(user) { /* ... */ }
  sendPasswordReset(email) { /* ... */ }
}

// Résultat d'évaluation du score SOLID
S: 10 points (3 responsabilités : authentification, CRUD, notification)
O: 5 points (sans points d'extension, implémentation directe)
L: 15 points (sans héritage, non applicable)
I: 10 points (interface non ségrégée)
D: 10 points (dépendance de classes concrètes)
Total: 50 points (Acceptable - Refactorisation recommandée)

// Dette technique
Complexité: 15 (7 méthodes, 3 responsabilités)
Portée d'impact: 8 (authentification utilisée dans toutes les fonctions)
Difficulté de correction: 2 (avec tests, documentation insuffisante)
Temps de dette: 15 × 8 × 2 = 240 heures
Priorité: Critical (système d'authentification nécessite réponse immédiate)
```

### Exemple d'implémentation après amélioration

```javascript
// Après application des principes SOLID (Score : 90 points)

// S : Responsabilité unique (20 points)
class AuthenticationService {
  authenticate(credentials) { /* ... */ }
  refreshToken(token) { /* ... */ }
}

// O : Ouvert/fermé (20 points)
class UserRepository {
  constructor(storage) { // Strategy Pattern
    this.storage = storage;
  }
  save(user) { return this.storage.save(user); }
}

// I : Ségrégation d'interface (20 points)
interface Readable {
  find(id);
  findAll();
}
interface Writable {
  save(entity);
  delete(id);
}

// D : Inversion de dépendance (20 points)
class UserService {
  constructor(
    private auth: IAuthService,
    private repo: IUserRepository,
    private notifier: INotificationService
  ) {}
}

// Réduction de dette : 240 heures → 20 heures (92% de réduction)
```

### Support d'automatisation

```bash
# Mesure du score SOLID
npx solid-analyzer src/ --output report.json

# Analyse de complexité
npx complexity-report src/ --format json
sonar-scanner -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info

# Visualisation de la dette technique
npx code-debt-analyzer --config .debt.yml

# Format de code
npm run lint:fix
prettier --write src/

# Exécution de tests et couverture
npm test -- --coverage
npm run test:mutation  # tests de mutation
```

### Précautions

- **Interdiction de changements fonctionnels** : Ne pas changer le comportement externe
- **Test first** : Ajouter des tests avant la refactorisation
- **Approche progressive** : Ne pas faire de gros changements d'un coup
- **Vérification continue** : Exécution de tests à chaque étape
