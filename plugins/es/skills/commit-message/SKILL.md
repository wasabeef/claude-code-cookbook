---
description: 'Generar mensajes de commit desde cambios preparados. Se activa con "generar mensaje de commit", "sugerir commit message".'
allowed-tools:
  - Bash(git diff *)
  - Bash(git log *)
  - Read
---

# Generar mensajes de commit desde cambios preparados

Genera mensajes de commit a partir de cambios staged (git diff --staged). Este comando solo crea mensajes y los copia al portapapeles—no ejecuta ningún comando git.

## Uso

```bash
/commit-message [opciones]
```

## Opciones

- `--format <formato>` : Elegir formato de mensaje (conventional, gitmoji, angular)
- `--lang <idioma>` : Establecer idioma explícitamente (en, es)
- `--breaking` : Incluir detección de cambios disruptivos

## Ejemplos Básicos

```bash
# Generar mensaje a partir de cambios staged (idioma auto-detectado)
# La sugerencia principal se copia automáticamente al portapapeles
/commit-message

# Especificar idioma explícitamente
/commit-message --lang es
/commit-message --lang en

# Incluir detección de cambios disruptivos
/commit-message --breaking
```

## Prerrequisitos

**Importante**: Este comando solo funciona con cambios staged. Ejecuta `git add` primero para staged tus cambios.

```bash
# Si no hay nada staged, verás:
$ /commit-message
No staged changes found. Please run git add first.
```

## Función Automática de Portapapeles

La sugerencia principal se copia al portapapeles como comando completo: `git commit -m "mensaje"`. Solo pégalo y ejecútalo en tu terminal.

**Notas de Implementación**:

- Ejecutar `pbcopy` en un proceso separado de la salida del mensaje
- Usar `printf` en lugar de `echo` para evitar saltos de línea no deseados

## Detección Automática de Convenciones del Proyecto

**Importante**: Si existen convenciones específicas del proyecto, tienen prioridad.

### 1. Verificación de Configuración CommitLint

Detecta automáticamente configuraciones de los siguientes archivos:

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `package.json` con sección `commitlint`

```bash
# Buscar archivos de configuración
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

### 2. Detección de Tipos Personalizados

Ejemplo de tipos específicos del proyecto:

```javascript
// commitlint.config.mjs
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // work in progress
        "hotfix", // urgent fix
        "release", // release
        "deps", // dependency update
        "config", // configuration change
      ],
    ],
  },
};
```

### 3. Detección de Configuración de Idioma

```javascript
// El proyecto usa mensajes en español
export default {
  rules: {
    "subject-case": [0], // Deshabilitar para soporte español
    "subject-max-length": [2, "always", 72], // Ajustar límite de caracteres para español
  },
};
```

### 4. Análisis de Historial de Commits Existentes

```bash
# Aprender patrones de uso de commits recientes
git log --oneline -50 --pretty=format:"%s"

# Estadísticas de tipos utilizados
git log --oneline -100 --pretty=format:"%s" | \
grep -oE '^[a-z]+(\([^)]+\))?' | \
sort | uniq -c | sort -nr
```

## Detección Automática de Idioma

Cambia automáticamente entre español/inglés/japonés basado en:

1. **Configuración CommitLint** configuraciones de idioma
2. **análisis git log** detección automática
3. **archivo del proyecto** configuraciones de idioma
4. **archivo cambiado** análisis de comentarios y cadenas

Por defecto es inglés. Genera en español si se detecta como proyecto en español.

## Formato de Mensaje

### Conventional Commits (Por defecto)

```text
<type>: <description>
```

**Importante**: Siempre genera mensajes de commit de una sola línea. No genera mensajes multilínea.

**Nota**: Las convenciones específicas del proyecto tienen prioridad si existen.

## Tipos Estándar

**Tipos Requeridos**:

- `feat`: Nueva característica (adición de característica visible al usuario)
- `fix`: Corrección de error

**Tipos Opcionales**:

- `build`: Cambios en sistema de build o dependencias externas
- `chore`: Otros cambios (sin impacto en release)
- `ci`: Cambios en archivos y scripts de configuración CI
- `docs`: Cambios solo en documentación
- `style`: Cambios que no afectan el significado del código (espacios, formato, punto y coma, etc.)
- `refactor`: Cambios de código sin correcciones de errores o adiciones de características
- `perf`: Mejoras de rendimiento
- `test`: Agregando o corrigiendo pruebas

## Ejemplo de Salida (Proyecto en Inglés)

```bash
$ /commit-message

📝 Sugerencias de Mensaje de Commit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidato Principal:
feat: implement JWT-based authentication system

📋 Alternativas:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

✅ `git commit -m "feat: implement JWT-based authentication system"` copiado al portapapeles
```

**Ejemplo de Implementación (Versión Corregida)**:

```bash
# Copiar comando de commit al portapapeles primero (sin salto de línea)
printf 'git commit -m "%s"' "$COMMIT_MESSAGE" | pbcopy

# Después mostrar mensaje
cat << EOF
📝 Sugerencias de Mensaje de Commit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidato Principal:
$COMMIT_MESSAGE

📋 Alternativas:
1. ...
2. ...
3. ...

✅ \`git commit -m "$COMMIT_MESSAGE"\` copiado al portapapeles
EOF
```

## Ejemplo de Salida (Proyecto en Español)

```bash
$ /commit-message

📝 Sugerencias de Mensaje de Commit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Candidato Principal:
feat: implementar sistema de autenticación JWT

📋 Alternativas:
1. feat: agregar autenticación de usuario con tokens JWT
2. fix: resolver error de validación de token en middleware auth
3. refactor: extraer lógica de auth a módulo separado

✅ `git commit -m "feat: implementar sistema de autenticación JWT"` copiado al portapapeles
```

## Resumen de Operación

1. **Análisis**: Analizar contenido de `git diff --staged`
2. **Generación**: Generar mensaje de commit apropiado
3. **Copiar**: Copiar automáticamente candidato principal al portapapeles

**Nota**: Este comando no ejecuta git add o git commit. Solo genera mensajes de commit y copia al portapapeles.

## Características Inteligentes

### 1. Clasificación Automática de Cambios (Solo Archivos Staged)

- Adición de archivo nuevo → `feat`
- Patrones de corrección de errores → `fix`
- Solo archivos de prueba → `test`
- Cambios en archivos de configuración → `chore`
- Actualizaciones README/docs → `docs`

### 2. Detección Automática de Convenciones del Proyecto

- Archivo `.gitmessage`
- Convenciones en `CONTRIBUTING.md`
- Patrones de historial de commits pasados

### 3. Detalles de Detección de Idioma (Solo Cambios Staged)

```bash
# Criterios de detección (orden de prioridad)
1. Detectar idioma del contenido git diff --staged
2. Análisis de comentarios de archivos staged
3. Análisis de idioma de git log --oneline -20
4. Configuraciones de idioma principal del proyecto
```

### 4. Detalles de Análisis de Staging

Información utilizada para análisis (solo lectura):

- `git diff --staged --name-only` - Lista de archivos cambiados
- `git diff --staged` - Contenido real de cambios
- `git status --porcelain` - Estado de archivos

## Detección de Cambios Disruptivos

Para cambios disruptivos de API:

**Inglés**:

```bash
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

O:

```bash
feat(api)!: change authentication flow
```

**Español**:

```bash
feat!: cambiar formato de respuesta de API de usuario

BREAKING CHANGE: la respuesta del usuario ahora incluye metadatos adicionales
```

O:

```bash
feat(api)!: cambiar flujo de autenticación
```

## Mejores Prácticas

1. **Coincidir con proyecto**: Seguir idioma de commits existentes
2. **Concisión**: Claro dentro de 50 caracteres
3. **Consistencia**: No mezclar idiomas (mantener consistencia en español)
4. **OSS**: Inglés recomendado para código abierto
5. **Una línea**: Siempre mensaje de commit de una línea (complementar con PR para explicaciones detalladas)

## Patrones Comunes

**Inglés**:

```text
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

**Español**:

```text
feat: agregar endpoint de registro de usuario
fix: resolver fuga de memoria en gestor de caché
docs: actualizar documentación de API
```

## Integración con Claude

```bash
# Usar con cambios staged
git add -p  # Staging interactivo
/commit-message
"Generar mensaje de commit óptimo"

# Staged y analizar archivos específicos
git add src/auth/*.js
/commit-message --lang es
"Generar mensaje para cambios de autenticación"

# Detección y manejo de cambios disruptivos
git add -A
/commit-message --breaking
"Marcar apropiadamente si hay cambios disruptivos"
```

## Notas Importantes

- **Prerrequisito**: Los cambios deben estar staged con `git add` de antemano
- **Limitación**: Los cambios no staged no se analizan
- **Recomendación**: Verificar primero las convenciones de commit del proyecto existente
