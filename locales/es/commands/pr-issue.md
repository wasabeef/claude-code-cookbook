## Lista de Issues

Muestra una lista priorizada de issues abiertos en el repositorio actual.

### Uso

```bash
# Solicitar de Claude
"Mostrar una lista priorizada de issues abiertos"
```

### Ejemplos Básicos

```bash
# Obtener información del repositorio
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# Obtener información de issues abiertos y solicitar de Claude
gh issue list --state open --json number,title,author,createdAt,updatedAt,labels,assignees,comments --limit 30

"Organizar los issues anteriores por prioridad, incluyendo un resumen de 2 líneas para cada issue. Generar URLs usando el nombre del repositorio obtenido arriba"
```

### Formato de Visualización

```text
Lista de Issues Abiertos (por Prioridad)

### Alta Prioridad
#number Título [etiquetas] | Autor | Tiempo desde apertura | Conteo de comentarios | Asignado
      ├─ Línea de resumen 1
      └─ Línea de resumen 2
      https://github.com/owner/repo/issues/number

### Prioridad Media
(Formato similar)

### Baja Prioridad
(Formato similar)
```

### Criterios de Evaluación de Prioridad

**Alta Prioridad**

- Issues con etiqueta `bug`
- Issues con etiquetas `critical` o `urgent`
- Issues con etiqueta `security`

**Prioridad Media**

- Issues con etiqueta `enhancement`
- Issues con etiqueta `feature`
- Issues con asignados

**Baja Prioridad**

- Issues con etiqueta `documentation`
- Issues con etiqueta `good first issue`
- Issues con etiquetas `wontfix` o `duplicate`

### Filtrado por Etiquetas

```bash
# Obtener solo issues con etiqueta específica
gh issue list --state open --label "bug" --json number,title,author,createdAt,labels,comments --limit 30

# Filtrar con múltiples etiquetas (condición AND)
gh issue list --state open --label "bug,high-priority" --json number,title,author,createdAt,labels,comments --limit 30
```

### Notas

- Requiere GitHub CLI (`gh`)
- Solo muestra issues en estado abierto
- Muestra máximo 30 issues
- El tiempo transcurrido es desde cuando se abrió el issue
- Las URLs de issues se generan automáticamente desde el nombre real del repositorio
