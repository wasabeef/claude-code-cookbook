## Multi Role

Un comando que analiza el mismo objetivo en paralelo con múltiples roles y genera un reporte integrado.

### Uso

```bash
/multi-role <rol1>,<rol2> [--agent|-a] [objetivo_análisis]
/multi-role <rol1>,<rol2>,<rol3> [--agent|-a] [objetivo_análisis]
```

**Importante**:

- Coloca la opción `--agent` inmediatamente después de especificar los roles
- Escribe tu mensaje después de `--agent`
- Ejemplo correcto: `/multi-role qa,architect --agent Evaluar el plan`
- Ejemplo incorrecto: `/multi-role qa,architect Evaluar el plan --agent`

### Opciones

- `--agent` o `-a`: Ejecutar cada rol como sub-agente en paralelo (recomendado para análisis a gran escala)
  - Al usar esta opción, si las descripciones de roles incluyen frases de delegación proactiva (como "usar PROACTIVAMENTE"), se habilita una delegación automática más agresiva

### Ejemplos Básicos

```bash
# Análisis dual de seguridad y rendimiento (normal)
/multi-role security,performance
"Evaluar este endpoint de API"

# Análisis paralelo de sistema a gran escala (sub-agentes)
/multi-role security,performance --agent
"Analizar comprensivamente seguridad y rendimiento del sistema"

# Análisis integrado de frontend, mobile y rendimiento
/multi-role frontend,mobile,performance
"Considerar propuestas de optimización para esta pantalla"

# Evaluación multifacética de diseño de arquitectura (sub-agentes)
/multi-role architect,security,performance --agent
"Evaluar diseño de microservicios"
```

### Proceso de Análisis

### Fase 1: Análisis Paralelo

Cada rol analiza independientemente el mismo objetivo

- Realizar evaluación desde perspectiva especializada
- Hacer juicios basados en criterios específicos del rol
- Generar recomendaciones independientes

### Fase 2: Análisis Integrado

Estructurar e integrar resultados

- Organizar resultados de evaluación de cada rol
- Identificar solapamientos y contradicciones
- Aclarar relaciones complementarias

### Fase 3: Reporte Integrado

Generar recomendaciones finales

- Plan de acción priorizado
- Trade-offs explícitos
- Hoja de ruta de implementación

### Ejemplos de Formato de Salida

### Para Análisis de 2 Roles

```text
Análisis Multi-role: Security + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Objetivo de Análisis: Endpoint API /api/users

Resultados de Análisis de Seguridad:
Autenticación: Verificación JWT implementada correctamente
Autorización: Control de acceso basado en roles incompleto
Cifrado: Claves API registradas en texto plano

Puntuación de Evaluación: 65/100
Importancia: Alta (debido al acceso a datos sensibles)

Resultados de Análisis de Rendimiento:
Tiempo de Respuesta: Promedio 180ms (dentro del objetivo de 200ms)
Consultas de Base de Datos: Problema N+1 detectado
Caché: Caché Redis no implementado

Puntuación de Evaluación: 70/100
Importancia: Media (actualmente dentro del rango aceptable)

Análisis Interrelacionado:
Oportunidades Sinérgicas:
- Considerar cifrado al implementar caché Redis
- Mejorar logging para ganancias tanto de seguridad como rendimiento

Puntos de Trade-off:
- Fortalecimiento de verificación de autorización ↔ Impacto en tiempo de respuesta
- Cifrado de logs ↔ Eficiencia de debugging reducida

Prioridades Integradas:
Crítico: Arreglar salida de clave API en texto plano
Alto: Resolver consultas N+1
Medio: Implementar caché Redis + cifrado
Bajo: Refinar control de autorización

Hoja de Ruta de Implementación:
Semana 1: Implementar enmascarado de clave API
Semana 2: Optimización de consultas de base de datos
Semanas 3-4: Diseño e implementación de capa de caché
Mes 2: Fortalecimiento progresivo del control de autorización
```

### Para Análisis de 3 Roles

```text
Análisis Multi-role: Frontend + Mobile + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Objetivo de Análisis: Pantalla de Perfil de Usuario

Resultados de Análisis Frontend:
Usabilidad: Layout intuitivo
Accesibilidad: 85% de cumplimiento WCAG 2.1
Responsive: Problemas con visualización en tablet

Resultados de Análisis Mobile:
Touch Targets: 44pt+ asegurado
Operación con Una Mano: Botones importantes colocados en la parte superior
Soporte Offline: No implementado

Resultados de Análisis de Rendimiento:
Visualización Inicial: LCP 2.1s (bueno)
Optimización de Imágenes: WebP no soportado
Lazy Loading: No implementado

Recomendaciones Integradas:
1. Optimización móvil (operación con una mano + soporte offline)
2. Optimización de imágenes (WebP + lazy loading)
3. Mejoras de UI para tablet

Prioridad: Mobile > Performance > Frontend
Período de Implementación: 3-4 semanas
```

### Patrones de Combinación Efectivos

### Enfocado en Seguridad

```bash
/multi-role security,architect
"Diseño de sistema de autenticación"

/multi-role security,frontend
"Seguridad de pantalla de login"

/multi-role security,mobile
"Protección de datos de app móvil"
```

### Enfocado en Rendimiento

```bash
/multi-role performance,architect
"Diseño de escalabilidad"

/multi-role performance,frontend
"Optimización de velocidad de página web"

/multi-role performance,mobile
"Optimización de rendimiento de app"
```

### Enfocado en Experiencia de Usuario

```bash
/multi-role frontend,mobile
"UI cross-platform"

/multi-role frontend,performance
"Balance entre UX y rendimiento"

/multi-role mobile,performance
"Optimización de UX móvil"
```

### Análisis Comprensivo

```bash
/multi-role architect,security,performance
"Evaluación general del sistema"

/multi-role frontend,mobile,performance
"Evaluación comprensiva de experiencia de usuario"

/multi-role security,performance,mobile
"Diagnóstico comprensivo de app móvil"
```

### Colaboración con Claude

```bash
# Combinar con análisis de archivo
cat src/components/UserProfile.tsx
/multi-role frontend,mobile
"Evaluar este componente desde múltiples perspectivas"

# Evaluar documentos de diseño
cat architecture-design.md
/multi-role architect,security,performance
"Evaluar este diseño a través de múltiples especialidades"

# Análisis de errores
cat performance-issues.log
/multi-role performance,analyzer
"Analizar problemas de rendimiento desde múltiples ángulos"
```

### Eligiendo entre multi-role y role-debate

### Cuándo usar multi-role

- Quieres evaluaciones independientes de cada especialidad
- Quieres crear un plan de mejora integrado
- Quieres organizar contradicciones y solapamientos
- Quieres determinar prioridades de implementación

### Cuándo usar role-debate

- Hay trade-offs entre especialidades
- Las opiniones podrían diferir en la selección de tecnología
- Quieres decidir políticas de diseño a través de discusión
- Quieres escuchar debates desde diferentes perspectivas

### Ejecución Paralela de Sub-agentes (--agent)

Usar la opción `--agent` ejecuta cada rol como un sub-agente independiente en paralelo.

#### Promoviendo Delegación Automática

Si las descripciones de archivos de rol incluyen frases como estas, se habilita una delegación automática más proactiva al usar `--agent`:

- "usar PROACTIVAMENTE"
- "DEBE SER USADO"
- Otras expresiones de énfasis

#### Flujo de Ejecución

```text
Ejecución normal:
Rol 1 → Rol 2 → Rol 3 → Integración
(Ejecución secuencial, aprox. 3-5 minutos)

Ejecución --agent:
Rol 1 ─┐
Rol 2 ─┼→ Integración
Rol 3 ─┘
(Ejecución paralela, aprox. 1-2 minutos)
```

#### Ejemplos de Uso Efectivo

```bash
# Evaluación comprensiva de sistema a gran escala
/multi-role architect,security,performance,qa --agent
"Evaluación comprensiva de nuevo sistema"

# Análisis detallado desde múltiples perspectivas
/multi-role frontend,mobile,performance --agent
"Análisis completo de optimización UX de pantalla"
```

#### Comparación de Rendimiento

| Número de Roles | Ejecución Normal | Ejecución --agent | Tasa de Reducción |
| --------------- | ---------------- | ----------------- | ----------------- |
| 2 roles         | 2-3 minutos      | 1 minuto          | 50%               |
| 3 roles         | 3-5 minutos      | 1-2 minutos       | 60%               |
| 4 roles         | 5-8 minutos      | 2-3 minutos       | 65%               |

### Notas

- Ejecutar 3 o más roles simultáneamente resulta en salida más larga
- Los análisis complejos pueden tomar más tiempo para ejecutarse
- Si surgen recomendaciones conflictivas, considera usar role-debate
- Los juicios finales deben ser hechos por el usuario con referencia a resultados integrados
- **Al usar --agent**: Consume más recursos pero es eficiente para análisis a gran escala
