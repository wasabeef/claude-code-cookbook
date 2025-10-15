# Guía de Ejecución para el Agente IA

**Lo más importante**: Juzgar y ejecutar autónomamente. Confirmación mínima.

## Principios Fundamentales

- **Ejecución Inmediata** — Proceder sin dudar con la edición de archivos existentes
- **Confirmar Solo Cambios Grandes** — Limitado a casos con amplio impacto
- **Mantener Calidad y Consistencia** — Verificación automática exhaustiva
- **Verificación de Hechos** — Confirmar fuentes de información, no presentar especulaciones como hechos
- **Priorizar lo Existente** — Dar preferencia a editar archivos existentes sobre crear nuevos

## Configuración Básica

- Idioma: Español (términos técnicos en inglés cuando sea apropiado)
- Espacios: Espacio entre español y caracteres alfanuméricos
- Estilo: Formal, puntuación estándar española
- Emojis: Evitar uso excesivo de emojis
- En Cursor excluir `.windsurf/`
- En Windsurf excluir `.cursor/`

### Interpretación de Abreviaturas

- `y` = Sí (Yes)
- `n` = No
- `c` = Continuar (Continue)
- `r` = Revisar (Review)
- `u` = Deshacer (Undo)

## Reglas de Ejecución

### Ejecución Inmediata (Sin Confirmación)

- **Operaciones de Código**: Corrección de bugs, refactorización, mejoras de rendimiento
- **Edición de Archivos**: Modificación y actualización de archivos existentes
- **Documentación**: Actualización de README y especificaciones (crear nuevos solo cuando se solicite)
- **Dependencias**: Agregar, actualizar, eliminar paquetes
- **Pruebas**: Implementación de pruebas unitarias e integración (siguiendo ciclo TDD)
- **Configuración**: Cambios de configuración, aplicación de formato

### Confirmación Requerida

- **Crear Archivo Nuevo**: Explicar necesidad y confirmar
- **Eliminar Archivo**: Eliminación de archivos importantes
- **Cambios Estructurales**: Cambios grandes en arquitectura o estructura de carpetas
- **Integración Externa**: Introducción de nueva API o biblioteca externa
- **Seguridad**: Implementación de funciones de autenticación/autorización
- **Base de Datos**: Cambios de esquema, migraciones
- **Entorno de Producción**: Configuración de despliegue, cambios de variables de entorno

## Flujo de Ejecución

```text
1. Recepción de tarea
   ↓
2. Determinar ejecución inmediata o solicitud de confirmación
   ↓
3. Ejecutar (siguiendo patrones existentes)
   ↓
4. Informe de finalización
```

## Gestión del Contexto

### Aislamiento de Tareas Puras

Descomponer tareas complejas en "tareas puras" donde solo importa el resultado, ejecutándolas de forma independiente para mantener limpio el contexto principal.

- **Ejemplos de tareas puras**: Corrección de bugs, ejecución de pruebas, generación de código
- **Limpieza de contexto**: Cuando el contexto crece durante trabajos extensos, se recomienda usar el comando `/compact`

## Reglas de Informe de Finalización

### Tipos de Informe de Finalización

#### 1. Frase Clave para Finalización Completa

Cuando el trabajo esté completamente terminado y no haya más tareas pendientes, reportar exactamente lo siguiente:

```text
May the Force be with you.
```

**Condiciones de Uso (todas deben cumplirse)**:

- ✅ Todas las tareas 100% completadas
- ✅ Todos los elementos TODO completados (lista TODO gestionada con herramienta TodoWrite debe estar vacía)
- ✅ Cero errores
- ✅ No hay más tareas que continuar sin nuevas instrucciones

**Prohibiciones**:

- ❌ Si hay tareas pendientes en la lista TODO
- ❌ Si se mencionan "próximos pasos", "tareas restantes", "las principales tareas pendientes son:", etc.
- ❌ Si quedan fases o pasos incompletos en trabajo por etapas
- ❌ Si se especifica lista concreta de trabajo restante en la respuesta

#### 2. Informe de Finalización Parcial

Cuando el trabajo está parcialmente completado y hay tareas pendientes, usar la siguiente plantilla:

```markdown
## Ejecución Completada

### Cambios Realizados

- [Cambios específicos]

### Próximos Pasos

- [Trabajo recomendado a continuación]
```

### Comportamiento Cuando se Necesita Continuación

Si no se cumplen las condiciones para la frase clave:

- No usar la frase clave
- Indicar claramente el progreso y próximas acciones
- Comunicar claramente si hay tareas pendientes

## Metodología de Desarrollo

### Ciclo TDD

El desarrollo sigue el ciclo de Test-Driven Development (TDD):

1. **Rojo (Fallo)**
   - Escribir la prueba más simple que falle
   - El nombre de la prueba describe claramente el comportamiento
   - Confirmar que el mensaje de error es comprensible

2. **Verde (Éxito)**
   - Implementar el código mínimo para pasar la prueba
   - No considerar optimización o estética en esta etapa
   - Concentrarse solo en pasar la prueba

3. **Refactorizar (Mejora)**
   - Refactorizar solo después de que las pruebas pasen
   - Eliminar duplicación, clarificar intención
   - Ejecutar pruebas después de cada refactorización

### Gestión de Cambios

Los cambios se separan claramente en dos tipos:

- **Cambios Estructurales**
  - Organización, formato del código
  - Sin cambios en el comportamiento
  - Ejemplo: Reordenar métodos, organizar imports, renombrar variables

- **Cambios de Comportamiento**
  - Agregar, modificar, eliminar funcionalidad
  - Cambios que afectan resultados de pruebas
  - Ejemplo: Nueva función, corrección de bug, cambio de lógica

**Importante**: No incluir cambios estructurales y de comportamiento en el mismo commit

### Disciplina de Commits

Hacer commit solo cuando se cumplan todas las condiciones:

- ✅ Todas las pruebas pasan
- ✅ Cero advertencias del compilador/linter
- ✅ Representa una unidad lógica de trabajo
- ✅ El mensaje de commit explica claramente los cambios

**Recomendaciones**:

- Commits pequeños y frecuentes
- Cada commit tiene significado independiente
- Granularidad que facilite seguir el historial

### Reglas de Refactorización

Reglas estrictas para refactorización:

1. **Condiciones Previas**
   - Comenzar solo con todas las pruebas pasando
   - No mezclar cambios de comportamiento con refactorización

2. **Proceso de Ejecución**
   - Usar patrones de refactorización establecidos
   - Un cambio a la vez
   - Ejecutar pruebas después de cada paso
   - Revertir inmediatamente si falla

3. **Patrones Comunes**
   - Extract Method (Extraer Método)
   - Rename (Renombrar)
   - Move Method (Mover Método)
   - Extract Variable (Extraer Variable)

### Enfoque de Implementación

Prioridades para implementación eficiente:

1. **Primer Paso**
   - Comenzar con el caso más simple
   - Priorizar "que funcione"
   - Progreso sobre perfección

2. **Principios de Calidad de Código**
   - Eliminar duplicación inmediatamente al encontrarla
   - Escribir código con intención clara
   - Dependencias explícitas
   - Métodos pequeños, responsabilidad única

3. **Mejora Gradual**
   - Primero hacer que funcione
   - Cubrir con pruebas
   - Luego optimizar

4. **Manejo de Casos Edge**
   - Considerar después de que funcione el caso básico
   - Agregar prueba para cada caso edge
   - Mejorar robustez gradualmente

## Aseguramiento de Calidad

### Principios de Diseño

- Cumplir principio de responsabilidad única
- Acoplamiento débil mediante interfaces
- Mejorar legibilidad con retornos tempranos
- Evitar abstracción excesiva

### Optimización de Eficiencia

- Eliminación automática de trabajo duplicado
- Uso activo de procesamiento por lotes
- Minimizar cambios de contexto

### Mantenimiento de Consistencia

- Herencia automática de estilo de código existente
- Aplicación automática de convenciones del proyecto
- Ejecución automática de unificación de nomenclatura

### Gestión Automática de Calidad

- Verificación de comportamiento antes y después de cambios
- Implementación considerando casos edge
- Actualización sincronizada de documentación

### Eliminación de Redundancia

- Siempre convertir procesos repetitivos en funciones
- Unificar manejo común de errores
- Uso activo de funciones de utilidad
- Abstracción inmediata de lógica duplicada

### Prohibición de Hardcoding

- Convertir números mágicos en constantes
- URLs y rutas en archivos de configuración
- Gestionar valores dependientes del entorno con variables de entorno
- Separar lógica de negocio y valores de configuración

### Manejo de Errores

- Cuando no se puede ejecutar: Presentar 3 alternativas
- Cuando es parcialmente ejecutable: Ejecutar parte posible primero, indicar claramente tareas pendientes

## Ejemplos de Ejecución

- **Corrección de Bug**: Encontrar `TypeError` → Corregir error de tipo inmediatamente
- **Refactorización**: Detectar código duplicado → Convertir en función común
- **Cambio de BD**: Necesita actualización de esquema → Solicitar confirmación "¿Cambiar estructura de tabla?"

## Mejora Continua

- Detectar nuevo patrón → Aprender y aplicar inmediatamente
- Feedback → Reflejar automáticamente en próxima ejecución
- Mejores prácticas → Actualizar constantemente
