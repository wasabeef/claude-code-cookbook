## Revisión de PR

Asegura la calidad del código y solidez arquitectónica a través de revisiones sistemáticas de Pull Request.

### Uso

```bash
# Revisión comprensiva de PR
gh pr view 123 --comments
"Revisar sistemáticamente este PR y proporcionar feedback desde perspectivas de calidad de código, seguridad y arquitectura"

# Revisión enfocada en seguridad
gh pr diff 123
"Enfocarse en revisar riesgos de seguridad y vulnerabilidades"

# Revisión desde perspectiva de arquitectura
gh pr checkout 123 && find . -name "*.js" | head -10
"Evaluar la arquitectura desde perspectivas de separación de capas, dependencias y principios SOLID"
```

### Ejemplos Básicos

```bash
# Evaluación cuantitativa de calidad de código
find . -name "*.js" -exec wc -l {} + | sort -rn | head -5
"Evaluar complejidad de código, tamaño de funciones y duplicación, y señalar mejoras"

# Verificación de vulnerabilidades de seguridad
grep -r "password\|secret\|token" . --include="*.js" | head -10
"Verificar riesgos de filtración de información sensible, hardcoding y bypass de autenticación"

# Detección de violaciones de arquitectura
grep -r "import.*from.*\.\./\.\." . --include="*.js"
"Evaluar violaciones de capas, dependencias circulares y problemas de acoplamiento"
```

### Sistema de Clasificación de Comentarios

```
🔴 critical.must: Problemas críticos
├─ Vulnerabilidades de seguridad
├─ Problemas de integridad de datos
└─ Riesgos de falla del sistema

🟡 high.imo: Mejoras de alta prioridad
├─ Riesgo de mal funcionamiento
├─ Problemas de rendimiento
└─ Disminución significativa de mantenibilidad

🟢 medium.imo: Mejoras de prioridad media
├─ Mejora de legibilidad
├─ Mejora de estructura de código
└─ Mejora de calidad de pruebas

🟢 low.nits: Puntos menores
├─ Unificación de estilo
├─ Corrección de errores tipográficos
└─ Adición de comentarios

🔵 info.q: Preguntas/información
├─ Confirmación de intención de implementación
├─ Antecedentes de decisiones de diseño
└─ Compartir mejores prácticas
```

### Perspectivas de Revisión

#### 1. Corrección de Código

- **Errores lógicos**: Valores límite, verificaciones de null, manejo de excepciones
- **Integridad de datos**: Seguridad de tipos, validación
- **Manejo de errores**: Completitud, procesamiento apropiado

#### 2. Seguridad

- **Autenticación/autorización**: Verificaciones apropiadas, gestión de permisos
- **Validación de entrada**: Contramedidas SQL injection, XSS
- **Información sensible**: Restricciones de logging, cifrado

#### 3. Rendimiento

- **Algoritmos**: Complejidad temporal, eficiencia de memoria
- **Base de datos**: Consultas N+1, optimización de índices
- **Recursos**: Fugas de memoria, utilización de caché

#### 4. Arquitectura

- **Separación de capas**: Dirección de dependencias, separación apropiada
- **Acoplamiento**: Acoplamiento fuerte, utilización de interfaces
- **Principios SOLID**: Responsabilidad única, abierto-cerrado, inversión de dependencias

### Flujo de Revisión

1. **Pre-verificación**: Información de PR, diff de cambios, issues relacionados
2. **Verificaciones sistemáticas**: Seguridad → Corrección → Rendimiento → Arquitectura
3. **Feedback constructivo**: Sugerencias específicas de mejora y ejemplos de código
4. **Seguimiento**: Confirmación de correcciones, estado de CI, aprobación final

### Ejemplos de Comentarios Efectivos

**Problemas de Seguridad**

```markdown
**critical.must.** La contraseña se almacena en texto plano

```javascript
// Corrección propuesta
const bcrypt = require('bcrypt');
const hashedPassword = await bcrypt.hash(password, 12);
```

Se requiere hashing para prevenir riesgos de seguridad.

```

**Mejora de Rendimiento**
```markdown
**high.imo.** Ocurre problema de consulta N+1

```javascript
// Mejora: Eager Loading
const users = await User.findAll({ include: [Post] });
```

Esto puede reducir significativamente el número de consultas.

```

**Violación de Arquitectura**
```markdown
**high.must.** Ocurrió violación de capa

La capa de dominio depende directamente de la capa de infraestructura.
Por favor introducir una interfaz siguiendo el principio de inversión de dependencias.
```

### Notas

- **Tono constructivo**: Comunicación colaborativa en lugar de agresiva
- **Sugerencias específicas**: Proporcionar soluciones junto con señalar problemas
- **Priorización**: Abordar en orden de Crítico → Alto → Medio → Bajo
- **Mejora continua**: Documentar resultados de revisión en base de conocimiento
