## Corrección de Errores

Analiza mensajes de error para encontrar causas raíz y sugerir correcciones probadas.

### Uso

```bash
/fix-error [opciones]
```

### Opciones

- Sin opciones: Análisis estándar de errores
- `--deep`: Análisis profundo incluyendo dependencias y entorno
- `--preventive`: Enfoque en prevenir ocurrencias futuras
- `--quick`: Solo correcciones rápidas

### Ejemplos Básicos

```bash
# Análisis estándar de errores
npm run build 2>&1
/fix-error
"Analiza este error de build y sugiere correcciones"

# Modo de análisis profundo
python app.py 2>&1
/fix-error --deep
"Encuentra la causa raíz, incluyendo problemas de entorno"

# Solo correcciones rápidas
cargo test 2>&1
/fix-error --quick
"Solo dame una corrección rápida"

# Enfocado en prevención
./app 2>&1 | tail -50
/fix-error --preventive
"Corrige esto y ayúdame a prevenirlo la próxima vez"
```

### Colaboración con Claude

```bash
# Analizar logs de errores
cat error.log
/fix-error
"¿Qué está causando este error y cómo lo arreglo?"

# Resolver fallas de test
npm test 2>&1
/fix-error
"Ayúdame a arreglar estos tests fallidos"

# Problemas de compilación
make 2>&1
/fix-error
"Este proyecto no compila, ¿qué está mal?"

# Resolver múltiples errores
grep -E "ERROR|WARN" app.log | tail -20
/fix-error
"Clasifica estos errores y advertencias por prioridad y propón soluciones para cada uno"

### Prioridad de Análisis de Errores

#### 🔴 Urgencia: Alta (Respuesta Inmediata Requerida)

- **Parada de Aplicación**: Crashes, bucles infinitos, deadlocks
- **Riesgo de Pérdida de Datos**: Errores de base de datos, corrupción de archivos
- **Vulnerabilidades de Seguridad**: Fallos de autenticación, errores de permisos, inyección
- **Impacto en Producción**: Fallas de deploy, parada de servicios

#### 🟡 Urgencia: Media (Respuesta Temprana Recomendada)

- **Problemas de Rendimiento**: Memory leaks, latencia, timeouts
- **Disfunción Parcial**: Errores en funciones específicas, problemas de UI
- **Reducción de Eficiencia de Desarrollo**: Errores de build, fallos de test

#### 🟢 Urgencia: Baja (Respuesta Planificada)

- **Mensajes de Advertencia**: deprecations, errores de lint
- **Limitado a Entorno de Desarrollo**: Problemas solo en entorno local
- **Riesgo Futuro**: Deuda técnica, problemas de mantenibilidad

### Proceso de Análisis

#### Fase 1: Recolección de Información de Error

```bash
🔴 Ejecución Obligatoria:
- Obtención completa del mensaje de error
- Verificación del stack trace
- Identificación de condiciones de ocurrencia (reproducibilidad)

🟡 Ejecución Temprana:
- Recolección de información del entorno (SO, versión, dependencias)
- Historial de cambios recientes (git log, commits recientes)
- Verificación de logs relacionados

🟢 Ejecución Adicional:
- Estado de recursos del sistema
- Estado de la red
- Estado de servicios externos
```

#### Fase 2: Análisis de Causa Raíz

1. **Organización de Síntomas Superficiales**
   - Contenido exacto del mensaje de error
   - Timing y patrones de ocurrencia
   - Identificación del rango de impacto

2. **Identificación de Causas Profundas**
   - Aplicación del análisis de 5 Por Qué
   - Rastreo de dependencias
   - Verificación de diferencias de entorno

3. **Verificación de Hipótesis**
   - Creación de código de reproducción mínima
   - Ejecución de tests de aislamiento
   - Refinamiento de causas

#### Fase 3: Implementación de Soluciones

```bash
🔴 Manejo Inmediato (Hotfix):
- Corrección mínima para suprimir síntomas
- Aplicación de soluciones temporales
- Preparación de deploy de emergencia

🟡 Solución Fundamental:
- Corrección esencial dirigida a la causa
- Adición de casos de test
- Actualización de documentación

🟢 Implementación de Prevención:
- Fortalecimiento del manejo de errores
- Configuración de monitoreo y alertas
- Mejoras en pipeline CI/CD
```

### Ejemplo de Salida

```
🚨 Reporte de Análisis de Error
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 Resumen de Error
├─ Tipo: [Compilación/Runtime/Lógico/Entorno]
├─ Urgencia: 🔴 Alta / 🟡 Media / 🟢 Baja
├─ Rango de Impacto: [Nombre de función/Componente]
└─ Reproducibilidad: [100% / Intermitente / Condiciones específicas]

🔍 Causa Raíz
├─ Causa Directa: [Causa específica]
├─ Factores de Fondo: [Entorno/Configuración/Dependencias]
└─ Disparador: [Condiciones de ocurrencia]

💡 Soluciones
🔴 Manejo Inmediato:
1. [Comando/código de corrección específica]
2. [Solución temporal]

🟡 Solución Fundamental:
1. [Método de corrección esencial]
2. [Refactoring necesario]

🟢 Prevención:
1. [Mejora del manejo de errores]
2. [Adición de tests]
3. [Configuración de monitoreo]

📝 Procedimiento de Verificación
1. [Método de verificación después de aplicar corrección]
2. [Comando de ejecución de test]
3. [Elementos de verificación de funcionamiento]
```

### Métodos de Análisis por Tipo de Error

#### Errores de Compilación/Build

```bash
# Errores de tipo TypeScript
Verificación Obligatoria (Alta):
- Configuración de tsconfig.json
- Existencia de archivos de definición de tipos (.d.ts)
- Exactitud de declaraciones import

# Errores de lifetime de Rust
Verificación Obligatoria (Alta):
- Movimiento de ownership
- Período válido de referencias
- Conflictos de mutabilidad
```

#### Errores de Runtime

```bash
# Referencias Null/Undefined
Verificación Obligatoria (Alta):
- Falta de optional chaining
- Timing de inicialización
- Espera de completamiento de procesamiento asíncrono

# Errores Relacionados con Memoria
Verificación Obligatoria (Alta):
- Obtención de heap dump
- Análisis de logs GC
- Detección de referencias circulares
```

#### Errores de Dependencias

```bash
# Conflictos de Versión
Verificación Obligatoria (Alta):
- Consistencia de archivo lock
- Requisitos de peer dependencies
- Dependencias transitivas

# Errores de Resolución de Módulos
Verificación Obligatoria (Alta):
- Configuración NODE_PATH
- Configuración de alias de path
- Enlaces simbólicos
```

### Notas Importantes

- **Absolutamente Prohibido**: Juicio basado solo en parte del mensaje de error, aplicación de soluciones de Stack Overflow sin verificación
- **Condiciones de Excepción**: Soluciones temporales permitidas solo bajo las siguientes 3 condiciones:
  1. Respuesta de emergencia en entorno de producción (resolución fundamental obligatoria en 24 horas)
  2. Falla de servicio externo (medidas alternativas mientras se espera la recuperación)
  3. Bug conocido de framework (esperando release de versión corregida)
- **Recomendación**: Priorizar identificación de causa raíz, evitar correcciones superficiales

### Mejores Prácticas

1. **Recolección Completa de Información**: Verificar mensaje de error desde el principio hasta el final
2. **Verificación de Reproducibilidad**: Priorizar creación de código de reproducción mínima
3. **Enfoque Gradual**: Comenzar con pequeñas correcciones y verificar
4. **Documentación**: Registrar proceso de resolución para compartir conocimiento

#### Trampas Comunes

- **Manejo de Síntomas**: Correcciones superficiales que pasan por alto la causa raíz
- **Generalización Excesiva**: Aplicar soluciones de casos específicos ampliamente
- **Omisión de Verificación**: No verificar efectos secundarios después de corrección
- **Personalización del Conocimiento**: No documentar métodos de resolución

### Comandos Relacionados

- `/design-patterns` : Analizar problemas de estructura de código y sugerir patrones
- `/tech-debt` : Analizar causa raíz de errores desde perspectiva de deuda técnica
- `/analyzer` : Cuando se necesita análisis de causa raíz más profundo
