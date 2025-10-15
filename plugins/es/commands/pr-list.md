## Lista de PR

Muestra una lista priorizada de PRs abiertos en el repositorio actual.

### Uso

```bash
# Solicitar de Claude
"Mostrar una lista priorizada de PRs abiertos"
```

### Ejemplos Básicos

```bash
# Obtener información del repositorio
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# Obtener información de PRs abiertos y solicitar de Claude
gh pr list --state open --draft=false --json number,title,author,createdAt,additions,deletions,reviews --limit 30

"Organizar los PRs anteriores por prioridad, incluyendo un resumen de 2 líneas para cada PR. Generar URLs usando el nombre del repositorio obtenido arriba"
```

### Formato de Visualización

```text
Lista de PRs Abiertos (por Prioridad)

### Alta Prioridad
#number Título [Draft/DNM] | Autor | Tiempo desde apertura | Conteo de aprobaciones | +adiciones/-eliminaciones
      ├─ Línea de resumen 1
      └─ Línea de resumen 2
      https://github.com/owner/repo/pull/number

### Prioridad Media
(Formato similar)

### Baja Prioridad
(Formato similar)
```

### Criterios de Evaluación de Prioridad

**Alta Prioridad**

- `fix:` Correcciones de bugs
- `release:` Trabajo de release

**Prioridad Media**

- `feat:` Nuevas características
- `update:` Mejoras de características
- Otros PRs regulares

**Baja Prioridad**

- PRs que contienen DO NOT MERGE
- PRs Draft con `test:`, `build:`, `perf:`

### Notas

- Requiere GitHub CLI (`gh`)
- Solo muestra PRs en estado abierto (se excluyen Drafts)
- Muestra máximo 30 PRs
- El tiempo transcurrido es desde cuando se abrió el PR
- Las URLs de PRs se generan automáticamente desde el nombre real del repositorio
