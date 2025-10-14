## Plan

Te ayuda a planificar antes de programar. Crea estrategias detalladas para hacer que el desarrollo sea más fluido.

### Uso

```bash
# Solicitar Modo Plan de Claude
"Crear un plan de implementación para [contenido de implementación]"
```

### Ejemplos Básicos

```bash
# Plan de implementación para nueva característica
"Crear un plan de implementación para funcionalidad de autenticación de usuario"

# Plan de diseño de sistema
"Crear un plan de implementación para división de microservicios"

# Plan de refactoring
"Crear un plan de refactoring para código legacy"
```

### Colaboración con Claude

```bash
# Implementación de característica compleja
"Crear un plan de implementación para funcionalidad de chat, incluyendo WebSocket, notificaciones en tiempo real y gestión de historial"

# Diseño de base de datos
"Crear un plan de diseño de base de datos para un sitio de e-commerce, incluyendo gestión de productos, pedidos y usuarios"

# Diseño de API
"Crear un plan de implementación para API GraphQL, incluyendo autenticación, caché y rate limiting"

# Diseño de infraestructura
"Crear un plan de implementación para Dockerización, incluyendo entorno de desarrollo, entorno de producción y CI/CD"
```

### Cómo Funciona el Modo Plan

**Inicio Automático**

- Se inicia automáticamente cuando describes qué construir
- O simplemente di "Crear un plan de implementación"

**Lo Que Obtienes**

- Requisitos claros (historias de usuario, criterios de éxito)
- Documentos de diseño (arquitectura, modelo de datos, UI)
- Pasos de implementación (tareas, seguimiento, verificaciones de calidad)
- Análisis de riesgos y soluciones

**Obteniendo Tu Aprobación**

- Te mostraré el plan usando `exit_plan_mode`
- **Importante**: Siempre espero tu OK explícito
- No programaré sin tu aprobación
- Puedes solicitar cambios en cualquier momento
- El seguimiento de TodoWrite comienza después de tu aprobación

### Ejemplos Detallados

```bash
# Implementación de sistema complejo
"Crear un plan de implementación para un sistema de pagos online, incluyendo integración con Stripe, seguridad y manejo de errores"

# Implementación de frontend
"Crear un plan de implementación para un dashboard de React, incluyendo gestión de estado, diseño de componentes y testing"

# Implementación de backend
"Crear un plan de implementación para una API RESTful, incluyendo autenticación, validación y logging"

# Implementación de DevOps
"Crear un plan de implementación para un pipeline CI/CD, incluyendo automatización de pruebas, despliegue y monitoreo"
```

### Flujo de Trabajo de 3 Fases

#### Fase 1: Requisitos

- **Historias de Usuario**: ¿Qué estamos construyendo y por qué?
- **Criterios de Éxito**: ¿Cómo sabemos que está terminado?
- **Restricciones**: ¿Qué límites tenemos?
- **Prioridad**: ¿Qué es imprescindible vs deseable?

#### Fase 2: Diseño

- **Arquitectura**: ¿Cómo funcionará el sistema?
- **Modelo de Datos**: Esquema de base de datos y APIs
- **UI/UX**: Layouts de pantalla y flujo de usuario
- **Riesgos**: ¿Qué podría salir mal y cómo prevenirlo?

#### Fase 3: Implementación

- **Desglose de Tareas**: Dividir en partes manejables
- **Seguimiento de Progreso**: TodoWrite gestiona el estado
- **Verificaciones de Calidad**: Plan de testing y verificación
- **Tu Aprobación**: Mostrar plan y esperar tu OK

### Notas

**Cuándo Usar Esto**

- Mejor para proyectos complejos
- Omitir para correcciones simples
- Genial para tareas de 3+ pasos o nuevas características

**Notas Técnicas**

- No confíes en valores de retorno de `exit_plan_mode`
- Solo tu aprobación explícita cuenta
- Funciona diferente al modo plan CLI

**Reglas Importantes**

- Nunca empezar a programar antes de tu aprobación
- Siempre esperar tu respuesta
- Ofrecer alternativas si algo falla

### Ejemplo de Ejecución

```bash
# Ejemplo de uso
"Crear un plan de implementación para un sistema de gestión de usuario"

# Lo que pasa:
# 1. Se inicia el Modo Plan
# 2. Analizar requisitos y elegir tecnología
# 3. Estructurar la implementación
# 4. Mostrarte el plan
# 5. Empezar a programar después de tu aprobación
```
