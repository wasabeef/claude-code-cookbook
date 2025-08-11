## Feedback de PR

Manejar eficientemente comentarios de revisión de Pull Request y lograr resolución de causa raíz usando un enfoque de análisis de errores de 3 etapas.

### Uso

```bash
# Recuperar y analizar comentarios de revisión
gh pr view --comments
"Clasificar comentarios de revisión por prioridad y crear un plan de acción"

# Análisis detallado de comentarios relacionados con errores
gh pr checks
"Analizar errores de CI usando un enfoque de 3 etapas para identificar causas raíz"

# Confirmación de calidad después de correcciones
npm test && npm run lint
"Las correcciones están completas - por favor verificar pruebas de regresión y calidad de código"
```

### Ejemplos Básicos

```bash
# Clasificar comentarios
gh pr view 123 --comments | head -20
"Clasificar comentarios de revisión en categorías must/imo/nits/q y determinar orden de respuesta"

# Recopilar información de errores
npm run build 2>&1 | tee error.log
"Identificar la causa raíz de errores de build y sugerir correcciones apropiadas"

# Verificar implementación de corrección
git diff HEAD~1
"Evaluar si esta corrección aborda apropiadamente los comentarios de revisión"
```

### Sistema de Clasificación de Comentarios

```
🔴 must: Correcciones requeridas
├─ Problemas de seguridad
├─ Bugs funcionales
├─ Violaciones de principios de diseño
└─ Violaciones de convenciones

🟡 imo: Sugerencias de mejora
├─ Mejores métodos de implementación
├─ Mejoras de rendimiento
├─ Mejoras de legibilidad
└─ Propuestas de refactoring

🟢 nits: Puntos menores
├─ Correcciones de typos
├─ Ajustes de indentación
├─ Adiciones de comentarios
└─ Refinamientos de nomenclatura

🔵 q: Preguntas/confirmaciones
├─ Verificación de intención de implementación
├─ Aclaración de especificaciones
├─ Trasfondo de decisiones de diseño
└─ Consideración de soluciones alternativas
```

### Enfoque de Análisis de Errores de 3 Etapas

#### Etapa 1: Recopilación de Información

**Acciones requeridas**

- Captura completa de mensaje de error
- Revisión de stack trace
- Identificación de condiciones de reproducción

**Acciones recomendadas**

- Recopilación de información de entorno
- Historial de cambios recientes
- Revisión de logs relacionados

#### Etapa 2: Análisis de Causa Raíz

- Aplicación de análisis de 5 Por qués
- Seguimiento de dependencias
- Verificación de diferencias de entorno
- Creación de código mínimo de reproducción

#### Etapa 3: Implementación de Solución

- Respuesta inmediata (hotfix)
- Resolución de causa raíz (corrección esencial)
- Medidas preventivas (prevención de recurrencia)

### Flujo de Respuesta

1. **Análisis de comentarios**: Clasificación por prioridad
2. **Plan de corrección**: Determinación de orden de respuesta
3. **Correcciones por fases**: Crítico → Alto → Medio → Bajo
4. **Confirmación de calidad**: Testing, linting, building
5. **Reporte de progreso**: Descripción de correcciones específicas

### Verificación Post-Corrección

```bash
# Verificaciones básicas
npm test
npm run lint
npm run build

# Pruebas de regresión
npm run test:e2e

# Calidad de código
npm run test:coverage
```

### Plantillas de Respuesta

**Reporte de finalización de corrección**

```markdown
@reviewer Gracias por tu feedback.
Las correcciones están completas:

- [Detalles específicos de corrección]
- [Resultados de pruebas]
- [Método de verificación]
```

**Explicación de decisión técnica**

```markdown
Trasfondo de implementación: [Razón]
Alternativas consideradas: [Opciones y justificación de decisión]
Beneficios de solución adoptada: [Ventajas]
```

### Notas

- **Adherencia a prioridades**: Abordar en orden de Crítico → Alto → Medio → Bajo
- **Pruebas primero**: Confirmar pruebas de regresión antes de hacer correcciones
- **Reporte claro**: Describir detalles de corrección y métodos de verificación específicamente
- **Diálogo constructivo**: Comunicación cortés basada en fundamentos técnicos
