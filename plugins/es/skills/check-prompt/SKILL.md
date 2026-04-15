---
description: 'Evaluar y mejorar calidad de prompts de IA. Se activa con "revisar prompt", "evaluar calidad del prompt".'
allowed-tools:
  - Read
  - Grep
---

# Evaluar y mejorar calidad de prompts de IA

Una colección comprensiva de mejores prácticas para evaluar y mejorar la calidad de prompts para Agentes AI. Sistematiza conocimiento obtenido de procesos reales de mejora de prompts, cubriendo aspectos importantes como eliminación de ambigüedad, integración de información, mejora de cumplimiento, sistemas de seguimiento y mejora continua.

## Uso

```bash
# Verificar la calidad de un archivo prompt
cat your-prompt.md
/check-prompt
"Verificar la calidad de este prompt y sugerir mejoras"
```

## Opciones

- Ninguna: Analizar archivo actual o texto seleccionado
- `--category <nombre>`: Verificar solo categoría específica (structure/execution/restrictions/quality/roles/improvement)
- `--score`: Calcular solo puntuación de calidad
- `--fix`: Sugerir automáticamente correcciones para problemas detectados
- `--deep`: Modo de análisis profundo (enfocar en ambigüedad, dispersión de información y cumplimiento)

## Ejemplos Básicos

```bash
# Evaluar calidad general del prompt
cat devin/playbooks/code-review.md
/check-prompt
"Evaluar este prompt a través de 6 categorías y sugerir mejoras"

# Modo de análisis profundo
/check-prompt --deep
"Enfocar en verificar ambigüedad, dispersión de información y falta de cumplimiento para sugerir mejoras fundamentales"

# Verificar categoría específica
/check-prompt --category structure
"Verificar este prompt desde la perspectiva de estructura y claridad"

# Detectar y corregir expresiones ambiguas
/check-prompt --fix
"Detectar expresiones ambiguas y sugerir correcciones para claridad"
```

---

## Principios de Diseño Fundamentales

## Principio 1: Eliminar Completamente Espacio para Interpretación

- **Absolutamente Prohibido**: "En principio", "Recomendado", "Si es posible", "Dependiendo de la situación", "Usa tu juicio"
- **Debe Usar**: "Siempre", "Absolutamente", "Observar estrictamente", "Sin excepción", "Obligatorio"
- **Condiciones de Excepción**: Estrictamente limitadas por números ("Solo bajo las siguientes 3 condiciones", "Excepto en estos 2 casos")

## Principio 2: Integración Estratégica de Información

- Integrar completamente información importante relacionada en una sección
- Resumir el panorama general en una lista de verificación de ejecución
- Eliminar completamente referencias circulares y dispersión

## Principio 3: Construcción de Cumplimiento Gradual

- Jerarquía clara de 🔴 (Nivel de parada de ejecución) → 🟡 (Calidad importante) → 🟢 (Elementos recomendados)
- Actualización gradual de nivel recomendado a obligatorio
- Indicación explícita de impacto y contramedidas para violaciones

## Principio 4: Asegurar Trazabilidad

- Todos los resultados de ejecución pueden ser registrados y verificados
- Prevenir técnicamente reportes falsos
- Criterios objetivos para juicio de éxito/falla

## Principio 5: Mejora Impulsada por Retroalimentación

- Aprender de casos de falla reales
- Verificación continua de efectividad
- Detección automática de nuevos patrones

---

## 📋 Elementos de Verificación Comprensivos

## 1. 📐 Estructura y Claridad (Peso: 25 puntos)

### 1.1 Indicación de Prioridad de Instrucciones (8 puntos)

- [ ] Prioridades 🔴🟡🟢 están claramente indicadas para todas las instrucciones importantes
- [ ] Condiciones para nivel de parada de ejecución están específica y claramente definidas
- [ ] Criterios para cada nivel de prioridad son objetivos y verificables

### 1.2 Eliminación Completa de Expresiones Ambiguas (9 puntos)

- [ ] **Expresiones ambiguas fatales**: 0 instancias de "En principio", "Recomendado", "Si es posible"
- [ ] **Uso de expresiones obligatorias**: Uso apropiado de "Siempre", "Absolutamente", "Observar estrictamente"
- [ ] **Limitación numérica de condiciones de excepción**: Límites claros como "Solo 3 condiciones"

### 1.3 Integración Estratégica de Información (8 puntos)

- [ ] Dispersión en múltiples ubicaciones de información importante está completamente eliminada
- [ ] Instrucciones relacionadas están lógicamente integradas en una sección
- [ ] El panorama general está completamente resumido en la lista de verificación de ejecución

## 2. 🎯 Ejecutabilidad (Peso: 20 puntos)

### 2.1 Completitud de Procedimientos Específicos (7 puntos)

- [ ] Todos los ejemplos de comandos son realmente ejecutables y verificados
- [ ] Variables de entorno, prerrequisitos y dependencias están claramente establecidos
- [ ] Métodos de manejo de errores son específicos y ejecutables

### 2.2 Asegurar Verificabilidad (7 puntos)

- [ ] Éxito/falla de resultados de ejecución puede determinarse objetivamente
- [ ] Ejemplos de salida, formatos de log y valores esperados se muestran específicamente
- [ ] Métodos de prueba y procedimientos de verificación pueden implementarse
- [ ] Puntos de verificación de resultados intermedios están apropiadamente colocados

### 2.3 Adaptabilidad a Automatización (6 puntos)

- [ ] Formato fácil para scriptización e integración CI/CD
- [ ] Separación clara entre puntos de juicio humano y ejecución AI
- [ ] Correspondencia a procesamiento por lotes y ejecución paralela

## 3. 🚫 Clarificación de Elementos Prohibidos (Peso: 15 puntos)

### 3.1 Sistematización de Prohibiciones Absolutas (8 puntos)

- [ ] Lista completa de operaciones que no deben realizarse
- [ ] Indicación explícita de nivel de impacto (menor/mayor/fatal) para cada violación
- [ ] Presentación específica de alternativas y métodos de evitación
- [ ] Explicación del fundamento técnico de los elementos prohibidos

### 3.2 Limitación Estricta de Condiciones de Excepción (7 puntos)

- [ ] Condiciones para permitir excepciones son específicas y limitadas (especificación numérica)
- [ ] Criterios de juicio objetivos como "Completamente duplicado", "Explícitamente establecido"
- [ ] Límites claros sin dejar zonas grises
- [ ] Indicación explícita de condiciones adicionales y restricciones al aplicar excepciones

## 4. 📊 Mecanismos de Aseguramiento de Calidad (Peso: 20 puntos)

### 4.1 Completitud del Sistema de Seguimiento (8 puntos)

- [ ] Función de registro automático y recolección de estadísticas para todos los resultados de ejecución
- [ ] Función de verificación para prevenir técnicamente reportes falsos
- [ ] Funciones de monitoreo en tiempo real y alertas
- [ ] Función de prevención de alteración de logs de auditoría

### 4.2 Cumplimiento Forzado de Plantillas (7 puntos)

- [ ] Definición clara de elementos obligatorios y función de verificación
- [ ] Restricción técnica de ubicaciones prohibidas para personalización
- [ ] Puntos de verificación automatizados para confirmación de cumplimiento
- [ ] Función automática de corrección y advertencia para violaciones

### 4.3 Cobertura Comprensiva de Manejo de Errores (5 puntos)

- [ ] Catalogación completa de patrones de error esperados
- [ ] Proceso de manejo gradual durante errores
- [ ] Prevención técnica de reportar fallas como éxitos

## 5. 🎭 Clarificación de Roles y Responsabilidades (Peso: 10 puntos)

### 5.1 Alcance de Autoridad del Agente AI (5 puntos)

- [ ] Límites claros entre operaciones ejecutables y prohibidas
- [ ] Alcance específico y restricciones de autoridad de juicio
- [ ] Separación clara de operaciones que requieren confirmación humana

### 5.2 Unificación del Sistema de Clasificación (5 puntos)

- [ ] Claridad, unicidad y exclusividad de definiciones de clasificación
- [ ] Explicación explícita para prevenir malentendidos sobre importancia entre clasificaciones
- [ ] Ejemplos específicos de uso de cada clasificación y diagramas de flujo de juicio

## 6. 🔄 Mejora Continua (Peso: 10 puntos)

### 6.1 Automatización de Recolección de Retroalimentación (5 puntos)

- [ ] Extracción automática de puntos de mejora de logs de ejecución
- [ ] Análisis basado en machine learning de patrones de falla
- [ ] Mecanismo de actualización automática de mejores prácticas

### 6.2 Implementación de Función de Aprendizaje (5 puntos)

- [ ] Detección automática y clasificación de nuevos patrones
- [ ] Monitoreo continuo de efectividad de reglas existentes
- [ ] Sugerencia automática de mejoras graduales

---

## 🚨 Patrones de Problemas Fatales (Corrección Inmediata Requerida)

## ❌ Nivel 1: Ambigüedad Fatal (Nivel de Parada de Ejecución)

- **Instrucciones con múltiples interpretaciones**: "Usa tu juicio", "Dependiendo de la situación", "En principio"
- **Condiciones de excepción ambiguas**: "En casos especiales", "Según sea necesario"
- **Criterios de juicio subjetivos**: "Apropiadamente", "Suficientemente", "Tanto como sea posible"
- **Conceptos importantes no definidos**: "Estándar", "General", "Básico"

## ❌ Nivel 2: Defectos Estructurales (Nivel Importante de Calidad)

- **Dispersión de información**: Información importante relacionada dispersa en 3 o más ubicaciones
- **Referencias circulares**: Bucles infinitos de sección A→B→C→A
- **Instrucciones contradictorias**: Instrucciones contradictorias en diferentes secciones
- **Orden de ejecución poco claro**: Procedimientos con dependencias poco claras

## ❌ Nivel 3: Degradación de Calidad (Nivel de Mejora Recomendada)

- **No verificabilidad**: Criterios poco claros para juicio de éxito/falla
- **Dificultad en automatización**: Diseño dependiente de juicio subjetivo humano
- **Dificultad en mantenimiento**: Estructura donde el rango de impacto durante actualizaciones no puede predecirse
- **Dificultad de aprendizaje**: Complejidad que requiere mucho tiempo para que nuevos usuarios entiendan

---

## 🎯 Métodos de Mejora Probados

## ✅ Enfoque de Mejora Gradual

1. **Análisis de situación actual**: Clasificación, priorización y evaluación de impacto de problemas
2. **Prioridad de problemas fatales**: Máxima prioridad en resolución completa de problemas de Nivel 1
3. **Implementación gradual**: Implementar en unidades verificables sin hacer todos los cambios a la vez
4. **Medición de efectos**: Comparación cuantitativa antes y después de la mejora
5. **Monitoreo continuo**: Confirmación de sostenibilidad de efectos de mejora

## ✅ Métodos Prácticos para Eliminación de Ambigüedad

```markdown
# ❌ Antes de Mejora (Ambiguo)

"Los comentarios deben, en principio, escribirse como comentarios en línea en los puntos de cambio correspondientes en GitHub"

# ✅ Después de Mejora (Claro)

"Los comentarios deben escribirse como comentarios en línea en los puntos de cambio correspondientes en GitHub. Las excepciones son solo las 3 condiciones definidas en la sección 3.3"
```

## ✅ Métodos Prácticos para Integración de Información

```markdown
# ❌ Antes de Mejora (Disperso)

Sección 2.1: "Usar 6 secciones obligatorias"
Sección 3.5: "📊 Evaluación comprensiva, 📋 Elementos señalados..."
Sección 4.2: "Prohibido eliminar secciones"

# ✅ Después de Mejora (Integrado)

Lista de verificación de ejecución:
□ 10. Publicar comentario de resumen (usar 6 secciones obligatorias)
🔴 6 secciones obligatorias: 1) 📊 Evaluación comprensiva 2) 📋 Agregado por categoría de elementos señalados 3) ⚠️ Principales preocupaciones 4) ✅ Puntos evaluables 5) 🎯 Conclusión 6) 🤖 Autoevaluación de calidad de revisión AI
❌ Absolutamente prohibido: Eliminar, agregar o cambiar nombres de secciones
```

## ✅ Patrones de Implementación de Sistema de Seguimiento

```bash
# Seguimiento estricto de resultados de ejecución
POSTED_COMMENTS=0
FAILED_COMMENTS=0
TOTAL_COMMENTS=0

# Registro de resultados de cada operación
if [ $? -eq 0 ]; then
    echo "✅ Éxito: $OPERATION" >> /tmp/execution_log.txt
    POSTED_COMMENTS=$((POSTED_COMMENTS + 1))
else
    echo "❌ Falla: $OPERATION" >> /tmp/execution_log.txt
    FAILED_COMMENTS=$((FAILED_COMMENTS + 1))
fi

# Prevención de reportes falsos
if [ $POSTED_COMMENTS -ne $REPORTED_COMMENTS ]; then
    echo "🚨 Advertencia: Discrepancia entre número reportado y publicaciones reales"
    exit 1
fi
```

---

## 📈 Cálculo de Puntuación de Calidad

## Cálculo de Puntuación Comprensiva

```text
Puntuación básica = Σ(puntuación de categoría × peso) / 100

Penalizaciones por problemas fatales:
- Problema de Nivel 1: -20 puntos por caso
- Problema de Nivel 2: -10 puntos por caso
- Problema de Nivel 3: -5 puntos por caso

Elementos de bonificación:
- Correspondencia a automatización: +5 puntos
- Implementación de función de aprendizaje: +5 puntos
- Casos de mejora probados: +5 puntos

Puntuación final = Puntuación básica + Bonos - Penalizaciones
```

## Evaluación de Nivel de Calidad

```text
95-100 puntos: Estándar mundial más alto (Recomendado como estándar de industria)
90-94 puntos: Excelente (Listo para producción)
80-89 puntos: Bueno (Listo para operación con mejoras menores)
70-79 puntos: Promedio (Necesita mejora)
60-69 puntos: Necesita mejora (Requiere corrección significativa)
50-59 puntos: Necesita corrección mayor (Requiere revisión fundamental)
49 puntos o menos: Prohibido de uso (Requiere rediseño completo)
```

---

## 🔧 Proceso de Mejora Práctica

## Fase 1: Diagnóstico/Análisis (1-2 días)

1. **Comprensión de estructura general**: Visualización de composición de secciones, flujo de información y dependencias
2. **Detección de ambigüedad**: Extracción de todas las expresiones con espacio para interpretación
3. **Análisis de dispersión de información**: Mapeo de patrones dispersos de información relacionada
4. **Evaluación de cumplimiento**: Evaluación de clasificación recomendada/obligatoria y efectividad

## Fase 2: Priorización/Planificación (Medio día)

1. **Clasificación de fatalidad**: Clasificación de problemas en Niveles 1-3 y evaluación de impacto
2. **Determinación de orden de mejora**: Orden óptimo considerando interdependencias
3. **Asignación de recursos**: Optimización de balance entre efectos de mejora y costos

## Fase 3: Implementación Gradual (2-5 días)

1. **Resolución de problemas de Nivel 1**: Eliminación completa de ambigüedades fatales
2. **Implementación de integración de información**: Agregación estratégica de información dispersa
3. **Mejora de cumplimiento**: Actualización gradual de recomendado a obligatorio
4. **Implementación de sistema de seguimiento**: Funciones automáticas de registro y verificación de resultados de ejecución
5. **Fortalecimiento de plantillas**: Clarificación de elementos obligatorios y cumplimiento forzado

## Fase 4: Verificación y Ajuste (1-2 días)

1. **Prueba funcional**: Confirmación del funcionamiento de todos los puntos de cambio
2. **Prueba de integración**: Confirmación de consistencia de todo el sistema
3. **Prueba de rendimiento**: Confirmación de eficiencia de ejecución y respuesta
4. **Prueba de usabilidad**: Verificación en escenarios de uso real

## Fase 5: Operación y Monitoreo (Continuo)

1. **Medición de efectos**: Comparación cuantitativa antes y después de mejoras
2. **Monitoreo continuo**: Detección temprana de degradación de calidad
3. **Recolección de retroalimentación**: Extracción de problemas en operación real
4. **Optimización continua**: Ciclo de mejora continua

---

## 📊 Casos de Mejora Reales (Versión Detallada)

## Estudio de Caso: Mejora de Calidad de Prompt a Gran Escala

### Situación Antes de la Mejora

```bash
Puntuación de calidad: 70 puntos/100 puntos
- Expresiones ambiguas: 15 casos encontrados
- Dispersión de información: Información importante dispersa en 6 ubicaciones
- Falta de cumplimiento: 80% de expresiones de nivel recomendado
- Función de seguimiento: Sin registro de resultados de ejecución
- Manejo de errores: Método de manejo durante fallas poco claro
```

### Contenido de Mejoras Implementadas

```bash
# 1. Eliminación de ambigüedad (2 días)
- "En principio" → "Las excepciones son solo las 3 condiciones en sección 3.3"
- "Recomendado" → "Obligatorio" (nivel de importancia 2 o superior)
- "Según sea apropiado" → Indicación explícita de criterios específicos de juicio

# 2. Integración de información (1 día)
- Información dispersa de 6 secciones obligatorias → Integración en lista de verificación de ejecución
- Elementos prohibidos relacionados → Agregación en una sección
- Resolución de referencias circulares → Flujo de información lineal

# 3. Implementación de sistema de seguimiento (1 día)
- Registro automático de logs de resultados de ejecución
- Función de verificación para prevención de reportes falsos
- Visualización de estadísticas en tiempo real

# 4. Fortalecimiento de manejo de errores (medio día)
- Catalogación completa de patrones de error esperados
- Codificación de procesos de manejo gradual
- Implementación de función de recuperación automática
```

### Resultados Después de la Mejora

```bash
Puntuación de calidad: 90 puntos/100 puntos (mejora de +20 puntos)
- Expresiones ambiguas: 0 casos (eliminación completa)
- Integración de información: Información importante agregada en 3 ubicaciones
- Cumplimiento: 95% expresiones de nivel obligatorio
- Función de seguimiento: Automatización completa
- Manejo de errores: 90% de problemas resueltos automáticamente

Efectos de mejora reales:
- Errores de juicio: 85% reducción
- Tiempo de ejecución: 40% reducción
- Tasa de errores: 70% reducción
- Satisfacción del usuario: 95% mejora
```

## Lecciones Aprendidas y Mejores Prácticas

### Factores de Éxito

1. **Enfoque gradual**: Implementar en unidades verificables sin hacer todos los cambios a la vez
2. **Impulsado por datos**: Mejora basada en datos medidos, no juicio subjetivo
3. **Monitoreo continuo**: Confirmación periódica de sostenibilidad de efectos de mejora
4. **Énfasis en retroalimentación**: Recolección activa de opiniones de usuarios reales

### Estrategias de Evitación de Fallas

1. **Perfeccionismo excesivo**: Comenzar operación al alcanzar 90 puntos, apuntar a 100 puntos con mejora continua
2. **Peligro de cambios masivos**: Implementar siempre cambios a gran escala gradualmente
3. **Compatibilidad hacia atrás**: Minimizar impacto en flujos de trabajo existentes
4. **Falta de documentación**: Registro detallado y compartir todos los cambios

---

## Colaboración con Claude

```bash
# Verificación de calidad combinada con archivo prompt
cat your-prompt.md
/check-prompt
"Evaluar la calidad de este prompt y sugerir mejoras"

# Comparación de múltiples archivos prompt
cat prompt-v1.md && echo "---" && cat prompt-v2.md
/check-prompt
"Comparar las dos versiones y analizar puntos mejorados y problemas restantes"

# Análisis combinado con logs de errores reales
cat execution-errors.log
/check-prompt --deep
"Identificar problemas potenciales de prompt que podrían haber causado este error"
```

## Notas

- **Prerrequisito**: Se recomienda escribir archivos prompt en formato Markdown
- **Limitación**: Para prompts a gran escala (10,000 líneas o más), se recomienda analizar por partes
- **Recomendación**: Verificar regularmente la calidad del prompt y mejorar continuamente

---

_Esta lista de verificación es una versión completa de conocimiento probado en proyectos reales de mejora de prompts y continúa evolucionando continuamente._
