## Spec

**"Dar estructura antes de escribir código"** - Completamente compatible con el desarrollo dirigido por especificaciones de Kiro

A diferencia de las herramientas tradicionales de generación de código, realiza el desarrollo dirigido por especificaciones de Kiro enfocado en dar estructura al caos del desarrollo. Desde entrada mínima de requerimientos, se desarrolla progresivamente desde especificaciones detalladas a nivel de product manager hasta diseños implementables, asegurando calidad consistente desde **prototipo hasta producción**.

### Uso

```bash
# Solicitar Modo Spec de Claude (entrada mínima de requerimientos)
"Crear un spec para [descripción de característica]"

# Desarrollo paso a paso de Kiro:
# 1. Requerimientos simples → Generación automática de historias de usuario detalladas
# 2. Descripciones estructuradas de requerimientos usando notación EARS
# 3. Refinamiento de especificaciones a través de diálogo paso a paso
# 4. Generación de 3 archivos independientes:
#    - requirements.md: Definiciones de requerimientos usando notación EARS
#    - design.md: Diseño incluyendo diagramas Mermaid e interfaces TypeScript
#    - tasks.md: Plan de implementación con aplicación automática de mejores prácticas
```

### Resultados Probados (Historial de Kiro)

**Aplicación de Compartir Archivos Segura en 2 Días**

```bash
"Crear un spec para un sistema de compartir archivos (con cifrado)"
→ Aplicación de compartir archivos cifrados nivel producción completada en 2 días
→ Aplicación automática de mejores prácticas de seguridad
→ No se necesitaron prompts adicionales
```

**Desarrollo de Juego en Una Noche (Para Principiantes)**

```bash
"Crear un spec para un juego de puzzle 2D"
→ Desarrollador open source sin experiencia en desarrollo de juegos
→ Juego completado en una noche
→ Kiro maneja lógica de implementación, permitiendo a desarrolladores enfocarse en creatividad
```

### Ejemplos Básicos

```bash
# Crear spec para nueva característica (entrada mínima)
"Sistema de reseñas de producto
- Funcionalidad de calificación con estrellas
- Publicación de comentarios
- Carga de imágenes"

# Crear spec para característica de sistema
"Autenticación de usuario
- Soporte OAuth
- Autenticación multifactor"

# Crear spec para característica de API
"API de sistema de pagos
- Integración Stripe
- Enfocado en seguridad"
```

### Colaboración con Claude

```bash
# Spec de característica compleja
"Crear un spec para funcionalidad de chat incluyendo WebSocket, notificaciones en tiempo real y gestión de historial"

# Spec de característica de integración de base de datos
"Crear un spec para funcionalidad de gestión de inventario de sitio EC incluyendo adición de productos, actualizaciones de inventario y funcionalidad de alerta"

# Spec de característica frontend
"Crear un spec para dashboard React incluyendo visualización de gráficos, filtrado y funcionalidad de exportación"

# Spec de característica backend
"Crear un spec para API RESTful incluyendo autenticación, validación y logging"
```

### Características del Modo Spec

**Flujo de Trabajo de Diálogo Paso a Paso**

- Reproduce completamente el valor original de Kiro de discusión paso a paso
- Refina especificaciones colaborativamente con usuarios en cada fase
- Genera archivos a través de resolución de preguntas, discusión de opciones y procesos de aprobación

**Tres Fases de Desarrollo Interactivo**

- **Fase 1**: Descubrimiento de Requerimientos → Discusión → Aprobación → generación de `requirements.md`
- **Fase 2**: Exploración de Diseño → Discusión → Aprobación → generación de `design.md`
- **Fase 3**: Planificación de Implementación → Discusión → Aprobación → generación de `tasks.md`

**Desarrollo Dinámico de Especificaciones**

- Resuelve ambigüedades de requerimientos a través de diálogo
- Presenta y discute opciones técnicas
- Explica trade-offs y confirma decisiones

### Flujo de Trabajo de Diálogo Fase por Fase

#### Fase 1: Descubrimiento y Discusión de Requerimientos

**1. Expansión Automática desde Entrada Mínima (Estilo Kiro)**

```
Usuario: "Sistema de gestión de usuario
- Funcionalidad de login
- Edición de perfil
- Permisos de administrador"

Claude: "Generaré historias de usuario detalladas de tus requerimientos.
¿Es correcta esta comprensión?

Historias de usuario generadas automáticamente:
- Registro y autenticación de usuario (compatible OAuth)
- Gestión de perfil (avatar, configuraciones)
- Gestión de permisos (RBAC)
- Funcionalidad de reseteo de contraseña
- Logs de auditoría de seguridad

Agregué algunos detalles que no mencionaste. ¿Algo más que necesitemos?"
```

**2. Descripción Estructurada de Requerimientos Usando Notación EARS**

```
Claude: "Déjame estructurar esto usando notación EARS:

Aquí están los requerimientos en formato EARS:

WHEN un usuario intenta hacer login
GIVEN ingresan la dirección de email y contraseña correctas
THEN el sistema deberá confirmar autenticación
AND redirigir al dashboard en caso de éxito

WHILE un usuario está en la pantalla de edición de perfil
THE SYSTEM SHALL realizar validación en tiempo real
AND mostrar una vista previa de cambios

WHERE se intenta acceso a una característica que requiere privilegios de administrador
IS cuando el sistema deberá verificar niveles de permiso
AND denegar acceso si es insuficiente"
```

#### Fase 2: Exploración y Discusión de Diseño

**1. Análisis de Codebase + Propuesta de Diseño Automático (Estilo Kiro)**

```
Claude: "Después de analizar tu codebase, aquí está mi arquitectura recomendada:

Resultados de análisis de codebase:
- Autenticación: JWT + Express.js (v4.18.x)
- Base de datos: PostgreSQL (v14+)
- Frontend: React + TypeScript (v18+)
- Patrones existentes: Patrón Repository, separación de capa de servicio

Arquitectura recomendada por Kiro:
- Cumplimiento de Clean Architecture
- Elementos de Domain-Driven Design
- Aplicación parcial del patrón CQRS
- Mejores prácticas de seguridad automatizadas

¿Procederemos con este diseño?"
```

**2. Diseño Visual con Diagramas Mermaid**

```text
Claude: "He generado automáticamente un diseño de sistema usando diagramas Mermaid:

graph TB
    Client[React Client] --> API[Express API Gateway]
    API --> Auth[Auth Service]
    API --> User[User Service]
    
    Auth --> AuthDB[(Auth Database)]
    User --> UserDB[(User Database)]

¿También genero un diagrama de flujo de datos?"
```

#### Fase 3: Planificación e Implementación y Discusión

**1. Aplicación Automática de Mejores Prácticas (Estilo Kiro)**

```

Claude: "He generado un plan de implementación con aplicación automática de mejores prácticas de Kiro:

Estrategia de implementación generada automáticamente:

1. Desarrollo security-first
   - Incorporación automática de contramedidas OWASP Top 10
   - Implementación automática de cifrado y hashing
   - Generación automática de pruebas de seguridad

2. Aplicación de arquitectura limpia
   - Implementación automática de separación de capas
   - Aplicación automática de inversión de dependencia
   - Aplicación de diseño testeable

¿Procederemos con este enfoque?"

```

### Características Específicas de Kiro

**Notación EARS (Easy Approach to Requirements Syntax)**

```text
# Patrones de Notación EARS Estándar de Kiro

WHEN [situación/disparador]
GIVEN [precondición]
THEN [comportamiento del sistema]
AND [comportamiento adicional]

WHILE [estado/proceso]
THE SYSTEM SHALL [comportamiento mandatorio]
AND [comportamiento relacionado]

WHERE [función/componente]
IS [condición/estado]
THE SYSTEM SHALL [comportamiento correspondiente]
```

**Características de Generación Automática**

- **Diagramas Mermaid**: Generación automática de diagramas de arquitectura y flujo de datos
- **Interfaces TypeScript**: Creación automática de definiciones de tipo basadas en diseño
- **Mejores prácticas**: Incorporación automática de medidas de seguridad y rendimiento
- **Puntos de control de calidad**: Configuración automática de estándares de calidad específicos por fase

### Frases Disparadoras y Controles

#### Control de Flujo de Trabajo Paso a Paso

**Disparadores de Inicio**

- "Crear un spec para [nombre de característica]"
- "Quiero desarrollar [nombre de característica] usando desarrollo dirigido por especificaciones"
- "Diseñar [nombre de característica] desde especificaciones"

**Control de Progreso de Fase**

- **"Proceder"**: Completar fase actual, generar archivo, moverse a siguiente fase
- **"Revisar"**: Ajustar o mejorar contenido dentro de fase actual
- **"Reiniciar"**: Reiniciar fase actual desde el principio
- **"Explicar en detalle"**: Proporcionar explicaciones más detalladas u opciones

**Tiempo de Generación de Archivo**

```
Completitud Fase 1 → "Proceder" → generación de requirements.md
Completitud Fase 2 → "Proceder" → generación de design.md
Completitud Fase 3 → "Proceder" → generación de tasks.md
```

### Características Específicas de Kiro

**Notación EARS (Easy Approach to Requirements Syntax)**

```text
# Patrones estándar de notación EARS de Kiro

WHEN [situación/trigger]
GIVEN [precondición]
THEN [comportamiento del sistema]
AND [comportamiento adicional]

WHILE [estado/proceso]
THE SYSTEM SHALL [comportamiento obligatorio]
AND [comportamiento relacionado]

WHERE [función/componente]
IS [condición/estado]
THE SYSTEM SHALL [comportamiento correspondiente]
```

**Funciones de generación automática**

- **Diagramas Mermaid**: Generación automática de diagramas de arquitectura y flujo de datos
- **Interfaces TypeScript**: Creación automática de definiciones de tipos basadas en diseño
- **Mejores prácticas**: Incorporación automática de medidas de seguridad y rendimiento
- **Puntos de control de calidad**: Configuración automática de estándares de calidad por etapa

**Integración hooks**

- Control automático de calidad al guardar archivos
- Aplicación automática de estándares de código
- Ejecución automática de escaneo de seguridad
- Verificación automática de contramedidas OWASP Top 10

**Garantía de calidad de prototipo → producción**

- Diseño consistente mediante enfoque estructurado
- Aplicación obligatoria de desarrollo security-first
- Aplicación automática de arquitectura escalable
- Incorporación de gestión continua de calidad

### Detalle de Implementación

Los requisitos detallados se implementan a través de un proceso estructurado de 3 fases, garantizando calidad y consistencia en cada etapa.

### Notas

**Alcance de Aplicación**

- El Modo Spec está optimizado para implementación de características
- Usar formato de implementación normal para correcciones simples o cambios pequeños
- Recomendado para desarrollo de nuevas características o modificaciones complejas de características

**Aseguramiento de Calidad**

- Clarificación de criterios de completitud en cada etapa
- Revisión de diseño antes de implementación
- Estándares de calidad integrales incluyendo testing y accesibilidad

**Precauciones de Ejecución**

- Resolver ambigüedades de requisitos antes de proceder a etapa de diseño
- Generar tareas de implementación después de completar diseño
- Valorar proceso de aprobación en cada etapa

### Frases Disparadoras y Controles

#### Control de Flujo de Trabajo Paso a Paso

**Triggers de inicio**

- "Crear spec de [nombre de función]"
- "Quiero desarrollar [nombre de función] impulsado por spec"
- "Diseñar [nombre de función] desde especificaciones"

**Control de progreso de fase**

- **"Proceder"**: Completar fase actual y generar archivo, proceder a siguiente fase
- **"Corregir"**: Ajustar y mejorar contenido dentro de fase actual
- **"Rehacer"**: Rehacer fase actual desde el principio
- **"Explicar en detalle"**: Presentar explicación más detallada u opciones
- **"Saltar"**: Saltar fase actual a siguiente (no recomendado)

**Momento de generación de archivo**

```
Completitud Fase 1 → "Proceder" → generación de requirements.md
Completitud Fase 2 → "Proceder" → generación de design.md
Completitud Fase 3 → "Proceder" → generación de tasks.md
```

### Ejemplo de Ejecución (Flujo Paso a Paso)

```bash
# Ejemplo de uso
Usuario: "Crear spec de sistema de gestión de usuarios"

# Fase 1: Descubrimiento de requisitos
Claude: [Inicio de verificación y discusión de requisitos]
Usuario: [Respuesta/discusión/corrección]
Claude: "Fase de requisitos completada. ¿Proceder?"
Usuario: "Proceder"
→ Generación de requirements.md

# Fase 2: Exploración de diseño
Claude: [Inicio de propuesta y discusión de diseño]
Usuario: [Selección técnica/discusión de arquitectura]
Claude: "Fase de diseño completada. ¿Proceder?"
Usuario: "Proceder"
→ Generación de design.md

# Fase 3: Planificación de implementación
Claude: [Inicio de discusión de plan de implementación]
Usuario: [Discusión de prioridad/riesgo/horas de trabajo]
Claude: "Fase de implementación completada. ¿Proceder?"
Usuario: "Proceder"
→ Generación de tasks.md

# Completado
Claude: "Preparación para desarrollo impulsado por spec completada. Puede comenzar implementación."
```

### Diferencias con /plan

| Característica | /plan | /spec |
|------|-------|-------|
| Objetivo | Plan de implementación general | Desarrollo impulsado por especificaciones de función |
| Formato de salida | Documento de plan único | 3 archivos independientes (requirements.md, design.md, tasks.md) |
| Definición de requisitos | Organización básica de requisitos | Criterios de aceptación detallados usando notación EARS |
| Diseño | Centrado en selección técnica | Basado en análisis de codebase |
| Implementación | Descomposición de tareas generales | Secuencia considerando dependencias |
| Garantía de calidad | Estrategia básica de pruebas | Requisitos de calidad integrales (pruebas, accesibilidad, rendimiento) |
| Sincronización | Plan estático | Actualización dinámica de spec |

### Casos de Uso Recomendados

**Uso recomendado de spec**

- Desarrollo de nuevas funciones
- Modificaciones complejas de funciones
- Diseño API
- Diseño de base de datos
- Implementación UI/UX

**Uso recomendado de plan**

- Diseño de sistema completo
- Construcción de infraestructura
- Refactoring
- Selección técnica
- Cambios de arquitectura
