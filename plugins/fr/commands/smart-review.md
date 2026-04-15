# Suggestion automatique du rôle et de l'approche optimaux

Une commande qui analyse la situation actuelle et suggère automatiquement le rôle et l'approche optimaux.

## Utilisation

```bash
/smart-review                    # Analyser le répertoire courant
/smart-review <fichier/répertoire>   # Analyser une cible spécifique
```

## Logique d'analyse automatique

## Analyse par extension de fichier

- `package.json`, `*.tsx`, `*.jsx`, `*.css`, `*.scss` → **frontend**
- `Dockerfile`, `docker-compose.yml`, `*.yaml` → **architect**
- `*.test.js`, `*.spec.ts`, `test/`, `__tests__/` → **qa**
- `*.rs`, `Cargo.toml`, `performance/` → **performance**

## Détection de fichiers liés à la sécurité

- `auth.js`, `security.yml`, `.env`, `config/auth/` → **security**
- `login.tsx`, `signup.js`, `jwt.js` → **security + frontend**
- `api/auth/`, `middleware/auth/` → **security + architect**

## Motifs d'analyse complexes

- `mobile/` + `*.swift`, `*.kt`, `react-native/` → **mobile**
- `webpack.config.js`, `vite.config.js`, `large-dataset/` → **performance**
- `components/` + `responsive.css` → **frontend + mobile**
- `api/` + `auth/` → **security + architect**

## Analyse d'erreurs/problèmes

- Piles d'appels, `error.log`, `crash.log` → **analyzer**
- `memory leak`, `high CPU`, `slow query` → **performance + analyzer**
- `SQL injection`, `XSS`, `CSRF` → **security + analyzer**

## Motifs de suggestions

## Suggestion de rôle unique

```bash
$ /smart-review src/auth/login.js
→ "Authentication file detected"
→ "Analysis with security role recommended"
→ "Execute? [y]es / [n]o / [m]ore options"
```

## Suggestion de rôles multiples

```bash
$ /smart-review src/mobile/components/
→ "📱🎨 Mobile + Frontend elements detected"
→ "Recommended approaches:"
→ "[1] mobile role alone"
→ "[2] frontend role alone"
→ "[3] multi-role mobile,frontend"
→ "[4] role-debate mobile,frontend"
```

## Suggestions pour l'analyse de problèmes

```bash
$ /smart-review error.log
→ "⚠️ Error log detected"
→ "Starting root cause analysis with analyzer role"
→ "[Auto-execute] /role analyzer"

$ /smart-review slow-api.log
→ "🐌 Performance issue detected"
→ "Recommended: [1]/role performance [2]/role-debate performance,analyzer"
```

## Suggestions pour les décisions de conception complexes

```bash
$ /smart-review architecture-design.md
→ "🏗️🔒⚡ Architecture + Security + Performance elements detected"
→ "For complex design decisions, debate format recommended"
→ "[Recommended] /role-debate architect,security,performance"
→ "[Alternative] /multi-role architect,security,performance"
```

## Détails de la logique de suggestion

## Évaluation de priorité

1. **Sécurité** - L'authentification, l'autorisation et le chiffrement sont priorités absolues
2. **Erreurs critiques** - Les pannes système et pertes de données sont urgentes
3. **Architecture** - Les changements à grande échelle et la sélection technologique nécessitent une réflexion approfondie
4. **Performance** - Impact direct sur l'expérience utilisateur
5. **Frontend/Mobile** - Améliorations UI/UX
6. **QA** - Assurance qualité et tests

## Conditions pour recommander un débat

- Quand 3 rôles ou plus sont impliqués
- Quand il y a un compromis entre sécurité et performance
- Quand des changements architecturaux significatifs sont impliqués
- Quand mobile et web sont affectés

## Exemples de base

```bash
# Analyser le répertoire courant
/smart-review
"Suggest the optimal role and approach"

# Analyser un fichier spécifique
/smart-review src/auth/login.js
"Suggest the best review method for this file"

# Analyser un journal d'erreurs
/smart-review error.log
"Suggest the best approach to resolve this error"
```

## Exemples pratiques

## Analyse de projet complet

```bash
$ /smart-review
→ "📊 Analyzing project..."
→ "React + TypeScript project detected"
→ "Authentication functionality + API + mobile support confirmed"
→ ""
→ "💡 Recommended workflow:"
→ "1. Check authentication with security"
→ "2. Evaluate UI/UX with frontend"
→ "3. Confirm mobile optimization with mobile"
→ "4. Review overall design with architect"
→ ""
→ "Auto-execute? [y]es / [s]elect role / [c]ustom"
```

## Analyse de problème spécifique

```bash
$ /smart-review "How to set JWT expiration time"
→ "🤔 Technical design decision detected"
→ "This issue requires multiple expert perspectives"
→ ""
→ "Recommended approach:"
→ "/role-debate security,performance,frontend"
→ "Reason: Balance between security, performance, and UX is important"
```

## Collaboration avec Claude

```bash
# Analyse combinée avec contenu de fichier
cat src/auth/middleware.js
/smart-review
"Analyze this file from a security perspective"

# Analyse combinée avec erreurs
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
"Suggest ways to resolve build errors"

# Consultation de conception
/smart-review
"Discuss whether to choose React Native or Progressive Web App"
```

## Notes

- Les suggestions sont seulement pour référence. La décision finale revient à l'utilisateur
- Le format débat (role-debate) est recommandé pour les questions complexes
- Un rôle unique est souvent suffisant pour les problèmes simples
- Les questions liées à la sécurité doivent toujours être confirmées avec un rôle spécialisé
