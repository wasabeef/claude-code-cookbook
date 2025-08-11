## Mostrar Plan

Mostrar el plan que se está ejecutando o que fue ejecutado en la sesión actual.

### Uso

```bash
/show-plan
```

### Ejemplos Básicos

```bash
# Verificar plan actual
/show-plan
"Mostrar plan en ejecución"

# Cuando no existe plan
/show-plan
"No hay plan en la sesión actual"
```

### Características

- Detectar planes creados con exit_plan_mode
- Buscar encabezados que contengan palabras clave como plan de implementación, detalles de implementación, plan
- Formatear y mostrar contenidos del plan
- Notificar claramente cuando no existe plan

### Colaboración con Claude

```bash
# Verificar plan durante implementación
"¿Qué estaba implementando?"
/show-plan

# Cuando ejecutas múltiples tareas
"Déjame verificar el plan actual nuevamente"
/show-plan

# Revisar después de ejecución del plan
"Muéstrame el plan que ejecuté anteriormente"
/show-plan
```

### Patrones de Detección

Basado en el formato de planes generados por exit_plan_mode, se detectan los siguientes patrones:

- Encabezados que comienzan con `##` (incluyendo Plan, Planificación, Estrategia)
- `### Changes` (Cambios)
- `### Implementation Details` (Detalles de Implementación)
- `### Implementation Plan` (Plan de Implementación)
- Encabezados numerados como `### 1.`

### Notas

- Solo muestra planes en la sesión actual (no incluye sesiones pasadas)
- Muestra el plan más reciente con prioridad
