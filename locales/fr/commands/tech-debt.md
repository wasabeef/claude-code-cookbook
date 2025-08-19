## Tech Debt

Trouve la dette technique dans votre projet et crée un plan de correction.

### Utilisation

```bash
# Vérifier la structure du projet pour la dette technique
ls -la
"Find the technical debt in this project and make a plan to fix it"
```

### Exemples de base

```bash
# Trouver les commentaires TODO/FIXME
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"Sort these TODOs by priority and tell me how to fix them"

# Vérifier les dépendances
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"Which dependencies are outdated? What are the risks?"

# Trouver les gros fichiers et le code complexe
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -exec wc -l {} + | sort -rn | head -10
"Which files are too big? How should we split them up?"
```

### Collaboration avec Claude

```bash
# Analyse complète de la dette technique
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"Check this project's tech debt:
1. Code quality (too complex? duplicated? hard to maintain?)
2. Are dependencies healthy?
3. Security problems?
4. Performance issues?
5. Missing tests?"

# Vérification de la dette architecturale
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"What's wrong with the architecture? How do we fix it?"

# Créer une liste de priorités
"Rate the tech debt and show me a table with:
- Impact (High/Medium/Low)
- Time to fix
- Business risk
- What we gain
- When to do it"
```

### Exemples détaillés

```bash
# Auto-détecter le type de projet et analyser
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"For this project type, check:
1. Language-specific debt
2. Where we break best practices
3. What can be modernized
4. Step-by-step fix plan"

# Vérification de la qualité du code
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"Check code quality:
- Which functions are too complex?
- Where's the duplicate code?
- What's too long?
- Where's error handling missing?"

# Vérification de la dette de sécurité
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"Find security problems and tell me what to fix first"

# Vérification de la couverture de tests
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"Where are tests missing? What's our testing strategy?"
```

### Notes

- Auto-détecte votre langue et framework
- Divise la dette en "corriger maintenant" vs "corriger plus tard"
- Équilibre les besoins métier avec les améliorations techniques
- Montre le ROI - ce que vous obtenez pour l'effort
