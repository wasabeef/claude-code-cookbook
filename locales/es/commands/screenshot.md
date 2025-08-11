## Captura de Pantalla

Capturar capturas de pantalla en macOS y analizar las imágenes.

### Uso

```bash
/screenshot [opciones]
```

### Opciones

- Ninguna: Seleccionar ventana (Claude confirmará opciones)
- `--window`: Capturar una ventana específica
- `--full`: Capturar toda la pantalla
- `--crop`: Seleccionar una región para capturar

### Ejemplos Básicos

```bash
# Capturar y analizar una ventana
/screenshot --window
"Analizar la pantalla capturada"

# Seleccionar una región y analizar
/screenshot --crop
"Explicar el contenido de la región seleccionada"

# Capturar pantalla completa y analizar
/screenshot --full
"Analizar la composición general de la pantalla"
```

### Colaboración con Claude

```bash
# Sin problema específico - análisis de situación
/screenshot --crop
(Claude analizará automáticamente el contenido de pantalla, explicando elementos y composición)

# Análisis de problema de UI/UX
/screenshot --window
"Proponer problemas y mejoras para esta UI"

# Análisis de error
/screenshot --window
"Dime la causa y solución para este mensaje de error"

# Revisión de diseño
/screenshot --full
"Evaluar este diseño desde una perspectiva UX"

# Análisis de código
/screenshot --crop
"Señalar problemas en este código"

# Análisis de visualización de datos
/screenshot --crop
"Analizar tendencias visibles en este gráfico"
```

### Ejemplos Detallados

```bash
# Análisis desde múltiples perspectivas
/screenshot --window
"Analizar esta pantalla respecto a:
1. Consistencia de UI
2. Problemas de accesibilidad
3. Propuestas de mejora"

# Múltiples capturas para análisis comparativo
/screenshot --window
# (Guardar imagen antes)
# Hacer cambios
/screenshot --window
# (Guardar imagen después)
"Comparar imágenes antes y después, analizando cambios y efectos de mejora"

# Enfoque en elementos específicos
/screenshot --crop
"Evaluar si el diseño del botón seleccionado armoniza con otros elementos"
```

### Elementos Prohibidos

- **Prohibido decir "capturado" cuando no se tomó captura de pantalla**
- **Prohibido intentar análisis de archivos de imagen inexistentes**
- **El comando `/screenshot` no captura capturas de pantalla realmente**

### Notas

- Si no se especifica opción, favor presentar las siguientes opciones:

  ```
  "¿Cómo te gustaría capturar la captura de pantalla?
  1. Seleccionar ventana (--window) → screencapture -W
  2. Pantalla completa (--full) → screencapture -x
  3. Seleccionar región (--crop) → screencapture -i"
  ```

- Comenzar análisis de imagen después de que el usuario haya ejecutado el comando screencapture
- Especificar problemas específicos o perspectivas permite análisis más enfocado
