## Recherche Web Gemini

Exécutez des recherches web via Gemini CLI pour obtenir les informations les plus récentes.

### Utilisation

```bash
# Recherche web via Gemini CLI (requis)
gemini --prompt "WebSearch: <requête_recherche>"
```

### Exemples de base

```bash
# Utilisation de Gemini CLI
gemini --prompt "WebSearch: React 19 nouvelles fonctionnalités"
gemini --prompt "WebSearch: TypeError Cannot read property of undefined solution"
```

### Collaboration avec Claude

```bash
# Recherche et résumé de documents
gemini --prompt "WebSearch: Next.js 14 App Router documentation officielle"
"Résumez les résultats de recherche et expliquez les principales fonctionnalités"

# Investigation d'erreur
cat error.log
gemini --prompt "WebSearch: [message_erreur] solution"
"Proposez la solution la plus appropriée à partir des résultats de recherche"

# Comparaison de technologies
gemini --prompt "WebSearch: Rust vs Go benchmark performance 2024"
"Résumez les différences de performance à partir des résultats de recherche"
```

### Exemples détaillés

```bash
# Collecte d'informations depuis plusieurs sources
gemini --prompt "WebSearch: GraphQL bonnes pratiques 2024 sources multiples"
"Résumez les informations de plusieurs sources fiables dans les résultats de recherche"

# Investigation des changements dans le temps
gemini --prompt "WebSearch: JavaScript ES2015 ES2016 ES2017 ES2018 ES2019 ES2020 ES2021 ES2022 ES2023 ES2024 fonctionnalités"
"Résumez les principaux changements de chaque version par ordre chronologique"

# Recherche limitée à un domaine spécifique
gemini --prompt "WebSearch: site:github.com Rust WebAssembly projets stars:>1000"
"Listez les 10 meilleurs projets par nombre d'étoiles"

# Informations de sécurité récentes
gemini --prompt "WebSearch: CVE-2024 Node.js vulnérabilités"
"Résumez l'impact et les contre-mesures des vulnérabilités trouvées"
```

### Éléments interdits

- **Interdit d'utiliser l'outil WebSearch intégré de Claude**
- Quand une recherche web est nécessaire, utilisez toujours `gemini --prompt "WebSearch: ..."`

### Notes importantes

- **Quand Gemini CLI est disponible, utilisez toujours `gemini --prompt "WebSearch: ..."`**
- Les résultats de recherche web ne sont pas toujours les plus récents
- Il est recommandé de vérifier les informations importantes avec la documentation officielle ou des sources fiables
