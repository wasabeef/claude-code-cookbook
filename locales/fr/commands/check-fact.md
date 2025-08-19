## Vérification de fait

Vérifie si une affirmation est vraie en examinant le code et la documentation de votre projet.

### Utilisation

```bash
# Utilisation de base
/check-fact "L'application Flutter utilise Riverpod"

# Vérifier plusieurs faits à la fois
/check-fact "Ce projet utilise GraphQL et gère le routage avec auto_route"

# Vérifier les détails techniques
/check-fact "JWT est utilisé pour l'authentification, et Firebase Auth n'est pas utilisé"
```

### Comment cela fonctionne

1. **Où je regarde (dans l'ordre)**
   - Le code actuel (le plus fiable)
   - README.md et dossier docs/
   - Fichiers de configuration (package.json, pubspec.yaml, etc.)
   - Discussions d'issues et PR

2. **Ce que vous verrez**
   - `✅ Correct` - L'affirmation correspond exactement au code
   - `❌ Incorrect` - L'affirmation est fausse
   - `⚠️ Partiellement correct` - Certaines parties sont vraies, d'autres non
   - `❓ Impossible à déterminer` - Pas assez d'informations pour vérifier

3. **Preuves que je fournis**
   - Nom de fichier et numéro de ligne
   - Extraits de code pertinents
   - Documentation correspondante

### Format de rapport

```
## Résultats de vérification de fait

### Ce que vous avez demandé
"[Votre affirmation]"

### Verdict
[✅/❌/⚠️/❓] [Vrai/Faux/Partiel/Inconnu]

### Preuves
- **Fichier** : `chemin/vers/fichier.dart:123`
- **Code** : [Le code actuel]
- **Note** : [Pourquoi cela le prouve]

### Détails
[Si faux, voici ce qui est réellement vrai]
[Si partiel, voici ce qui manque]
[Si inconnu, voici ce que je devrais vérifier]
```

### Exemples de base

```bash
# Vérifier la pile technologique
/check-fact "Cette app est construite avec Flutter + Riverpod + GraphQL"

# Vérifier si une fonctionnalité existe
/check-fact "Le mode sombre est implémenté et peut être activé depuis les paramètres utilisateur"

# Vérifier les choix d'architecture
/check-fact "Toute la gestion d'état est faite avec Riverpod, BLoC n'est pas utilisé"

# Vérifier la configuration de sécurité
/check-fact "Les tokens d'authentification sont chiffrés et stockés dans un stockage sécurisé"
```

### Collaboration avec Claude

```bash
# Vérifier les dépendances
ls -la && find . -name "pubspec.yaml" -exec cat {} \;
/check-fact "Les principales dépendances utilisées dans ce projet sont..."

# Vérifier comment quelque chose est construit
grep -r "authentication" . --include="*.dart"
/check-fact "L'authentification est construite sur mesure, n'utilise pas d'auth tiers"

# Vérifier si la documentation correspond à la réalité
cat README.md
/check-fact "Tout dans le README est réellement implémenté"
```

### Quand utiliser ceci

- Rédaction de spécifications : S'assurer que vos descriptions sont exactes
- Reprendre un projet : Vérifier si vous le comprenez correctement
- Mises à jour client : Vérifier ce qui est réellement construit
- Articles de blog : Vérifier les faits de votre contenu technique
- Présentations : Confirmer les détails du projet avant de présenter

### Important

- Le code surpasse la documentation : S'ils ne concordent pas, le code a raison
- La documentation ancienne arrive : L'implémentation est ce qui compte
- Pas de devinettes : Si je ne peux pas le vérifier, je le dirai
- La sécurité compte : Extra prudent avec les faits liés à la sécurité
