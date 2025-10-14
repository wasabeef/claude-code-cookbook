## Motifs de conception

Suggère des motifs de conception pour votre code et vérifie s'il suit les principes SOLID.

### Utilisation

```bash
/design-patterns [cible_analyse] [options]
```

### Options

- `--suggest` : Suggérer les motifs applicables (par défaut)
- `--analyze` : Analyser l'usage des motifs existants
- `--refactor` : Générer des propositions de refactorisation
- `--solid` : Vérifier la conformité aux principes SOLID
- `--anti-patterns` : Détecter les anti-motifs

### Exemples de base

```bash
# Analyser les motifs pour l'ensemble du projet
/design-patterns

# Suggérer des motifs pour un fichier spécifique
/design-patterns src/services/user.js --suggest

# Vérifier les principes SOLID
/design-patterns --solid

# Détecter les anti-motifs
/design-patterns --anti-patterns
```

### Catégories de motifs

#### 1. Motifs de création

- **Motif Factory** : Abstrait la création d'objets
- **Motif Builder** : Construction étape par étape d'objets complexes
- **Motif Singleton** : Assure qu'une seule instance existe
- **Motif Prototype** : Crée des clones d'objets

#### 2. Motifs structurels

- **Motif Adapter** : Convertit les interfaces
- **Motif Decorator** : Ajoute dynamiquement des fonctionnalités
- **Motif Facade** : Simplifie les sous-systèmes complexes
- **Motif Proxy** : Contrôle l'accès aux objets

#### 3. Motifs comportementaux

- **Motif Observer** : Implémente les notifications d'événements
- **Motif Strategy** : Change les algorithmes
- **Motif Command** : Encapsule les opérations
- **Motif Iterator** : Parcourt les collections

### Principes SOLID que nous vérifions

```text
S - Responsabilité Unique (une classe, un rôle)
O - Ouvert/Fermé (ouvert à l'extension, fermé à la modification)
L - Substitution de Liskov (les sous-types doivent être remplaçables)
I - Ségrégation d'Interface (ne pas forcer des méthodes inutilisées)
D - Inversion de Dépendance (dépendre d'abstractions, pas de détails)
```

### Exemple de sortie

```text
Rapport d'analyse de motifs de conception
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Motifs actuellement utilisés
├─ Motif Observer : EventEmitter (12 instances)
├─ Motif Factory : UserFactory (3 instances)
├─ Motif Singleton : DatabaseConnection (1 instance)
└─ Motif Strategy : PaymentProcessor (5 instances)

Motifs recommandés
├─ [ÉLEVÉ] Motif Repository
│  └─ Où : src/models/*.js
│  └─ Pourquoi : Séparer l'accès aux données de la logique métier
│  └─ Exemple :
│      class UserRepository {
│        async findById(id) { ... }
│        async save(user) { ... }
│      }
│
├─ [MOYEN] Motif Command
│  └─ Où : src/api/handlers/*.js
│  └─ Pourquoi : Standardiser la gestion des requêtes
│
└─ [FAIBLE] Motif Decorator
   └─ Où : src/middleware/*.js
   └─ Pourquoi : Meilleure façon de combiner les fonctionnalités

Violations SOLID trouvées
├─ [S] UserService : Fait trop de choses (auth ET autorisation)
├─ [O] PaymentGateway : Doit changer le code pour ajouter des types de paiement
├─ [D] EmailService : Dépend de classes spécifiques, pas d'interfaces
└─ [I] IDataStore : A des méthodes que personne n'utilise

Comment corriger
1. Diviser UserService en AuthService et AuthorizationService
2. Ajouter une interface PaymentStrategy pour nouveaux types de paiement
3. Créer une interface EmailService
4. Diviser IDataStore en interfaces plus petites
```

### Exemples d'usage avancés

```bash
# Voir ce qui arrive si vous utilisez un motif
/design-patterns --impact-analysis Repository

# Obtenir du code d'exemple pour un motif
/design-patterns --generate Factory --for src/models/Product.js

# Trouver des motifs qui fonctionnent bien ensemble
/design-patterns --combine --context "API avec cache"

# Vérifier votre architecture
/design-patterns --architecture MVC
```

### Exemple : Avant et Après

#### Avant (Code problématique)

```javascript
class OrderService {
  processOrder(order, paymentType) {
    if (paymentType === "credit") {
      // Traitement carte de crédit
    } else if (paymentType === "paypal") {
      // Traitement PayPal
    }
    // Autres méthodes de paiement...
  }
}
```

#### Après (Application du motif Strategy)

```javascript
// Interface Strategy
class PaymentStrategy {
  process(amount) {
    throw new Error("Doit implémenter la méthode process");
  }
}

// Stratégies concrètes
class CreditCardPayment extends PaymentStrategy {
  process(amount) {
    /* Implémentation */
  }
}

// Contexte
class OrderService {
  constructor(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  processOrder(order) {
    this.paymentStrategy.process(order.total);
  }
}
```

### Anti-motifs que nous trouvons

- **Objet Dieu** : Classes qui font tout
- **Code Spaghetti** : Enchevêtrement de flux de contrôle
- **Programmation Copier-Coller** : Le même code partout
- **Nombres Magiques** : Nombres aléatoires sans explication
- **Enfer des Callbacks** : Callbacks dans des callbacks dans des callbacks

### Bonnes pratiques

1. **Aller doucement** : Ajouter les motifs un à la fois
2. **Besoin d'abord** : N'utiliser les motifs que pour résoudre de vrais problèmes
3. **En parler** : Obtenir l'adhésion de l'équipe avant de gros changements
4. **L'écrire** : Documenter pourquoi vous avez choisi chaque motif
