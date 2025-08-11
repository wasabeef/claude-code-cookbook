## Ayuda de Roles

Una guía de selección y sistema de ayuda cuando no estás seguro de qué rol usar.

### Uso

```bash
/role-help                      # Guía general de selección de roles
/role-help <situación/problema>  # Roles recomendados para situaciones específicas
/role-help compare <Rol 1>,<Rol 2> # Comparar roles
```

### Ejemplos Básicos

```bash
# Orientación general
/role-help
→ Lista de roles disponibles y sus características

# Recomendación específica de situación
/role-help "Preocupado por la seguridad de API"
→ Recomendación y uso del rol security

# Comparación de roles
/role-help compare frontend,mobile
→ Diferencias y uso apropiado entre roles frontend y mobile
```

### Guía de Selección de Roles Basada en Situaciones

### 🔒 Relacionado con Seguridad

```
Usar rol security para:
✅ Implementación de funciones de login/autenticación
✅ Verificaciones de vulnerabilidades de seguridad para APIs
✅ Cifrado de datos y protección de privacidad
✅ Verificación de cumplimiento de seguridad
✅ Pruebas de penetración

Uso: /role security
```

### 🏗️ Arquitectura y Diseño

```
Usar rol architect para:
✅ Evaluación de diseño general del sistema
✅ Decisiones microservicios vs monolito
✅ Diseño de base de datos y selección de tecnología
✅ Consideraciones de escalabilidad y extensibilidad
✅ Evaluación de deuda técnica y planificación de mejoras

Uso: /role architect
```

### ⚡ Problemas de Rendimiento

```
Usar rol performance para:
✅ Aplicaciones lentas
✅ Optimización de consultas de base de datos
✅ Mejora de velocidad de carga de páginas web
✅ Optimización de uso de memoria y CPU
✅ Escalado y contramedidas de carga

Uso: /role performance
```

### 🔍 Investigación de Causa Raíz de Problemas

```
Usar rol analyzer para:
✅ Análisis de causa raíz de bugs y errores
✅ Investigación de fallas del sistema
✅ Análisis estructural de problemas complejos
✅ Análisis de datos e investigación estadística
✅ Entender por qué ocurren problemas

Uso: /role analyzer
```

### 🎨 Frontend y UI/UX

```
Usar rol frontend para:
✅ Mejoras de interfaz de usuario
✅ Cumplimiento de accesibilidad
✅ Diseño responsivo
✅ Mejora de usabilidad y facilidad de uso
✅ Tecnologías generales de frontend web

Uso: /role frontend
```

### 📱 Desarrollo de Aplicaciones Móviles

```
Usar rol mobile para:
✅ Optimización de aplicaciones iOS y Android
✅ Diseño UX específico para móviles
✅ Optimización de interfaz táctil
✅ Funciones de soporte offline y sincronización
✅ Cumplimiento de App Store y Google Play

Uso: /role mobile
```

### 👀 Revisión de Código y Calidad

```
Usar rol reviewer para:
✅ Verificaciones de calidad de código
✅ Evaluación de legibilidad y mantenibilidad
✅ Verificación de convenciones de codificación
✅ Propuestas de refactoring
✅ Revisiones de PR y commits

Uso: /role reviewer
```

### 🧪 Pruebas y Aseguramiento de Calidad

```
Usar rol qa para:
✅ Planificación de estrategia de pruebas
✅ Evaluación de cobertura de pruebas
✅ Directrices de implementación de pruebas automatizadas
✅ Medidas de prevención de bugs y mejora de calidad
✅ Automatización de pruebas en CI/CD

Uso: /role qa
```

### Cuando se Necesitan Múltiples Roles

### 🔄 multi-role (Análisis Paralelo)

```
Usar multi-role para:
✅ Evaluación desde múltiples perspectivas profesionales
✅ Crear planes de mejora integrados
✅ Comparar evaluaciones de diferentes campos
✅ Organizar contradicciones y superposiciones

Ejemplo: /multi-role security,performance
```

### 🗣️ role-debate (Discusión)

```
Usar role-debate para:
✅ Trade-offs entre campos especializados
✅ Opiniones divididas sobre selección de tecnología
✅ Tomar decisiones de diseño a través de discusión
✅ Escuchar debates desde diferentes perspectivas

Ejemplo: /role-debate security,performance
```

### 🤖 smart-review (Propuesta Automática)

```
Usar smart-review para:
✅ Incertidumbre sobre qué rol usar
✅ Querer conocer el enfoque óptimo para la situación actual
✅ Elegir entre múltiples opciones
✅ Indecisión de principiante

Ejemplo: /smart-review
```

### Tabla de Comparación de Roles

### Categoría Seguridad

| Rol | Uso Principal | Fortalezas | Debilidades |
|------|----------|----------|----------|
| security | Vulnerabilidades y contramedidas de ataque | Análisis de amenazas, diseño de autenticación | UX, rendimiento |
| analyzer | Análisis de causa raíz | Análisis lógico, recolección de evidencia | Medidas preventivas, planificación futura |

### Categoría Diseño

| Rol | Uso Principal | Fortalezas | Debilidades |
|------|----------|----------|----------|
| architect | Diseño de sistema | Perspectiva a largo plazo, optimización general | Implementación detallada, soluciones a corto plazo |
| reviewer | Calidad de código | Nivel de implementación, mantenibilidad | Requerimientos de negocio, UX |

### Categoría Rendimiento

| Rol | Uso Principal | Fortalezas | Debilidades |
|------|----------|----------|----------|
| performance | Mejora de velocidad y optimización | Medición, identificación de cuellos de botella | Seguridad, UX |
| qa | Aseguramiento de calidad | Pruebas, automatización | Diseño, arquitectura |

### Categoría Experiencia de Usuario

| Rol | Uso Principal | Fortalezas | Debilidades |
|------|----------|----------|----------|
| frontend | UI/UX Web | Navegador, accesibilidad | Lado servidor, BD |
| mobile | UX Móvil | Táctil, soporte offline | Lado servidor, Web |

### Diagrama de Flujo de Decisión Cuando No Estés Seguro

```
¿Cuál es la naturaleza del problema?
├─ Relacionado con seguridad → security
├─ Problemas de rendimiento → performance
├─ Investigación de bug/falla → analyzer
├─ Mejora de UI/UX → frontend o mobile
├─ Diseño/arquitectura → architect
├─ Calidad de código → reviewer
├─ Relacionado con pruebas → qa
└─ Complejo/compuesto → smart-review para propuesta

¿Abarca múltiples campos?
├─ Quiero análisis integrado → multi-role
├─ Discusión/trade-offs → role-debate
└─ No estoy seguro → smart-review
```

### Preguntas Frecuentes

### P: ¿Cuál es la diferencia entre los roles frontend y mobile?

```
R:
frontend: Enfocado en navegador web, HTML/CSS/JavaScript
mobile: Enfocado en aplicaciones móviles, iOS/Android nativo, React Native, etc.

Para problemas relacionados con ambos, se recomienda multi-role frontend,mobile
```

### P: ¿Cómo elegir entre los roles security y analyzer?

```
R:
security: Prevención de ataques y amenazas, diseño de seguridad
analyzer: Análisis de causas de problemas existentes, investigación

Para investigaciones de incidentes de seguridad, usar multi-role security,analyzer
```

### P: ¿Cuál es la diferencia entre los roles architect y performance?

```
R:
architect: Diseño a largo plazo de sistemas completos, escalabilidad
performance: Mejoras específicas de velocidad y eficiencia

Para diseño de rendimiento de sistemas a gran escala, usar multi-role architect,performance
```

### Colaboración con Claude

```bash
# Combinado con descripción de situación
/role-help
"La aplicación React carga páginas lentamente, recibiendo quejas de usuarios"

# Combinado con contenido de archivo
cat problem-description.md
/role-help
"Recomendar el rol más adecuado para este problema"

# Cuando no estés seguro entre opciones específicas
/role-help compare security,performance
"¿Qué rol es apropiado para problemas de expiración de token JWT?"
```

### Notas

- Para problemas complejos, combinar múltiples roles es más efectivo
- Para asuntos urgentes, usar un solo rol para respuesta rápida
- Cuando no estés seguro, se recomienda usar smart-review para propuestas automáticas
- La decisión final debe ser tomada por el usuario considerando la naturaleza del problema
