## Debate de Roles

Un comando que permite que roles con diferentes experticias discutan y examinen trade-offs para derivar soluciones óptimas.

### Uso

```bash
/role-debate <Rol 1>,<Rol 2> [Tópico]
/role-debate <Rol 1>,<Rol 2>,<Rol 3> [Tópico]
```

### Ejemplos Básicos

```bash
# Trade-off entre Seguridad y Rendimiento
/role-debate security,performance
"Configuración de Expiración de Token JWT"

# Balance entre Usabilidad y Seguridad
/role-debate frontend,security
"Optimización de UX para Autenticación de 2 Factores"

# Discusión de selección de tecnología
/role-debate architect,mobile
"Selección entre React Native vs Flutter"

# Debate de tres partes
/role-debate architect,security,performance
"Pros y Contras de Microservicios"
```

### Principios Básicos del Debate

#### Directrices de Debate Constructivo

- **Respeto Mutuo**: Respetar la experiencia y perspectivas de otros roles
- **Basado en Hechos**: Debatir basado en datos y evidencia, no reacciones emocionales
- **Orientado a Soluciones**: Apuntar a mejores soluciones en lugar de criticar por criticar
- **Enfocado en Implementación**: Considerar factibilidad en lugar de idealismo

#### Requisitos de Calidad para Argumentos

- **Documentación Oficial**: Referenciar estándares, directrices y documentación oficial
- **Casos Empíricos**: Citaciones específicas de casos de éxito o falla
- **Evaluación Cuantitativa**: Comparaciones usando números y métricas cuando sea posible
- **Consideración de Series Temporales**: Evaluación de impactos a corto, mediano y largo plazo

#### Ética del Debate

- **Honestidad**: Reconocer los límites de tu experiencia
- **Apertura**: Flexibilidad hacia nueva información y perspectivas
- **Transparencia**: Declarar explícitamente fundamentos de juicio y suposiciones
- **Responsabilidad**: Mencionar riesgos de implementación de propuestas

### Proceso de Debate

### Fase 1: Declaración de Posición Inicial

Cada rol expresa independientemente opiniones desde su perspectiva profesional

- Presentación de recomendaciones
- Citación explícita de estándares y documentos como fundamentos
- Explicación de riesgos y problemas anticipados
- Definición de métricas de éxito

### Fase 2: Discusión Mutua y Refutación

Discusión cruzada entre roles

- Refutación constructiva de propuestas de otros roles
- Identificación de perspectivas pasadas por alto
- Clarificación de trade-offs
- Presentación de alternativas

### Fase 3: Búsqueda de Compromisos

Exploración de soluciones implementables

- Evaluación de la importancia de cada perspectiva
- Consideración de soluciones ganar-ganar
- Enfoque de implementación paso a paso
- Consideración de medidas de mitigación de riesgos

### Fase 4: Conclusión Integrada

Determinación de recomendaciones finales

- Solución acordada
- Hoja de ruta de implementación
- Métricas de éxito y métodos de medición
- Puntos de revisión futura

### Ejemplos de Formato de Salida

### Para Debate de 2 Roles

```text
Debate de Roles: Seguridad vs Rendimiento
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Tópico: Configuración de Expiración de Token JWT

Argumento del Rol de Seguridad:
"Se recomienda expiración corta de 15 minutos"

Fundamentos:
- Cumplimiento con OWASP JWT Security Cheat Sheet
- Minimizar ventana de daño en caso de filtración de token
- Limitar tiempo disponible para atacante

Preocupaciones:
- Expiración larga aumenta exponencialmente riesgo de ataque
- Expiración corta obligatoria para cumplimiento financiero

Métricas de Éxito:
- Tasa de incidentes de seguridad < 0.1%
- Tiempo promedio de detección de ataque < 5 minutos

Refutación del Rol de Rendimiento:
"Se recomienda expiración de 2 horas"

Fundamentos:
- Referencia a Google OAuth 2.0 Best Practices
- Evitar aumento de carga del servidor por reautenticación frecuente
- Minimizar interrupción de experiencia de usuario

Preocupaciones:
- Reautenticación de 15 minutos aumenta carga de API por 8x
- Desconexiones frecuentes en entornos móviles

Métricas de Éxito:
- Mantener tiempo de respuesta API < 200ms
- Uso de CPU del servidor < 60%

Discusión Mutua:
Seguridad → Rendimiento:
"Las pérdidas comerciales por brechas de seguridad son mayores que la carga del servidor.
Ejemplo: la brecha de Equifax costó $700 millones"

Rendimiento → Seguridad:
"Ambos se pueden lograr con mecanismo de refresh token.
Actualizaciones en segundo plano aseguran seguridad sin comprometer UX"

Seguridad → Rendimiento:
"Los refresh tokens también son objetivos de ataque. Implementación apropiada es prerequisito"

Rendimiento → Seguridad:
"Proponer enfoque por fases. 30 minutos para operaciones normales, 15 minutos para operaciones sensibles"

Búsqueda de Compromiso:
Entendimiento Común:
- Necesidad de balancear experiencia de usuario y seguridad
- Respuesta flexible basada en nivel de riesgo
- Consideración práctica de costos de implementación y operación

Elementos Ganar-Ganar:
- Utilización de mecanismo de refresh token
- Introducción por fases de autenticación basada en riesgo
- Complementación con función de auto-logout

Conclusión Integrada:
"Expiración de 30 minutos + refresh token + autenticación basada en riesgo"

Detalles de Implementación:
1. Access token: Expiración de 30 minutos
2. Refresh token: Expiración de 7 días
3. Operaciones de alto riesgo: Forzar reautenticación cada 15 minutos
4. Auto-logout después de 30 minutos de inactividad

Implementación Por Fases:
Semanas 1-2: Implementación básica de token de 30 minutos
Semanas 3-4: Agregar mecanismo de refresh token
Mes 2: Introducir autenticación basada en riesgo

Métricas de Éxito:
- Seguridad: Tasa de incidentes < 0.1%
- Rendimiento: Aumento de carga API < 20%
- UX: Satisfacción de usuario > 85%

Revisión Futura:
- Después de 3 meses: Evaluar patrones de ataque reales y condiciones de carga
- Después de 6 meses: Considerar migración a autenticación basada en riesgo más sofisticada
```

### Para Debate de 3 Roles

```text
Debate de Roles: Architect vs Security vs Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Tópico: Pros y Contras de Microservicios

Argumento del Rol Architect:
"Se recomiendan microservicios por fases"
Fundamentos: Límites de dominio claros, despliegue independiente, libertad en selección de tecnología

Preocupaciones del Rol Security:
"Complejidad de seguridad de comunicación entre servicios"
Fundamentos: Costos de gestión de API Gateway, mTLS, autenticación distribuida

Preocupaciones del Rol Performance:
"Aumento de latencia debido a comunicación de red"
Fundamentos: Problema N+1 por llamadas API internas, transacciones distribuidas

Discusión de Tres Partes:
Architect → Security: "Se puede controlar a través de gestión centralizada de API Gateway"
Security → Architect: "Riesgo de punto único de falla"
Performance → Architect: "La granularidad de división de servicios es importante"
...(la discusión continúa)

Conclusión Integrada:
"Diseño dirigido por dominio para división por fases + diseño security-first"
```

### Patrones de Debate Efectivos

### Selección de Tecnología

```bash
/role-debate architect,performance
"Selección de Base de Datos: PostgreSQL vs MongoDB"

/role-debate frontend,mobile
"Framework de UI: React vs Vue"

/role-debate security,architect
"Método de Autenticación: JWT vs Session Cookie"
```

### Decisiones de Diseño

```bash
/role-debate security,frontend
"Diseño de UX para Autenticación de Usuario"

/role-debate performance,mobile
"Optimización de Estrategia de Sincronización de Datos"

/role-debate architect,qa
"Estrategia de Testing y Diseño de Arquitectura"
```

### Problemas de Trade-off

```bash
/role-debate security,performance
"Nivel de Encriptación vs Velocidad de Procesamiento"

/role-debate frontend,performance
"UI Rica vs Velocidad de Carga de Página"

/role-debate mobile,security
"Conveniencia vs Nivel de Protección de Datos"
```

### Características de Debate Específicas del Rol

#### 🔒 Rol Security

```yaml
debate_stance:
  - Enfoque conservador (minimización de riesgos)
  - Enfocado en cumplimiento (cauteloso sobre desviaciones de estándares)
  - Suposición de peor escenario (perspectiva de atacante)
  - Enfoque en impacto a largo plazo (seguridad como deuda técnica)

typical_issues:
  - Trade-offs "Seguridad vs Conveniencia"
  - "Requisitos de cumplimiento obligatorio"
  - "Comparación de costo de ataque vs costo de defensa"
  - "Protección exhaustiva de privacidad"

evidence_sources:
  - Directrices OWASP
  - Frameworks NIST
  - Estándares de industria (ISO 27001, SOC 2)
  - Casos de ataque reales y estadísticas

debate_strengths:
  - Precisión en evaluación de riesgos
  - Conocimiento de requisitos regulatorios
  - Comprensión de métodos de ataque

potential_biases:
  - Conservadurismo excesivo (inhibir innovación)
  - Consideración insuficiente de UX
  - Subestimar costos de implementación
```

#### ⚡ Rol Performance

```yaml
debate_stance:
  - Decisiones basadas en datos (basadas en medición)
  - Enfocado en eficiencia (optimizar costo-efectividad)
  - Prioridad de experiencia de usuario (enfoque en velocidad percibida)
  - Mejora continua (optimización por fases)

typical_issues:
  - "Rendimiento vs Seguridad"
  - "ROI de costo de optimización vs efectividad"
  - "Escalabilidad actual vs futura"
  - "Experiencia de usuario vs eficiencia de sistema"

evidence_sources:
  - Métricas Core Web Vitals
  - Resultados de benchmark y estadísticas
  - Datos de impacto en comportamiento de usuario
  - Estándares de rendimiento de industria

debate_strengths:
  - Capacidad de evaluación cuantitativa
  - Identificación de cuellos de botella
  - Conocimiento de técnicas de optimización

potential_biases:
  - Subestimar seguridad
  - Consideración insuficiente de mantenibilidad
  - Optimización prematura
```

#### 🏗️ Rol Architect

```yaml
debate_stance:
  - Perspectiva a largo plazo (consideración para evolución del sistema)
  - Búsqueda de balance (optimización general)
  - Cambios por fases (gestión de riesgos)
  - Cumplimiento de estándares (preferencia por patrones probados)

typical_issues:
  - "Eficiencia a corto plazo vs mantenibilidad a largo plazo"
  - "Deuda técnica vs velocidad de desarrollo"
  - "Microservicios vs monolito"
  - "Adopción de nueva tecnología vs estabilidad"

evidence_sources:
  - Colecciones de patrones de arquitectura
  - Principios de diseño (SOLID, DDD)
  - Casos de sistemas a gran escala
  - Tendencias de evolución tecnológica

debate_strengths:
  - Capacidad de perspectiva general
  - Conocimiento de patrones de diseño
  - Predicción de impactos a largo plazo

potential_biases:
  - Generalización excesiva
  - Conservadurismo hacia nuevas tecnologías
  - Comprensión insuficiente de detalles de implementación
```

#### 🎨 Rol Frontend

```yaml
debate_stance:
  - Diseño centrado en usuario (prioridad UX primero)
  - Enfoque inclusivo (consideración de diversidad)
  - Enfoque en intuitividad (minimizar costos de aprendizaje)
  - Estándares de accesibilidad (cumplimiento WCAG)

typical_issues:
  - "Usabilidad vs Seguridad"
  - "Consistencia de diseño vs optimización de plataforma"
  - "Funcionalidad vs simplicidad"
  - "Rendimiento vs experiencia rica"

evidence_sources:
  - Investigación UX y resultados de pruebas de usabilidad
  - Directrices de accesibilidad
  - Estándares de sistema de diseño
  - Datos de comportamiento de usuario

debate_strengths:
  - Representación de perspectiva de usuario
  - Conocimiento de principios de diseño
  - Requisitos de accesibilidad

potential_biases:
  - Comprensión insuficiente de restricciones técnicas
  - Subestimar requisitos de seguridad
  - Subestimación de impacto de rendimiento
```

#### 📱 Rol Mobile

```yaml
debate_stance:
  - Especialización de plataforma (considerar diferencias iOS/Android)
  - Adaptación de contexto (en movimiento, operación con una mano)
  - Restricciones de recursos (batería, memoria, comunicación)
  - Cumplimiento de tienda (directrices de revisión)

typical_issues:
  - "Nativo vs multiplataforma"
  - "Soporte offline vs sincronización en tiempo real"
  - "Eficiencia de batería vs funcionalidad"
  - "Unificación de plataforma vs optimización"

evidence_sources:
  - iOS HIG / Android Material Design
  - Directrices de App Store / Google Play
  - Investigación UX móvil
  - Estadísticas de rendimiento de dispositivos

debate_strengths:
  - Comprensión de restricciones específicas de móvil
  - Conocimiento de diferencias de plataforma
  - Diseño de interfaz táctil

potential_biases:
  - Comprensión insuficiente de plataforma web
  - Subestimar restricciones del lado del servidor
  - Consideración insuficiente para entorno de escritorio
```

#### 🔍 Rol Analyzer

```yaml
debate_stance:
  - Enfocado en evidencia (datos primero)
  - Verificación de hipótesis (enfoque científico)
  - Pensamiento estructural (pensamiento de sistemas)
  - Eliminación de sesgos (búsqueda de objetividad)

typical_issues:
  - "Correlación vs causalidad"
  - "Tratamiento sintomático vs solución de raíz"
  - "Distinción entre hipótesis y hecho"
  - "Síntomas a corto plazo vs problemas estructurales"

evidence_sources:
  - Datos medidos y análisis de logs
  - Métodos estadísticos y resultados de análisis
  - Teoría de pensamiento de sistemas
  - Investigación de sesgos cognitivos

debate_strengths:
  - Capacidad de análisis lógico
  - Objetividad en evaluación de evidencia
  - Descubrimiento de problemas estructurales

potential_biases:
  - Parálisis de análisis (acción insuficiente)
  - Perfeccionismo (subestimar practicidad)
  - Absolutismo de datos
```

### Plantillas de Progresión de Debate

#### Plantilla de Declaración de Posición Fase 1

```text
Recomendación de [Nombre de Rol]:
"[Propuesta específica]"

Fundamentos:
- [Referencia a documentos/estándares oficiales]
- [Casos/datos empíricos]
- [Principios de campo profesional]

Efectos Esperados:
- [Efectos a corto plazo]
- [Efectos a mediano y largo plazo]

Preocupaciones/Riesgos:
- [Riesgos de implementación]
- [Riesgos operacionales]
- [Impactos en otros campos]

Métricas de Éxito:
- [Métrica medible 1]
- [Métrica medible 2]
```

#### Plantilla de Refutación Fase 2

```text
Refutación a [Rol Objetivo]:
"[Refutación específica a propuesta objetivo]"

Fundamentos de Refutación:
- [Perspectivas pasadas por alto]
- [Evidencia/casos contradictorios]
- [Preocupaciones del campo profesional]

Propuesta Alternativa:
"[Propuesta mejorada]"

Puntos de Compromiso:
- [Condiciones aceptables]
- [Posibilidad de implementación por fases]
```

#### Plantilla de Solución Integrada Fase 3

```text
Solución Integrada:
"[Propuesta final considerando preocupaciones de todos los roles]"

Consideraciones para Cada Rol:
- [Seguridad]: [Cómo se cumplen requisitos de seguridad]
- [Rendimiento]: [Cómo se cumplen requisitos de rendimiento]
- [Otros]: [Cómo se cumplen otros requisitos]

Hoja de Ruta de Implementación:
- Fase 1 (Inmediato): [Elementos de respuesta urgente]
- Fase 2 (Corto plazo): [Implementación básica]
- Fase 3 (Mediano plazo): [Implementación completa]

Métricas de Éxito y Métodos de Medición:
- [Métricas de éxito integradas]
- [Métodos/frecuencia de medición]
- [Tiempo de revisión]
```

### Lista de Verificación de Calidad de Debate

#### Calidad de Evidencia

- [ ] Referencias a documentos/estándares oficiales
- [ ] Casos/datos específicos presentados
- [ ] Distinción entre especulación y hecho
- [ ] Fuentes explícitamente declaradas

#### Constructividad del Debate

- [ ] Comprensión precisa de propuestas del oponente
- [ ] Refutación lógica en lugar de emocional
- [ ] Alternativas también presentadas
- [ ] Exploración de posibilidades ganar-ganar

#### Factibilidad de Implementación

- [ ] Factibilidad técnica considerada
- [ ] Costos/duración de implementación estimados
- [ ] Posibilidad de implementación por fases considerada
- [ ] Medidas de mitigación de riesgos presentadas

#### Integración

- [ ] Impactos en otros campos considerados
- [ ] Búsqueda de optimización general
- [ ] Perspectiva a largo plazo incluida
- [ ] Métricas de éxito medibles establecidas

### Colaboración con Claude

```bash
# Debate basado en documentos de diseño
cat system-design.md
/role-debate architect,security
"Discutir problemas de seguridad en este diseño"

# Debate de soluciones basado en problemas
cat performance-issues.md
/role-debate performance,architect
"Discutir soluciones fundamentales a problemas de rendimiento"

# Debate de selección de tecnología basado en requisitos
/role-debate mobile,frontend
"Discutir estrategia de UI unificada para iOS, Android y Web"
```

### Notas

- Los debates pueden tomar tiempo (más largo para tópicos complejos)
- Con 3+ roles, las discusiones pueden divergir
- Las decisiones finales deben ser tomadas por usuarios referenciando resultados de debate
- Para problemas urgentes, considerar rol único o multi-role primero
