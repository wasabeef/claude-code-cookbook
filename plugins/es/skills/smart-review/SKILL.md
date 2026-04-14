---
description: "Auto-sugerir rol y enfoque óptimo"
---

## Revisión Inteligente

Un comando que analiza la situación actual y sugiere automáticamente el rol óptimo y el enfoque.

### Uso

```bash
/smart-review                    # Analizar directorio actual
/smart-review <archivo/directorio>   # Analizar objetivo específico
```

### Lógica de Análisis Automático

### Análisis por Extensión de Archivo

- `package.json`, `*.tsx`, `*.jsx`, `*.css`, `*.scss` → **frontend**
- `Dockerfile`, `docker-compose.yml`, `*.yaml` → **architect**
- `*.test.js`, `*.spec.ts`, `test/`, `__tests__/` → **qa**
- `*.rs`, `Cargo.toml`, `performance/` → **performance**

### Detección de Archivos Relacionados con Seguridad

- `auth.js`, `security.yml`, `.env`, `config/auth/` → **security**
- `login.tsx`, `signup.js`, `jwt.js` → **security + frontend**
- `api/auth/`, `middleware/auth/` → **security + architect**

### Patrones de Análisis Complejos

- `mobile/` + `*.swift`, `*.kt`, `react-native/` → **mobile**
- `webpack.config.js`, `vite.config.js`, `large-dataset/` → **performance**
- `components/` + `responsive.css` → **frontend + mobile**
- `api/` + `auth/` → **security + architect**

### Análisis de Errores/Problemas

- Stack traces, `error.log`, `crash.log` → **analyzer**
- `memory leak`, `high CPU`, `slow query` → **performance + analyzer**
- `SQL injection`, `XSS`, `CSRF` → **security + analyzer**

### Patrones de Sugerencia

### Sugerencia de Rol Único

```bash
$ /smart-review src/auth/login.js
→ "Archivo de autenticación detectado"
→ "Análisis con rol de seguridad recomendado"
→ "¿Ejecutar? [s]í / [n]o / [m]ás opciones"
```

### Sugerencia de Múltiples Roles

```bash
$ /smart-review src/mobile/components/
→ "📱🎨 Elementos Mobile + Frontend detectados"
→ "Enfoques recomendados:"
→ "[1] rol mobile solo"
→ "[2] rol frontend solo"
→ "[3] multi-role mobile,frontend"
→ "[4] role-debate mobile,frontend"
```

### Sugerencias para Análisis de Problemas

```bash
$ /smart-review error.log
→ "⚠️ Log de errores detectado"
→ "Iniciando análisis de causa raíz con rol analyzer"
→ "[Auto-ejecutar] /role analyzer"

$ /smart-review slow-api.log
→ "🐌 Problema de rendimiento detectado"
→ "Recomendado: [1]/role performance [2]/role-debate performance,analyzer"
```

### Sugerencias para Decisiones de Diseño Complejas

```bash
$ /smart-review architecture-design.md
→ "🏗️🔒⚡ Elementos Architecture + Security + Performance detectados"
→ "Para decisiones de diseño complejas, se recomienda formato de debate"
→ "[Recomendado] /role-debate architect,security,performance"
→ "[Alternativo] /multi-role architect,security,performance"
```

### Detalles de Lógica de Sugerencia

### Evaluación de Prioridad

1. **Seguridad** - Autenticación, autorización y encriptación son prioridades principales
2. **Errores Críticos** - Interrupciones del sistema y pérdida de datos son urgentes
3. **Arquitectura** - Cambios a gran escala y selección de tecnología requieren consideración cuidadosa
4. **Rendimiento** - Impacta directamente la experiencia del usuario
5. **Frontend/Mobile** - Mejoras de UI/UX
6. **QA** - Aseguramiento de calidad y testing

### Condiciones para Recomendar Debate

- Cuando 3 o más roles están involucrados
- Cuando hay un trade-off entre seguridad y rendimiento
- Cuando cambios arquitectónicos significativos están involucrados
- Cuando tanto móvil como web son afectados

### Ejemplos Básicos

```bash
# Analizar directorio actual
/smart-review
"Sugerir el rol óptimo y enfoque"

# Analizar archivo específico
/smart-review src/auth/login.js
"Sugerir el mejor método de revisión para este archivo"

# Analizar log de errores
/smart-review error.log
"Sugerir el mejor enfoque para resolver este error"
```

### Ejemplos Prácticos

### Análisis de Proyecto Completo

```bash
$ /smart-review
→ "📊 Analizando proyecto..."
→ "Proyecto React + TypeScript detectado"
→ "Funcionalidad de autenticación + API + soporte móvil confirmado"
→ ""
→ "💡 Flujo de trabajo recomendado:"
→ "1. Verificar autenticación con security"
→ "2. Evaluar UI/UX con frontend"
→ "3. Confirmar optimización móvil con mobile"
→ "4. Revisar diseño general con architect"
→ ""
→ "¿Auto-ejecutar? [s]í / [s]eleccionar rol / [p]ersonalizado"
```

### Análisis de Problema Específico

```bash
$ /smart-review "Cómo establecer tiempo de expiración JWT"
→ "🤔 Decisión de diseño técnico detectada"
→ "Este problema requiere múltiples perspectivas de expertos"
→ ""
→ "Enfoque recomendado:"
→ "/role-debate security,performance,frontend"
→ "Razón: Balance entre seguridad, rendimiento y UX es importante"
```

### Colaboración con Claude

```bash
# Análisis combinado con contenido de archivo
cat src/auth/middleware.js
/smart-review
"Analizar este archivo desde una perspectiva de seguridad"

# Análisis combinado con errores
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
"Sugerir formas de resolver errores de build"

# Consulta de diseño
/smart-review
"Discutir si elegir React Native o Progressive Web App"
```

### Notas

- Las sugerencias son solo de referencia. La decisión final depende del usuario
- El formato de debate (role-debate) se recomienda para problemas complejos
- Un rol único a menudo es suficiente para problemas simples
- Los asuntos relacionados con seguridad siempre deben confirmarse con un rol especializado
