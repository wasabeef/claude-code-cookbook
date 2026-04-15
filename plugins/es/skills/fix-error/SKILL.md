---
description: 'Identificar causa raíz y sugerir soluciones. Se activa con "arreglar este error", "¿qué es este error?", "resolver fallo de build".'
allowed-tools:
  - Read
  - Edit
  - Grep
  - Glob
  - Bash
---

# Identificar causa raíz y sugerir soluciones

Identifica la causa raíz del mensaje de error, predice el tiempo de resolución y propone soluciones probadas. Aprende patrones de errores similares y presenta inmediatamente la solución adecuada.

## Uso

```bash
/fix-error [opciones]
```

## Opciones

- Ninguna : Análisis de error estándar
- `--deep` : Modo de análisis profundo (incluye dependencias y factores ambientales)
- `--preventive` : Análisis enfocado en medidas preventivas
- `--quick` : Solo presenta correcciones aplicables inmediatamente

## Ejemplos Básicos

```bash
# Análisis de error estándar
npm run build 2>&1
/fix-error
「Analizar error de compilación y presentar método de corrección」

# Modo de análisis profundo
python app.py 2>&1
/fix-error --deep
「Analizar causa raíz del error incluyendo factores ambientales」

# Enfoque en corrección inmediata
cargo test 2>&1
/fix-error --quick
「Presentar método de corrección aplicable inmediatamente」

# Enfoque en medidas preventivas
./app 2>&1 | tail -50
/fix-error --preventive
「Presentar corrección del error y medidas preventivas futuras」
```

## Colaboración con Claude

```bash
# Análisis de log de errores
cat error.log
/fix-error
「Identificar causa raíz del error y proponer método de corrección」

# Resolución de fallo de pruebas
npm test 2>&1
/fix-error --quick
「Analizar prueba fallida y presentar propuesta de corrección aplicable inmediatamente」

# Análisis de stack trace
python script.py 2>&1
/fix-error --deep
「Identificar ubicación del problema desde este stack trace y analizar incluyendo factores ambientales」

# Resolver múltiples errores juntos
grep -E "ERROR|WARN" app.log | tail -20
/fix-error
「Clasificar estos errores y advertencias por prioridad y proponer método de resolución para cada uno」
```

## Predicción de Tiempo de Resolución de Error

```text
🚀 Corrección inmediata (dentro de 5 minutos)
├─ Typos, imports olvidados
├─ Variables de entorno no configuradas
├─ Referencia de variables no definidas
└─ Tiempo predicho: 2-5 minutos

⚡ Corrección rápida (dentro de 30 minutos)
├─ Inconsistencia de dependencias
├─ Error de archivo de configuración
├─ Discrepancia de tipos
└─ Tiempo predicho: 10-30 minutos

🔧 Investigación necesaria (dentro de 2 horas)
├─ Error de lógica compleja
├─ Conflicto de procesamiento asíncrono
├─ Problema de integración API
└─ Tiempo predicho: 30 minutos-2 horas

🔬 Análisis profundo (medio día o más)
├─ Originado en arquitectura
├─ Colaboración de múltiples sistemas
├─ Degradación de rendimiento
└─ Tiempo predicho: 4 horas-varios días
```

## Base de Datos de Patrones de Errores Similares

```text
Errores frecuentes y soluciones inmediatas
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 "Cannot read property 'X' of undefined/null" (frecuencia: extremadamente alta)
├─ Causa principal: Falta de verificación null del objeto
├─ Tiempo de resolución: 5-10 minutos
└─ Solución: Añadir optional chaining (?.) o verificación null

📊 "ECONNREFUSED" / "ENOTFOUND" (frecuencia: alta)
├─ Causa principal: Servicio no iniciado o error de configuración URL
├─ Tiempo de resolución: 5-15 minutos
└─ Solución: Confirmar inicio de servicio, verificar variables de entorno

📊 "Module not found" / "Cannot resolve" (frecuencia: alta)
├─ Causa principal: Paquete no instalado, error de especificación de ruta
├─ Tiempo de resolución: 2-5 minutos
└─ Solución: Ejecutar npm install, verificar ruta relativa

📊 "Unexpected token" / "SyntaxError" (frecuencia: media)
├─ Causa principal: Discrepancia de paréntesis/comillas, uso de palabra reservada
├─ Tiempo de resolución: 2-10 minutos
└─ Solución: Verificar syntax highlighting, ejecutar Linter

📊 "CORS policy" / "Access-Control-Allow-Origin" (frecuencia: media)
├─ Causa principal: Falta de configuración CORS del lado servidor
├─ Tiempo de resolución: 15-30 minutos
└─ Solución: Configuración CORS del servidor, configuración proxy

📊 "Maximum call stack size exceeded" (frecuencia: baja)
├─ Causa principal: Bucle infinito/recursión, referencia circular
├─ Tiempo de resolución: 30 minutos-2 horas
└─ Solución: Verificar condición de terminación de recursión, resolver referencia circular
```

## Matriz de Prioridad de Análisis de Error

| Prioridad         | Icono                    | Alcance Impacto | Dificultad Resolución | Plazo Respuesta      | Descripción                                              |
| ----------------- | ------------------------ | --------------- | --------------------- | -------------------- | -------------------------------------------------------- |
| **Critical**      | 🔴 Respuesta urgente     | Amplio          | Bajo                  | Inicio dentro 15 min | Parada total sistema, riesgo pérdida datos               |
| **High Priority** | 🟠 Respuesta temprana    | Amplio          | Alto                  | Inicio dentro 1 hora | Parada función principal, afecta muchos usuarios         |
| **Medium**        | 🟡 Respuesta planificada | Limitado        | Alto                  | Respuesta mismo día  | Restricción función parcial, existe solución alternativa |
| **Low**           | 🟢 Observación           | Limitado        | Bajo                  | Próxima modificación | Fallo menor, pequeño impacto en UX                       |

## Proceso de Análisis

### Phase 1: Recopilación de Información de Error

```bash
🔴 Ejecución obligatoria:
- Obtención completa del mensaje de error
- Verificación del stack trace
- Identificación de condiciones de ocurrencia (reproducibilidad)

🟡 Ejecución temprana:
- Recopilación información ambiente (OS, versión, dependencias)
- Historial de cambios inmediatos (git log, commits recientes)
- Verificación logs relacionados

🟢 Ejecución adicional:
- Estado recursos del sistema
- Estado de red
- Estado servicios externos
```

### Phase 2: Análisis de Causa Raíz

1. **Organización de síntomas superficiales**
   - Contenido exacto del mensaje de error
   - Timing y patrón de ocurrencia
   - Identificación del alcance de impacto

2. **Identificación de causa profunda**
   - Aplicación de análisis 5 Whys
   - Rastreo de dependencias
   - Verificación de diferencias ambientales

3. **Verificación de hipótesis**
   - Creación de código mínimo de reproducción
   - Ejecución de prueba de aislamiento
   - Refinamiento de causas

### Phase 3: Implementación de Solución

```bash
🔴 Manejo inmediato (hotfix):
- Corrección mínima para suprimir síntomas
- Aplicación de solución temporal
- Preparación para despliegue de emergencia

🟡 Resolución fundamental:
- Corrección esencial para la causa
- Adición de casos de prueba
- Actualización de documentación

🟢 Implementación de medidas preventivas:
- Fortalecimiento de manejo de errores
- Configuración de monitoreo/alertas
- Mejora de pipeline CI/CD
```

## Ejemplo de Salida

```text
🚨 Reporte de Análisis de Error
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 Resumen del Error
├─ Tipo: [Compilación/Tiempo ejecución/Lógico/Ambiental]
├─ Urgencia: 🔴 Alta / 🟡 Media / 🟢 Baja
├─ Alcance impacto: [Nombre función/Componente]
└─ Reproducibilidad: [100% / Intermitente / Condición específica]

🔍 Causa Raíz
├─ Causa directa: [Causa específica]
├─ Factor de fondo: [Ambiente/Configuración/Dependencias]
└─ Disparador: [Condición de ocurrencia]

💡 Solución
🔴 Manejo inmediato:
1. [Comando/código de corrección específico]
2. [Medida temporal]

🟡 Resolución fundamental:
1. [Método de corrección esencial]
2. [Refactoring necesario]

🟢 Medidas preventivas:
1. [Mejora de manejo de errores]
2. [Adición de pruebas]
3. [Configuración de monitoreo]

📝 Procedimiento de Verificación
1. [Método de verificación tras aplicar corrección]
2. [Comando de ejecución de pruebas]
3. [Items de verificación de funcionamiento]
```

## Método de Análisis por Tipo de Error

### Error de Compilación/Build

```bash
# Error de tipo TypeScript
Verificación obligatoria (alta):
- Configuración de tsconfig.json
- Existencia de archivos de definición de tipo (.d.ts)
- Exactitud de declaraciones import

# Error de lifetime de Rust
Verificación obligatoria (alta):
- Movimiento de ownership
- Período válido de referencia
- Conflicto de mutabilidad
```

### Error de Tiempo de Ejecución

```bash
# Referencia Null/Undefined
Verificación obligatoria (alta):
- Falta de optional chaining
- Timing de inicialización
- Espera de completación de procesamiento asíncrono

# Error relacionado con memoria
Verificación obligatoria (alta):
- Obtención de heap dump
- Análisis de log GC
- Detección de referencia circular
```

### Error de Dependencias

```bash
# Conflicto de versión
Verificación obligatoria (alta):
- Consistencia de archivo lock
- Requisitos de peer dependencies
- Dependencias transitivas

# Error de resolución de módulo
Verificación obligatoria (alta):
- Configuración NODE_PATH
- Configuración de alias de ruta
- Enlaces simbólicos
```

## Precauciones

- **Absolutamente prohibido**: Juicio basado solo en parte del mensaje de error, aplicación de solución Stack Overflow sin verificación
- **Condiciones de excepción**: Medidas temporales permitidas solo bajo estas 3 condiciones:
  1. Respuesta de emergencia ambiente producción (resolución fundamental obligatoria dentro 24 horas)
  2. Fallo servicio externo (medio alternativo durante espera de recuperación)
  3. Bug conocido de framework (esperando lanzamiento de versión corregida)
- **Recomendación**: Priorizar identificación de causa raíz, evitar corrección superficial

## Mejores Prácticas

1. **Recopilación completa de información**: Verificar mensaje de error desde inicio hasta final
2. **Verificación de reproducibilidad**: Priorizar creación de código mínimo de reproducción
3. **Enfoque gradual**: Comenzar con pequeñas correcciones y verificar
4. **Documentación**: Registrar proceso de resolución para compartir conocimiento

### Trampas Comunes

- **Manejo de síntomas**: Corrección superficial que pasa por alto causa raíz
- **Generalización excesiva**: Aplicar ampliamente solución de caso específico
- **Omisión de verificación**: No confirmar efectos secundarios tras corrección
- **Personalización de conocimiento**: No documentar método de resolución

## Comandos Relacionados

- `/design-patterns` : Analizar problemas de estructura de código y proponer patrones
- `/tech-debt` : Analizar causa raíz de errores desde perspectiva de deuda técnica
- `/analyzer` : Cuando se necesita análisis de causa raíz más profundo
