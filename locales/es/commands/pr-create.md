## Crear PR

Crea Pull Requests automáticamente analizando tus cambios Git para un flujo de trabajo más fluido.

### Uso

```bash
# Auto-crear PR desde tus cambios
git add . && git commit -m "feat: Implementar autenticación de usuario"
"Crear un Draft PR con la descripción y etiquetas correctas"

# Mantener tu plantilla existente
cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
"Llenar los espacios en blanco pero mantener la estructura de plantilla intacta"

# Marcar como listo cuando termine
gh pr ready
"Cambiar a Ready for Review después de verificar calidad"
```

### Ejemplos Básicos

```bash
# 1. Crear rama y commit
git checkout main && git pull
git checkout -b feat-user-profile
git add . && git commit -m "feat: Implementar característica de perfil de usuario"
git push -u origin feat-user-profile

# 2. Crear PR
"Por favor crear un PR:
1. Verificar qué cambió con git diff --cached
2. Usar la plantilla PR de .github/PULL_REQUEST_TEMPLATE.md
3. Elegir hasta 3 etiquetas que coincidan con los cambios
4. Crearlo como Draft (mantener comentarios HTML)"

# 3. Hacer listo después de que CI pase
"Una vez que CI esté verde, marcar el PR como Ready for Review"
```

### Pasos de Ejecución

#### 1. Crear Rama

```bash
# Nomenclatura de rama: {tipo}-{asunto}
git checkout main
git pull
git checkout -b feat-user-authentication

# Confirmar que estás en la rama correcta
git branch --show-current
```

#### 2. Commit

```bash
# Staged tus cambios
git add .

# Commit con mensaje claro
git commit -m "feat: Implementar API de autenticación de usuario"
```

#### 3. Push al Remoto

```bash
# Primer push (establece upstream)
git push -u origin feat-user-authentication

# Pushes posteriores
git push
```

#### 4. Crear Draft PR con Análisis Automático

**Paso 1: Analizar Cambios**

```bash
# Ver qué archivos cambiaron
git diff --cached --name-only

# Revisar los cambios reales (primeras 1000 líneas)
git diff --cached | head -1000
```

**Paso 2: Auto-generar Descripción**

```bash
# Prioridad de plantilla:
# 1. Mantener descripción PR existente como está
# 2. Usar .github/PULL_REQUEST_TEMPLATE.md
# 3. Recurrir a plantilla por defecto

cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
# Llenar solo secciones vacías - no tocar comentarios HTML o separadores
```

**Paso 3: Auto-seleccionar Etiquetas**

```bash
# Obtener etiquetas disponibles (no interactivo)
"Recuperar etiquetas disponibles de .github/labels.yml o repositorio GitHub y seleccionar automáticamente etiquetas apropiadas basadas en cambios"

# Auto-selección por coincidencia de patrones (máx 3)
# - Documentación: *.md, docs/ → documentation|docs
# - Pruebas: test, spec → test|testing
# - Correcciones de errores: fix|bug → bug|fix
# - Nuevas características: feat|feature → feature|enhancement
```

**Paso 4: Crear PR vía GitHub API (Preservar Comentarios HTML)**

```bash
# Crear PR
"Crear un Draft PR con la siguiente información:
- Título: Auto-generado desde mensaje de commit
- Descripción: Correctamente llenado usando .github/PULL_REQUEST_TEMPLATE.md
- Etiquetas: Auto-seleccionadas desde cambios (máx 3)
- Rama base: main
- Preservar todos los comentarios HTML"
```

### Sistema de Selección Automática de Etiquetas

#### Determinar desde Patrones de Archivos

- **Documentación**: `*.md`, `README`, `docs/` → `documentation|docs|doc`
- **Pruebas**: `test`, `spec` → `test|testing`
- **CI/CD**: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`
- **Dependencias**: `package.json`, `pubspec.yaml` → `dependencies|deps`

#### Determinar desde Contenido

- **Correcciones de errores**: `fix|bug|error|crash|repair` → `bug|fix`
- **Nuevas características**: `feat|feature|add|implement|new-feature|implementation` → `feature|enhancement|feat`
- **Refactoring**: `refactor|clean|restructure` → `refactor|cleanup|clean`
- **Rendimiento**: `performance|perf|optimize` → `performance|perf`
- **Seguridad**: `security|secure` → `security`

#### Restricciones

- **Máx 3 etiquetas**: Límite superior para selección automática
- **Solo etiquetas existentes**: Prohibido crear nuevas etiquetas
- **Coincidencia parcial**: Determinado por inclusión de palabra clave en nombres de etiquetas

### Pautas del Proyecto

#### Enfoque Básico

1. **Siempre empezar como Draft**: Todos los PRs deben crearse en estado Draft
2. **Mejora gradual de calidad**: Fase 1 (Implementación básica) → Fase 2 (Agregar pruebas) → Fase 3 (Actualizar documentación)
3. **Etiquetas apropiadas**: Agregar siempre hasta 3 etiquetas
4. **Usar plantillas**: Usar siempre `.github/PULL_REQUEST_TEMPLATE.md`
5. **Espaciado español**: Agregar siempre espacio de ancho medio entre texto español y alfanuméricos

#### Convención de Nomenclatura de Ramas

```text
{tipo}-{asunto}

Ejemplos:
- feat-user-profile
- fix-login-error
- refactor-api-client
```

#### Mensajes de Commit

```text
{tipo}: {descripción}

Ejemplos:
- feat: Implementar API de autenticación de usuario
- fix: Corregir error de login
- docs: Actualizar README
```

### Sistema de Procesamiento de Plantillas

#### Prioridad de Procesamiento

1. **Descripción PR existente**: Mantener todo lo que ya está escrito
2. **Plantilla del proyecto**: Usar `.github/PULL_REQUEST_TEMPLATE.md`
3. **Plantilla por defecto**: Usar esta si no existe nada más

#### Reglas de Preservación de Contenido Existente

- **No tocar contenido existente**: Dejar lo que ya está ahí solo
- **Llenar solo los espacios en blanco**: Agregar contenido donde falta
- **Mantener comentarios funcionales**: Como `<!-- Copilot review rule -->`
- **Mantener comentarios HTML**: Todos `<!-- ... -->` permanecen como están
- **Mantener separadores**: Cosas como `---` se quedan

#### Manejo de Preservación de Comentarios HTML

**Importante**: GitHub CLI (`gh pr edit`) automáticamente escapa comentarios HTML, y el procesamiento shell puede causar mezcla de strings inválidos como `EOF < /dev/null`.

**Soluciones Fundamentales**:

1. **Uso de opción --field de GitHub API**: Preservar comentarios HTML con procesamiento de escape apropiado
2. **Simplificación de Procesamiento de Plantilla**: Evitar procesamiento complejo de pipes y redirecciones
3. **Enfoque de Preservación Completa**: Abolir procesamiento de eliminación de comentarios HTML, preservar completamente plantillas

### Respuestas a Comentarios de Revisión

```bash
# Hacer commit de tus correcciones
git add .
git commit -m "fix: Abordar feedback de revisión"
git push
```

### Notas

#### Importancia de Preservación de Comentarios HTML

- **Problema de GitHub CLI**: `gh pr edit` escapa comentarios HTML y puede romper cosas
- **La solución**: Usar opción `--field` de GitHub API para manejo apropiado
- **Mantener todo**: No eliminar comentarios HTML - mantener toda la plantilla

#### Restricciones de Automatización

- **No nuevas etiquetas**: Solo puede usar etiquetas de `.github/labels.yml`
- **Máx 3 etiquetas**: Ese es el límite para auto-selección
- **No tocar contenido manual**: Nunca cambiar lo que alguien escribió

#### Calidad Paso a Paso

- **Empezar con Draft**: Cada PR comienza como borrador
- **Verificar CI**: Ejecutar `gh pr checks` para ver el estado
- **Marcar como listo**: Usar `gh pr ready` cuando la calidad se vea bien
- **Seguir la plantilla**: Adherirse a la estructura de tu proyecto
