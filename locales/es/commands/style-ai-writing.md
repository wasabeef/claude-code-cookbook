## Verificación de Escritura AI

Detecta patrones mecánicos en texto generado por IA y proporciona sugerencias para mejorar a español más natural.

### Uso

```bash
/ai-writing-check [opciones]
```

### Opciones

- Ninguna: Analizar archivo actual o texto seleccionado
- `--file <ruta>`: Analizar archivo específico
- `--dir <ruta>`: Analizar archivos en lote en directorio
- `--severity <nivel>`: Nivel de detección (all/high/medium)
- `--fix`: Corregir automáticamente patrones detectados

### Ejemplos Básicos

```bash
# Verificar estilo de escritura AI en archivo
cat README.md
/ai-writing-check
"Verificar este documento por estilo de escritura AI y sugerir mejoras"

# Analizar archivo específico
/ai-writing-check --file docs/guide.md
"Detectar expresiones similares a AI y sugerir correcciones a expresiones naturales"

# Escanear todo el proyecto
/ai-writing-check --dir . --severity high
"Reportar solo problemas críticos de escritura AI en el proyecto"
```

### Patrones Detectados

#### 1. Patrones de Formato de Lista Mecánica

```markdown
Ejemplos detectados:

- **Importante**: Este es un elemento importante
- Elemento completado (con emoji de marca de verificación)
- Tema candente (con emoji de fuego)
- Listo para comenzar (con emoji de cohete)

Ejemplos mejorados:

- Elemento importante: Este es un elemento importante
- Elemento completado
- Tema notable
- Listo para comenzar
```

#### 2. Expresiones Exageradas/Promocionales

```markdown
Ejemplos detectados:
La tecnología revolucionaria cambiará la industria.
Esto resuelve completamente el problema.
Funciona como magia.

Ejemplos mejorados:
La tecnología efectiva trae cambios a la industria.
Resuelve muchos problemas.
Funciona sin problemas.
```

#### 3. Patrones de Énfasis Mecánico

```markdown
Ejemplos detectados:
**Idea**: Nueva propuesta (con emoji de bombilla)
**Precaución**: Advertencia importante (con emoji de advertencia)

Ejemplos mejorados:
Idea: Nueva propuesta
Nota: Advertencia importante
```

#### 4. Escritura Técnica Redundante

```markdown
Ejemplos detectados:
Primero, realizaremos la configuración.
Puedes usar esta herramienta.
El rendimiento mejora enormemente.

Ejemplos mejorados:
Primero, realiza la configuración.
Puedes usar esta herramienta.
El rendimiento mejora un 30%.
```

### Colaboración con Claude

```bash
# Analizar todo el documento por estilo de escritura AI
cat article.md
/ai-writing-check
"Analizar y sugerir mejoras desde estas perspectivas:
1. Detección de expresiones mecánicas
2. Sugerencias para corrección a español natural
3. Lista de mejoras basada en prioridades"

# Enfocarse en patrones específicos
/ai-writing-check --file blog.md
"Prestar especial atención a expresiones exageradas y redundantes y sugerir mejoras"

# Verificación en lote de múltiples archivos
find . -name "*.md" -type f
/ai-writing-check --dir docs/
"Analizar estilo de escritura AI en toda la documentación y crear un resumen"
```

### Ejemplos Detallados

```bash
# Comparar antes y después de la mejora
/ai-writing-check --file draft.md
"Detectar expresiones similares a AI y presentarlas en el siguiente formato:
- Áreas problemáticas (con números de línea)
- Tipo de problema y razón
- Sugerencias específicas de mejora
- Efecto de la mejora"

# Modo de corrección automática
/ai-writing-check --file report.md --fix
"Corregir automáticamente patrones detectados y reportar resultados"

# Reporte de estilo de escritura AI del proyecto
/ai-writing-check --dir . --severity all
"Analizar estilo de escritura AI en todo el proyecto y proporcionar:
1. Información estadística (conteo de detección por patrón)
2. Top 5 archivos más problemáticos
3. Matriz de prioridades de mejora
4. Plan de mejora paso a paso"
```

### Ejemplos de Uso Avanzado

```bash
# Aplicar reglas personalizadas
/ai-writing-check --file spec.md
"Verificar especificaciones técnicas con estos criterios adicionales:
- Expresiones ambiguas (apropiado, según sea necesario)
- Falta de especificidad (rápido → números específicos)
- Uso inconsistente de terminología"

# Verificar para integración CI/CD
/ai-writing-check --dir docs/ --severity high
"Generar resultados en formato ejecutable de GitHub Actions:
- Número de errores y nombres de archivos
- Números de línea que requieren corrección
- Configuración de código de salida"

# Verificación de cumplimiento de guía de estilo
/ai-writing-check --file manual.md
"Verificaciones adicionales basadas en guía de estilo de la empresa:
- Uso de tratamiento formal (unificación de forma formal)
- Uso apropiado de términos técnicos
- Consideración por los lectores"
```

### Notas

- La determinación de estilo de escritura AI varía según el contexto, así que trata las sugerencias como referencia
- Ajustar criterios según el tipo de documento (documentos técnicos, blogs, manuales, etc.)
- No necesitas aceptar todas las sugerencias; selecciona las apropiadas
- La opción `--fix` corrige automáticamente patrones detectados

### Comportamiento de Ejecución del Comando

Cuando ejecutas el comando `/ai-writing-check`, Claude realiza los siguientes procesos:

1. **Detección de Patrones**: Detecta patrones similares a AI de archivos o texto especificados
2. **Sugerencias de Corrección Específicas**: Presenta sugerencias de corrección con números de línea para cada problema
3. **Modo --fix**: Corrige automáticamente patrones detectados y muestra un resumen de resultados
4. **Generación de Reporte**: Proporciona conteo de detección, prioridad de mejora y comparación antes/después de corrección

Claude lee el contenido real del archivo y realiza análisis basado en las reglas de textlint-rule-preset-ai-writing.

### Referencia

Este comando está creado con referencia al conjunto de reglas [textlint-rule-preset-ai-writing](https://github.com/textlint-ja/textlint-rule-preset-ai-writing). Es un preset de reglas textlint para detectar patrones mecánicos en texto generado por IA y promover expresiones más naturales.
