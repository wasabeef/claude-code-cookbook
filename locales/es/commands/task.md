## Task

Lanza un agente inteligente para manejar búsquedas e investigaciones complejas. Excelente para trabajo a gran escala sin consumir contexto.

### Uso

```bash
# Solicitar Task de Claude
"Investigar [tarea] usando Task"
```

### Lo que Hace Task

**Funciona Independientemente**

- Combina múltiples herramientas automáticamente
- Recopila y analiza paso a paso
- Junta resultados en reportes claros

**Ahorra Contexto**

- Usa menos memoria que búsqueda manual
- Busca muchos archivos eficientemente
- Extrae datos de fuentes externas

**Asegura Calidad**

- Verifica si las fuentes son confiables
- Verifica desde diferentes ángulos
- Llena piezas faltantes

### Ejemplos Básicos

```bash
# Investigación compleja de codebase
"Investigar qué archivos implementan esta característica usando Task"

# Búsqueda de archivos a gran escala
"Identificar inconsistencias de archivo de configuración usando Task"

# Recolección de información externa
"Investigar las últimas tendencias de tecnología IA usando Task"
```

### Colaboración con Claude

```bash
# Análisis de problema complejo
"Analizar la causa de fugas de memoria usando Task, incluyendo resultados de profiling y logs"

# Investigación de dependencias
"Investigar vulnerabilidades de este paquete npm usando Task"

# Análisis de competidores
"Investigar especificaciones de API de servicios competidores usando Task"

# Análisis de arquitectura
"Analizar dependencias de este microservicio usando Task"
```

### Task vs Otros Comandos

#### Cuándo Usar Qué

| Comando             | Caso de Uso Principal             | Método de Ejecución      | Recolección de Información        |
| ------------------- | --------------------------------- | ------------------------ | --------------------------------- |
| **Task**            | Investigación, análisis, búsqueda | Ejecución autónoma       | Múltiples fuentes                 |
| ultrathink          | Pensamiento profundo, juicio      | Pensamiento estructurado | Enfoque en conocimiento existente |
| sequential-thinking | Resolución de problemas, diseño   | Pensamiento paso a paso  | Según sea necesario               |
| plan                | Planificación de implementación   | Proceso de aprobación    | Análisis de requerimientos        |

#### Guía de Decisión Rápida

```text
¿Necesitas recopilar información?
├─ Sí → ¿De muchos lugares o muchos archivos?
│          ├─ Sí → **Usar Task**
│          └─ No → Solo preguntar normalmente
└─ No → ¿Necesitas pensamiento profundo?
          ├─ Sí → Usar ultrathink/sequential-thinking
          └─ No → Solo preguntar normalmente
```

### Cuándo Task Funciona Mejor

**Excelente Para**

- Explorar codebases complejos (dependencias, arquitectura)
- Buscar muchos archivos (patrones, configuraciones)
- Recopilar información externa (tendencias tecnológicas, librerías)
- Combinar datos de múltiples lugares (logs, métricas)
- Investigaciones repetitivas (auditorías, verificaciones de deuda)
- Búsquedas grandes que consumirían demasiado contexto

**No Excelente Para**

- Preguntas simples que ya conozco
- Tareas rápidas de una sola vez
- Cosas que necesitan discusión de ida y vuelta
- Decisiones de diseño (usar plan o comandos de pensamiento en su lugar)

### Ejemplos Detallados por Categoría

#### Análisis e Investigación de Sistema

```bash
# Análisis complejo de sistema
"Identificar cuellos de botella en el sitio EC usando Task, investigando base de datos, API y frontend"

# Análisis de arquitectura
"Analizar dependencias de este microservicio usando Task, incluyendo comunicación API y flujo de datos"

# Investigación de deuda técnica
"Analizar deuda técnica en código legacy usando Task, incluyendo prioridades de refactoring"
```

#### Seguridad y Cumplimiento

```bash
# Auditoría de seguridad
"Investigar vulnerabilidades en esta aplicación usando Task, basado en OWASP Top 10"

# Investigación de licencias
"Investigar problemas de licencia en dependencias del proyecto usando Task"

# Auditoría de archivos de configuración
"Identificar inconsistencias de configuración de seguridad usando Task, incluyendo diferencias de entorno"
```

#### Rendimiento y Optimización

```bash
# Análisis de rendimiento
"Identificar consultas pesadas en la aplicación usando Task, incluyendo planes de ejecución y propuestas de optimización"

# Investigación de uso de recursos
"Investigar causas de fugas de memoria usando Task, incluyendo resultados de profiling y análisis de código"

# Análisis de tamaño de bundle
"Investigar problemas de tamaño de bundle frontend usando Task, incluyendo sugerencias de optimización"
```

#### Recolección de Información Externa

```bash
# Investigación de tendencias tecnológicas
"Investigar tendencias de frameworks JavaScript 2024 usando Task"

# Análisis de competidores
"Investigar especificaciones de API de servicios competidores usando Task, incluyendo tabla de comparación de características"

# Evaluación de librerías
"Comparar librerías de gestión de estado usando Task, incluyendo costos de rendimiento y aprendizaje"
```

### Flujo de Ejecución y Aseguramiento de Calidad

#### Flujo de Ejecución de Task

```text
1. Análisis Inicial
   ├─ Descomposición de tarea e identificación del alcance de investigación
   ├─ Selección de herramientas necesarias y fuentes de información
   └─ Desarrollo de plan de ejecución

2. Recolección de Información
   ├─ Búsqueda de archivos y análisis de código
   ├─ Recolección de información externa
   └─ Estructuración de datos

3. Análisis e Integración
   ├─ Análisis de relevancia de información recopilada
   ├─ Identificación de patrones y problemas
   └─ Verificación de hipótesis

4. Reporte y Propuesta
   ├─ Estructuración de resultados
   ├─ Creación de propuestas de mejora
   └─ Presentación de próximas acciones
```

#### Aseguramiento de Calidad

- **Verificación de confiabilidad de fuentes de información**: Confirmación de hechos de múltiples fuentes
- **Verificación de completitud**: Verificación de no gaps en objetivos de investigación
- **Verificación de consistencia**: Confirmación de consistencia en información conflictiva
- **Evaluación de practicidad**: Evaluación de factibilidad y efectividad de propuestas

### Manejo de Errores y Restricciones

#### Restricciones Comunes

- **Límites de uso de API externa**: Límites de tasa y errores de autenticación
- **Límites de procesamiento de archivos grandes**: Restricciones de memoria y timeout
- **Problemas de permisos de acceso**: Restricciones en acceso a archivos y directorios

#### Manejo de Errores

- **Reporte de resultados parciales**: Análisis con solo información obtenible
- **Propuestas alternativas**: Sugerencia de métodos alternativos de investigación bajo restricciones
- **Ejecución paso a paso**: División de tareas a gran escala para ejecución

### Notas

- Task es óptimo para tareas complejas, autónomas de investigación y análisis
- Para preguntas simples o cuando se necesitan respuestas inmediatas, usar formato de pregunta normal
- Tratar resultados de investigación como información de referencia y siempre verificar decisiones importantes
- Al recopilar información externa, prestar atención a la frescura y precisión de la información

### Ejemplo de Ejecución

```bash
# Ejemplo de uso
"Investigar problemas en esquema GraphQL usando Task"

# Comportamiento esperado
# 1. Agente dedicado inicia
# 2. Buscar archivos relacionados con GraphQL
# 3. Analizar definiciones de esquema
# 4. Comparar con mejores prácticas
# 5. Identificar problemas y proponer mejoras
# 6. Crear reporte estructurado
```
