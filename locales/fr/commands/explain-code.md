## Explication de code

Explique en détail comment fonctionne le code.

### Utilisation

```bash
# Montrer un fichier et demander une explication
cat <fichier>
"Expliquez comment ce code fonctionne"
```

### Exemples de base

```bash
# Comprendre la propriété Rust
cat main.rs
"Expliquez la propriété et les durées de vie dans ce code Rust"

# Expliquer un algorithme
grep -A 50 "quicksort" sort.rs
"Comment fonctionne ce tri ? Quelle est sa complexité temporelle ?"

# Expliquer les motifs de conception
cat factory.rs
"Quel motif de conception est-ce ? Quels sont les avantages ?"
```

### Collaboration avec Claude

```bash
# Explication pour débutants
cat complex_function.py
"Expliquez ce code ligne par ligne pour quelqu'un nouveau en programmation"

# Vérification de performance
cat algorithm.rs
"Trouvez les problèmes de performance et comment les corriger"

# Explication visuelle
cat state_machine.js
"Montrez-moi le flux avec des diagrammes ASCII"

# Vérification de sécurité
cat auth_handler.go
"Quels problèmes de sécurité voyez-vous ?"
```

### Exemples détaillés

```bash
# Décomposition de logique complexe
cat recursive_parser.rs
"Décomposez ce parseur récursif :
1. Comment le flux fonctionne-t-il ?
2. Que fait chaque fonction ?
3. Comment les cas limites sont-ils gérés ?
4. Qu'est-ce qui pourrait être amélioré ?"

# Explication de code asynchrone
cat async_handler.ts
"Expliquez ce code asynchrone :
1. Comment les Promises s'enchaînent-elles ?
2. Comment les erreurs sont-elles gérées ?
3. Qu'est-ce qui s'exécute en parallèle ?
4. Cela pourrait-il causer un interblocage ?"

# Vue d'ensemble de l'architecture
ls -la src/ && cat src/main.rs src/lib.rs
"Expliquez comment ce projet est structuré"
```

### Ce que vous obtiendrez

Pas seulement ce que fait le code, mais aussi :

- Pourquoi il est écrit de cette façon
- Quels avantages il procure
- Quels problèmes pourraient survenir
