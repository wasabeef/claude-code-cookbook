## Screenshot

Capture des captures d'écran sur macOS et analyse les images.

### Utilisation

```bash
/screenshot [options]
```

### Options

- Aucune : Sélectionner une fenêtre (Claude confirmera les options)
- `--window` : Capturer une fenêtre spécifique
- `--full` : Capturer tout l'écran
- `--crop` : Sélectionner une région à capturer

### Exemples de base

```bash
# Capturer et analyser une fenêtre
/screenshot --window
"Analyze the captured screen"

# Sélectionner une région et analyser
/screenshot --crop
"Explain the content of the selected region"

# Capturer l'écran complet et analyser
/screenshot --full
"Analyze the overall screen composition"
```

### Collaboration avec Claude

```bash
# Aucun problème spécifique - analyse de situation
/screenshot --crop
(Claude analysera automatiquement le contenu de l'écran, expliquant les éléments et la composition)

# Analyse de problème UI/UX
/screenshot --window
"Propose problems and improvements for this UI"

# Analyse d'erreur
/screenshot --window
"Tell me the cause and solution for this error message"

# Revue de design
/screenshot --full
"Evaluate this design from a UX perspective"

# Analyse de code
/screenshot --crop
"Point out problems in this code"

# Analyse de visualisation de données
/screenshot --crop
"Analyze trends visible in this graph"
```

### Exemples détaillés

```bash
# Analyse depuis plusieurs perspectives
/screenshot --window
"Analyze this screen regarding:
1. UI consistency
2. Accessibility issues
3. Improvement proposals"

# Captures multiples pour analyse comparative
/screenshot --window
# (Sauvegarder l'image avant)
# Effectuer des changements
/screenshot --window
# (Sauvegarder l'image après)
"Compare before and after images, analyzing changes and improvement effects"

# Focus sur des éléments spécifiques
/screenshot --crop
"Evaluate whether the selected button design harmonizes with other elements"
```

### Éléments interdits

- **Interdit de dire "capturé" quand aucune capture d'écran n'a été prise**
- **Interdit de tenter l'analyse de fichiers image inexistants**
- **La commande `/screenshot` ne capture pas réellement de captures d'écran**

### Notes

- Si aucune option n'est spécifiée, veuillez présenter les choix suivants :

  ```
  "How would you like to capture the screenshot?
  1. Select window (--window) → screencapture -W
  2. Full screen (--full) → screencapture -x
  3. Select region (--crop) → screencapture -i"
  ```

- Commencer l'analyse d'image après que l'utilisateur ait exécuté la commande screencapture
- Spécifier des problèmes ou perspectives spécifiques permet une analyse plus ciblée
