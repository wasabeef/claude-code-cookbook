## Refactorisation

Nettoie le code de manière sécurisée étape par étape et vérifie les principes SOLID.

### Utilisation

```bash
# Trouver du code complexe à refactoriser
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"Rendez ces gros fichiers plus simples"

# Trouver du code dupliqué
grep -r "function processUser" . --include="*.js"
"Combinez ces fonctions dupliquées"

# Vérifier les principes SOLID
grep -r "class.*Service" . --include="*.js" | head -10
"Ces classes n'ont-elles qu'un seul rôle ?"
```

### Exemples de base

```bash
# Trouver les méthodes longues
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"Divisez les méthodes de plus de 50 lignes"

# Trouver les conditions complexes
grep -r "if.*if.*if" . --include="*.js"
"Simplifiez ces conditions imbriquées"

# Trouver les défauts de code
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"Corrigez ces commentaires TODO"
```

### Techniques de refactorisation

#### Extraire une méthode (Diviser les grandes fonctions)

```javascript
// Avant : Méthode longue
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

#### Remplacer les conditions par du polymorphisme (Supprimer les chaînes Switch/If)

```javascript
// Avant : instruction switch
function getPrice(user) {
  switch (user.type) {
    case 'premium': return basePrice * 0.8;
    case 'regular': return basePrice;
  }
}

// Après : Pattern Strategy
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### Principes SOLID que nous vérifions

```
S - Responsabilité Unique
├─ Une classe = un rôle
├─ Une seule raison de changer
└─ Limites claires

O - Ouvert/Fermé
├─ Facile à étendre
├─ Ne pas modifier le code existant
└─ Ajouter des fonctionnalités sans casser

L - Substitution de Liskov
├─ Les classes filles peuvent remplacer les parents
├─ Conserver le même comportement
└─ Ne pas briser les attentes

I - Ségrégation d'Interface
├─ Interfaces petites et focalisées
├─ Pas de méthodes inutilisées
└─ Chaque interface pour un rôle spécifique

D - Inversion de Dépendance
├─ Dépendre d'interfaces, pas de classes
├─ Garder les implémentations séparées
└─ Utiliser l'injection de dépendance
```

### Comment refactoriser en sécurité

1. **Vérifier l'état actuel**
   - Mesurer la complexité
   - Trouver le code dupliqué
   - Mapper les dépendances

2. **Faire de petits changements**
   - Blocs de 15-30 minutes
   - Tester après chaque changement
   - Commiter souvent

3. **Vérifier la qualité**
   - Maintenir les tests passants
   - Vérifier les performances
   - Faire réviser le code

### Défauts de code à corriger

- **Objet Dieu** : Classes qui font tout
- **Méthode longue** : Fonctions de plus de 50 lignes
- **Code dupliqué** : Même logique dans plusieurs endroits
- **Classe volumineuse** : Classes de plus de 300 lignes
- **Liste de paramètres longue** : Plus de 3 paramètres

### Support d'automatisation

```bash
# Analyse statique
npx complexity-report src/
sonar-scanner

# Formatage de code
npm run lint:fix
prettier --write src/

# Exécution de tests
npm test
npm run test:coverage
```

### Règles importantes

- **Ne pas casser** : Conserver le même comportement
- **Tester d'abord** : Écrire des tests avant de changer le code
- **Petites étapes** : Pas de changements énormes d'un coup
- **Tester souvent** : Exécuter les tests après chaque changement
