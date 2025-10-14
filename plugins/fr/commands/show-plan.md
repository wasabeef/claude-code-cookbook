## Afficher plan

Affiche le plan en cours d'exécution ou exécuté dans la session actuelle.

### Utilisation

```bash
/show-plan
```

### Exemples de base

```bash
# Vérifier le plan actuel
/show-plan
"Afficher le plan en cours d'exécution"

# Quand aucun plan n'existe
/show-plan
"Il n'y a pas de plan dans la session actuelle"
```

### Fonctionnalités

- Détecte les plans créés avec exit_plan_mode
- Recherche les en-têtes contenant des mots-clés comme plan d'implémentation, détails d'implémentation, plan
- Formate et affiche le contenu du plan
- Notifie clairement quand aucun plan n'existe

### Collaboration avec Claude

```bash
# Vérifier le plan pendant l'implémentation
"Qu'est-ce que j'étais en train d'implémenter ?"
/show-plan

# Lors de l'exécution de tâches multiples
"Laissez-moi vérifier à nouveau le plan actuel"
/show-plan

# Réviser après l'exécution du plan
"Montrez-moi le plan que j'ai exécuté plus tôt"
/show-plan
```

### Patterns de détection

Basé sur le format des plans générés par exit_plan_mode, les patterns suivants sont détectés :

- En-têtes commençant par `##` (incluant Plan, Planification, Stratégie)
- `### Changes` (Changements)
- `### Implementation Details` (Détails d'implémentation)
- `### Implementation Plan` (Plan d'implémentation)
- En-têtes numérotés comme `### 1.`

### Remarques

- Affiche seulement les plans de la session actuelle (n'inclut pas les sessions passées)
- Affiche le plan le plus récent en priorité
