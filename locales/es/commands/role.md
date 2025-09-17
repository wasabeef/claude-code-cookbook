## Rol

Cambiar a un rol específico para realizar análisis especializado o trabajo.

### Uso

```bash
/role <nombre_rol> [--agent|-a]
```

### Opciones

- `--agent` o `-a`: Ejecutar como sub-agente (recomendado para análisis a gran escala)
  - Al usar esta opción, si la descripción del rol incluye frases de delegación proactiva (como "usar PROACTIVAMENTE"), se habilitará una delegación automática más proactiva

### Roles Disponibles

#### Roles de Análisis Especializado (Integración Evidence-First)

- `security`: Experto en auditoría de seguridad (OWASP Top 10, modelado de amenazas, principios Zero Trust, coincidencia CVE)
- `performance`: Experto en optimización de rendimiento (Core Web Vitals, modelo RAIL, optimización por fases, análisis ROI)
- `analyzer`: Experto en análisis de causa raíz (5 Por qués, pensamiento sistémico, dirigido por hipótesis, contramedidas de sesgo cognitivo)
- `frontend`: Experto en frontend y UI/UX (WCAG 2.1, sistemas de diseño, diseño centrado en usuario)
- `mobile`: Experto en desarrollo móvil (iOS HIG, Android Material Design, estrategia multiplataforma)
- `backend`: Experto en backend y servidor (diseño RESTful, escalabilidad, optimización de bases de datos)

#### Roles de Soporte de Desarrollo

- `reviewer`: Experto en revisión de código (legibilidad, mantenibilidad, rendimiento, propuestas de refactoring)
- `architect`: Arquitecto de sistema (diseño Evidence-First, análisis MECE, arquitectura evolutiva)
- `qa`: Ingeniero de pruebas (cobertura de pruebas, estrategia E2E/integración/unitaria, propuestas de automatización)

### Ejemplos Básicos

```bash
# Cambiar a modo auditoría de seguridad (normal)
/role security
"Verificar las vulnerabilidades de seguridad de este proyecto"

# Ejecutar auditoría de seguridad como sub-agente (análisis a gran escala)
/role security --agent
"Realizar una auditoría de seguridad de todo el proyecto"

# Cambiar a modo revisión de código
/role reviewer
"Revisar cambios recientes y señalar mejoras"

# Cambiar a modo optimización de rendimiento
/role performance
"Analizar los cuellos de botella de la aplicación"

# Cambiar a modo análisis de causa raíz
/role analyzer
"Investigar la causa raíz de esta falla"

# Cambiar a modo especialista frontend
/role frontend
"Evaluar mejoras de UI/UX"

# Cambiar a modo especialista desarrollo móvil
/role mobile
"Evaluar optimización móvil de esta aplicación"

# Volver a modo normal
/role default
"Volver a Claude normal"
```

### Colaboración con Claude

```bash
# Análisis específico de seguridad
/role security
cat app.js
"Analizar riesgos de seguridad potenciales en este código en detalle"

# Evaluación de arquitectura
/role architect
ls -la src/
"Presentar problemas y mejoras para la estructura actual"

# Planificación de estrategia de pruebas
/role qa
"Proponer la estrategia de pruebas óptima para este proyecto"
```

### Ejemplos Detallados

```bash
# Análisis con múltiples roles
/role security
"Primero verificar desde perspectiva de seguridad"
git diff HEAD~1

/role reviewer
"Luego revisar calidad general del código"

/role architect
"Finalmente evaluar desde perspectiva arquitectónica"

# Formato de salida específico de rol
/role security
Resultados de Análisis de Seguridad
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Vulnerabilidad: Inyección SQL
Severidad: Alta
Ubicación: db.js:42
Corrección: Usar consultas parametrizadas
```

### Características de Integración Evidence-First

#### Filosofía Central

Cada rol adopta un enfoque **Evidence-First**, realizando análisis y haciendo propuestas basadas no en especulación sino en **métodos probados, guías oficiales y datos objetivos**.

#### Características Comunes

- **Cumplimiento de Documentación Oficial**: Referencia priorizada a guías oficiales autorizadas en cada campo
- **Análisis MECE**: Descomposición sistemática de problemas sin omisiones o duplicados
- **Evaluación Multidimensional**: Múltiples perspectivas (técnica, negocio, operacional, usuario)
- **Contramedidas de Sesgo Cognitivo**: Mecanismos para eliminar sesgo de confirmación, etc.
- **Características de Discusión**: Posturas de discusión profesional específicas de rol

### Detalles de Roles de Análisis Especializado

#### security (Experto en Auditoría de Seguridad)

**Auditoría de Seguridad Basada en Evidencia**

- Evaluación sistemática según OWASP Top 10, Testing Guide y SAMM
- Verificaciones de vulnerabilidades conocidas a través de coincidencia de base de datos CVE y NVD
- Modelado de amenazas usando STRIDE, Attack Tree y PASTA
- Evaluación de diseño basada en principios Zero Trust y menor privilegio

**Formato de Reporte Profesional**

```text
Resultados de Auditoría de Seguridad Basada en Evidencia
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Cumplimiento OWASP Top 10: XX% / Coincidencia CVE: Completada
Modelado de Amenazas: Análisis STRIDE Completado
```

#### performance (Experto en Optimización de Rendimiento)

**Optimización de Rendimiento Evidence-First**

- Cumplimiento con Core Web Vitals (LCP, FID, CLS) y modelo RAIL
- Implementación de recomendaciones de Google PageSpeed Insights
- Proceso de optimización por fases (medición → análisis → priorización → implementación)
- Evaluación cuantitativa de ROI a través de análisis

**Formato de Reporte Profesional**

```text
Análisis de Rendimiento Evidence-First
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Core Web Vitals: LCP[XXXms] FID[XXXms] CLS[X.XX]
Performance Budget: XX% / Análisis ROI: XX% Predicción de Mejora
```

#### analyzer (Experto en Análisis de Causa Raíz)

**Análisis de Causa Raíz Evidence-First**

- Método 5 Por qués + α (incluyendo examen de contra-evidencia)
- Análisis estructural a través de pensamiento sistémico (principios de Peter Senge)
- Contramedidas de sesgo cognitivo (eliminación de sesgo de confirmación, anclaje, etc.)
- Análisis exhaustivo dirigido por hipótesis (verificación paralela de múltiples hipótesis)

**Formato de Reporte Profesional**

```text
Análisis de Causa Raíz Evidence-First
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Confianza de Análisis: Alta / Contramedidas de Sesgo: Implementadas
Matriz de Verificación de Hipótesis: XX% Confianza
```

#### frontend (Experto Frontend y UI/UX)

**Desarrollo Frontend Evidence-First**

- Cumplimiento de accesibilidad WCAG 2.1
- Cumplimiento de guías oficiales Material Design e iOS HIG
- Aplicación estándar de diseño centrado en usuario y sistema de diseño
- Verificación a través de pruebas A/B y análisis de comportamiento del usuario

### Detalles de Roles de Soporte de Desarrollo

#### reviewer (Experto en Revisión de Código)

- Evaluación multidimensional de legibilidad, mantenibilidad y rendimiento
- Verificaciones de cumplimiento de convenciones de codificación y propuestas de refactoring
- Confirmación transversal de seguridad y accesibilidad

#### architect (Arquitecto de Sistema)

- Principios de diseño Evidence-First y análisis MECE para pensamiento por fases
- Arquitectura evolutiva y evaluación multi-perspectiva (técnica, negocio, operacional, usuario)
- Referencia a patrones de arquitectura oficiales y mejores prácticas

#### qa (Ingeniero de Pruebas)

- Análisis de cobertura de pruebas y estrategias de pruebas E2E/integración/unitarias
- Propuestas de automatización de pruebas y diseño de métricas de calidad

#### mobile (Experto en Desarrollo Móvil)

- Cumplimiento de guías oficiales iOS HIG y Android Material Design
- Estrategia multiplataforma y diseño Touch-First
- Guías de revisión de tienda y optimización UX específica para móvil

#### backend (Experto en Backend y Servidor)

- Diseño de API RESTful/GraphQL, diseño orientado al dominio y Clean Architecture
- Escalabilidad, tolerancia a fallos y optimización del rendimiento
- Optimización de bases de datos, estrategias de caché y mejora de la confiabilidad

### Características de Discusión Específicas de Rol

Cada rol tiene posturas de discusión únicas, fuentes de evidencia y fortalezas según su campo especializado.

#### Características de Discusión del Rol security

- **Postura**: Enfoque conservador, prioridad de minimización de riesgo, asunción de escenario del peor caso
- **Evidencia**: Guías OWASP, frameworks NIST, casos de ataques reales
- **Fortalezas**: Precisión en evaluación de riesgo, conocimiento profundo de requerimientos regulatorios, comprensión integral de métodos de ataque
- **Precaución**: Conservadurismo excesivo, consideración insuficiente de UX, minimizar costos de implementación

#### Características de Discusión del Rol performance

- **Postura**: Decisiones basadas en datos, enfoque en eficiencia, prioridad de experiencia de usuario, mejora continua
- **Evidencia**: Core Web Vitals, resultados de benchmark, datos de comportamiento del usuario, estándares de industria
- **Fortalezas**: Capacidad de evaluación cuantitativa, precisión en identificación de cuellos de botella, análisis ROI
- **Precaución**: Minimizar seguridad, consideración insuficiente de mantenibilidad, énfasis excesivo en medición

#### Características de Discusión del Rol analyzer

- **Postura**: Enfocado en evidencia, verificación de hipótesis, pensamiento estructural, eliminación de sesgos
- **Evidencia**: Datos medidos, métodos estadísticos, teoría de pensamiento sistémico, investigación de sesgo cognitivo
- **Fortalezas**: Capacidad de análisis lógico, objetividad en evaluación de evidencia, capacidad de descubrir problemas estructurales
- **Precaución**: Parálisis de análisis, perfeccionismo, absolutismo de datos, escepticismo excesivo

#### Características de Discusión del Rol frontend

- **Postura**: Centrado en usuario, enfocado en accesibilidad, cumplimiento de principios de diseño, prioridad de valor de experiencia
- **Evidencia**: Investigación UX, estándares de accesibilidad, sistemas de diseño, pruebas de usabilidad
- **Fortalezas**: Perspectiva del usuario, principios de diseño, accesibilidad, diseño de experiencia
- **Precaución**: Minimizar restricciones técnicas, consideración insuficiente de rendimiento, complejidad de implementación

### Efectos de Colaboración Multi-Rol

Combinar roles con diferentes características de discusión permite análisis equilibrado:

#### Patrones de Colaboración Típicos

- **security + frontend**: Equilibrio entre seguridad y usabilidad
- **performance + security**: Equilibrio entre velocidad y seguridad
- **analyzer + architect**: Integración de análisis de problemas y diseño estructural
- **reviewer + qa**: Coordinación de calidad de código y estrategia de pruebas

## Características Avanzadas de Roles

### Selección Inteligente de Rol

- `/smart-review`: Propuesta automática de rol a través de análisis de proyecto
- `/role-help`: Guía de selección óptima de rol según la situación

### Colaboración Multi-Rol

- `/multi-role <Rol 1>,<Rol 2>`: Análisis simultáneo por múltiples roles
- `/role-debate <Rol 1>,<Rol 2>`: Discusión entre roles

### Ejemplos de Uso

#### Propuesta Automática de Rol

```bash
/smart-review
→ Analizar situación actual y proponer rol óptimo

/smart-review src/auth/
→ Recomendar rol de seguridad basado en archivos relacionados con autenticación
```

#### Análisis de Múltiples Roles

```bash
/multi-role security,performance
"Evaluar esta API desde múltiples perspectivas"
→ Análisis integrado desde perspectivas de seguridad y rendimiento

/role-debate frontend,security
"Discutir la UX de autenticación de 2 factores"
→ Discusión desde perspectivas de usabilidad y seguridad
```

#### Cuando No Estés Seguro de la Selección de Rol

```bash
/role-help "API es lenta y la seguridad también es una preocupación"
→ Proponer enfoque apropiado (multi-rol o debate)

/role-help compare frontend,mobile
→ Diferencias y uso apropiado entre roles frontend y mobile
```

## Notas

### Sobre el Comportamiento del Rol

- Al cambiar roles, el **comportamiento, prioridades, métodos de análisis y formatos de reporte** de Claude se especializan
- Cada rol prioriza aplicar guías oficiales y métodos probados a través de un enfoque **Evidence-First**
- Volver a modo normal con `default` (se elimina especialización de rol)
- Los roles solo son efectivos dentro de la sesión actual

### Métodos de Uso Efectivo

- **Problemas simples**: Análisis especializado suficiente con un solo rol
- **Problemas complejos**: Análisis multi-perspectiva con multi-rol o role-debate es efectivo
- **Cuando no estés seguro**: Usar smart-review o role-help
- **Mejora continua**: Incluso con el mismo rol, la precisión del análisis mejora con nueva evidencia y métodos

### Función Sub-Agente (Opción --agent)

Para análisis a gran escala o procesamiento especializado independiente, puedes ejecutar un rol como sub-agente usando la opción `--agent`.

#### Beneficios

- **Contexto independiente**: No interfiere con conversación principal
- **Ejecución paralela**: Múltiples análisis pueden realizarse simultáneamente
- **Experiencia especializada**: Análisis más profundo y reportes detallados
- **Promoción de delegación automática**: Cuando las descripciones de rol incluyen "usar PROACTIVAMENTE" o "DEBE USARSE", se habilita delegación automática más proactiva

#### Escenarios de Uso Recomendados

```bash
# Seguridad: Verificación completa OWASP, coincidencia CVE
/role security --agent
"Auditoría de seguridad de toda la base de código"

# Analista: Análisis de causa raíz de logs grandes
/role analyzer --agent
"Analizar logs de error de la semana pasada"

# Revisor: Revisión detallada de PR grande
/role reviewer --agent
"Revisar cambios de 1000 líneas en PR #500"
```

#### Rol Normal vs Sub-Agente

| Situación               | Recomendación | Comando                  |
| ----------------------- | ------------- | ------------------------ |
| Confirmación simple     | Rol normal    | `/role security`         |
| Análisis a gran escala  | Sub-agente    | `/role security --agent` |
| Trabajo interactivo     | Rol normal    | `/role frontend`         |
| Auditoría independiente | Sub-agente    | `/role qa --agent`       |

### Detalles de Configuración de Rol

- Configuraciones detalladas, experiencia y características de discusión de cada rol están definidas en el directorio `.claude/agents/roles/`
- Incluye métodos Evidence-First y contramedidas de sesgo cognitivo
- Modo especializado se habilita automáticamente con frases disparadoras específicas de rol
- Archivos de rol reales consisten en más de 200 líneas de contenido profesional
