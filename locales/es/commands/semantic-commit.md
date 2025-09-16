## Commit Semántico

Divide cambios grandes en commits pequeños y significativos con mensajes apropiados. Usa solo comandos git estándar.

### Uso

```bash
/semantic-commit [opciones]
```

### Opciones

- `--dry-run`: Mostrar divisiones de commit propuestas sin hacer commit realmente
- `--lang <idioma>`: Forzar idioma para mensajes de commit (en, es)
- `--max-commits <número>`: Especificar número máximo de commits (por defecto: 10)

### Ejemplos Básicos

```bash
# Analizar cambios actuales y hacer commit en unidades lógicas
/semantic-commit

# Verificar propuesta de división únicamente (sin commit real)
/semantic-commit --dry-run

# Generar mensajes de commit en inglés
/semantic-commit --lang en

# Generar mensajes de commit en español
/semantic-commit --lang es

# Dividir en máximo 5 commits
/semantic-commit --max-commits 5
```

### Cómo Funciona

1. **Analizar Cambios**: Verificar qué cambió con `git diff HEAD`
2. **Agrupar Archivos**: Juntar archivos relacionados
3. **Crear Mensajes**: Escribir mensajes de commit semánticos para cada grupo
4. **Commit Paso a Paso**: Hacer commit de cada grupo después de tu aprobación

### Cuándo Dividir Cambios

#### Qué Hace un Cambio "Grande"

Dividimos cuando vemos:

1. **Muchos Archivos**: 5+ archivos cambiados
2. **Muchas Líneas**: 100+ líneas cambiadas
3. **Múltiples Características**: Cambios en 2+ áreas
4. **Tipos Mezclados**: feat + fix + docs juntos

```bash
# Analizar escala de cambios
CHANGED_FILES=$(git diff HEAD --name-only | wc -l)
CHANGED_LINES=$(git diff HEAD --stat | tail -1 | grep -o '[0-9]\+ insertions\|[0-9]\+ deletions' | awk '{sum+=$1} END {print sum}')

if [ $CHANGED_FILES -ge 5 ] || [ $CHANGED_LINES -ge 100 ]; then
  echo "Cambio grande detectado: se recomienda dividir"
fi
```

#### Cómo Dividir en Commits Pequeños y Significativos

##### 1. División por Límites Funcionales

```bash
# Identificar unidades funcionales desde estructura de directorios
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq
# → src/auth, src/api, components/ui, etc.
```

##### 2. Separación por Tipo de Cambio

```bash
# Archivos nuevos vs modificaciones de archivos existentes
git diff HEAD --name-status | grep '^A' # Archivos nuevos
git diff HEAD --name-status | grep '^M' # Archivos modificados
git diff HEAD --name-status | grep '^D' # Archivos eliminados
```

##### 3. Análisis de Dependencias

```bash
# Detectar cambios de relación de imports
git diff HEAD | grep -E '^[+-].*import|^[+-].*require' | \
cut -d' ' -f2- | sort | uniq
```

#### Análisis Detallado de Archivos

```bash
# Obtener lista de archivos cambiados
git diff HEAD --name-only

# Analizar cambios de cada archivo individualmente
git diff HEAD -- <archivo>

# Determinar tipo de cambio para archivos
git diff HEAD --name-status | while read status file; do
  case $status in
    A) echo "$file: Nueva creación" ;;
    M) echo "$file: Modificación" ;;
    D) echo "$file: Eliminación" ;;
    R*) echo "$file: Renombrado" ;;
  esac
done
```

#### Cómo Agrupar Archivos

1. **Por Característica**: Mantener funciones relacionadas juntas
   - archivos `src/auth/` → Autenticación
   - archivos `components/` → Componentes UI

2. **Por Tipo**: Mismo tipo de cambios
   - Solo tests → `test:`
   - Solo docs → `docs:`
   - Solo config → `chore:`

3. **Por Dependencias**: Archivos que se necesitan mutuamente
   - Modelo + Migración
   - Componente + Estilo

4. **Por Tamaño**: Mantener commits manejables
   - Máx 10 archivos por commit
   - Mantener archivos relacionados juntos

### Ejemplo de Salida

```bash
$ /semantic-commit

Analizando cambios...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Cambios detectados:
• src/auth/login.ts (modificado)
• src/auth/register.ts (nuevo)
• src/auth/types.ts (modificado)
• tests/auth.test.ts (nuevo)
• docs/authentication.md (nuevo)

Divisiones de commit propuestas:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 1/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Mensaje: feat: implementar sistema de registro y login de usuario
Archivos incluidos:
  • src/auth/login.ts
  • src/auth/register.ts
  • src/auth/types.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 2/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Mensaje: test: agregar pruebas exhaustivas para sistema de autenticación
Archivos incluidos:
  • tests/auth.test.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Commit 3/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Mensaje: docs: agregar documentación del sistema de autenticación
Archivos incluidos:
  • docs/authentication.md

¿Ejecutar commit con este plan de división? (y/n/edit):
```

### Tus Opciones

- `y`: Ir con la división propuesta
- `n`: Cancelar todo
- `edit`: Cambiar mensajes de commit
- `merge <número1> <número2>`: Combinar commits
- `split <número>`: Dividir más un commit

### Modo Dry Run

```bash
$ /semantic-commit --dry-run

Analizando cambios... (DRY RUN)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Visualización de propuesta de división de commit]

ℹ️  Modo DRY RUN: No se ejecutarán commits reales
💡 Para ejecutar, ejecutar nuevamente sin opción --dry-run
```

### Características Inteligentes

#### 1. Entiende tu Proyecto

- Detecta tipo de proyecto desde archivos de configuración
- Descubre características desde estructura de carpetas

#### 2. Reconocimiento de Patrones de Cambio

```bash
# Detectar patrones de corrección de errores
- Palabras clave como "fix", "bug", "error"
- Adición de manejo de excepciones
- Correcciones de ramas de condición

# Detectar patrones de nuevas características
- Creación de archivos nuevos
- Adiciones de nuevos métodos
- Adiciones de endpoints API
```

#### 3. Análisis de Dependencias

- Cambios a declaraciones import
- Adición/modificación de definiciones de tipos
- Relación con archivos de configuración

### Cómo Está Construido

#### Commits Paso a Paso con Git

##### 1. Preprocesamiento: Guardar Estado Actual

```bash
# Resetear cambios unstaged si los hay
git reset HEAD
git status --porcelain > /tmp/original_state.txt

# Verificar rama de trabajo
CURRENT_BRANCH=$(git branch --show-current)
echo "Rama de trabajo: $CURRENT_BRANCH"
```

##### 2. Ejecución de Commit Secuencial por Grupo

```bash
# Leer plan de división
while IFS= read -r commit_plan; do
  group_num=$(echo "$commit_plan" | cut -d':' -f1)
  files=$(echo "$commit_plan" | cut -d':' -f2- | tr ' ' '\n')

  echo "=== Ejecutando commit $group_num ==="

  # Stage solo archivos relevantes
  echo "$files" | while read file; do
    if [ -f "$file" ]; then
      git add "$file"
      echo "Staged: $file"
    fi
  done

  # Verificar estado de staging
  staged_files=$(git diff --staged --name-only)
  if [ -z "$staged_files" ]; then
    echo "Advertencia: No hay archivos staged"
    continue
  fi

  # Generar mensaje de commit (análisis LLM)
  commit_msg=$(generate_commit_message_for_staged_files)

  # Confirmación de usuario
  echo "Mensaje de commit propuesto: $commit_msg"
  echo "Archivos staged:"
  echo "$staged_files"
  read -p "¿Ejecutar este commit? (y/n): " confirm

  if [ "$confirm" = "y" ]; then
    # Ejecutar commit
    git commit -m "$commit_msg"
    echo "✅ Commit $group_num completado"
  else
    # Cancelar staging
    git reset HEAD
    echo "❌ Commit $group_num omitido"
  fi

done < /tmp/commit_plan.txt
```

##### 3. Manejo de Errores y Rollback

```bash
# Manejar fallos de pre-commit hook
commit_with_retry() {
  local commit_msg="$1"
  local max_retries=2
  local retry_count=0

  while [ $retry_count -lt $max_retries ]; do
    if git commit -m "$commit_msg"; then
      echo "✅ Commit exitoso"
      return 0
    else
      echo "❌ Commit falló (intento $((retry_count + 1))/$max_retries)"

      # Incorporar correcciones automáticas de pre-commit hooks
      if git diff --staged --quiet; then
        echo "Cambios corregidos automáticamente por pre-commit hook"
        git add -u
      fi

      retry_count=$((retry_count + 1))
    fi
  done

  echo "❌ Falló el commit. Por favor verificar manualmente."
  return 1
}

# Recuperar de interrupciones
resume_from_failure() {
  echo "Proceso de commit interrumpido detectado"
  echo "Estado de staging actual:"
  git status --porcelain

  read -p "¿Continuar procesamiento? (y/n): " resume
  if [ "$resume" = "y" ]; then
    # Reanudar desde último commit
    last_commit=$(git log --oneline -1 --pretty=format:"%s")
    echo "Último commit: $last_commit"
  else
    # Reset completo
    git reset HEAD
    echo "Proceso reseteado"
  fi
}
```

##### 4. Verificación Post-Completado

```bash
# Verificar todos los cambios committed
remaining_changes=$(git status --porcelain | wc -l)
if [ $remaining_changes -eq 0 ]; then
  echo "✅ Todos los cambios committed"
else
  echo "⚠️  Cambios sin commit permanecen:"
  git status --short
fi

# Mostrar historial de commits
echo "Commits creados:"
git log --oneline -n 10 --graph
```

##### 5. Suprimir Push Automático

```bash
# Nota: Sin push automático
echo "📝 Nota: Push automático no realizado"
echo "Si es necesario, hacer push con el siguiente comando:"
echo "  git push origin $CURRENT_BRANCH"
```

#### Detalles del Algoritmo de División

##### Paso 1: Análisis Inicial

```bash
# Obtener y clasificar todos los archivos cambiados
git diff HEAD --name-status | while read status file; do
  echo "$status:$file"
done > /tmp/changes.txt

# Estadísticas de cambios por directorio funcional
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq -c
```

##### Paso 2: Agrupación Inicial por Límites Funcionales

```bash
# Agrupación basada en directorios
GROUPS=$(git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq)
for group in $GROUPS; do
  echo "=== Grupo: $group ==="
  git diff HEAD --name-only | grep "^$group" | head -10
done
```

##### Paso 3: Analizar Similitud de Cambios

```bash
# Analizar tipo de cambio para cada archivo
git diff HEAD --name-only | while read file; do
  # Detectar adiciones de nueva función/clase
  NEW_FUNCTIONS=$(git diff HEAD -- "$file" | grep -c '^+.*function\|^+.*class\|^+.*def ')

  # Detectar patrones de corrección de errores
  BUG_FIXES=$(git diff HEAD -- "$file" | grep -c '^+.*fix\|^+.*bug\|^-.*error')

  # Determinar si es archivo de test
  if [[ "$file" =~ test|spec ]]; then
    echo "$file: TEST"
  elif [ $NEW_FUNCTIONS -gt 0 ]; then
    echo "$file: FEAT"
  elif [ $BUG_FIXES -gt 0 ]; then
    echo "$file: FIX"
  else
    echo "$file: REFACTOR"
  fi
done
```

##### Paso 4: Ajustes Basados en Dependencias

```bash
# Analizar relaciones import
git diff HEAD | grep -E '^[+-].*import|^[+-].*from.*import' | \
while read line; do
  echo "$line" | sed 's/^[+-]//' | awk '{print $2}'
done | sort | uniq > /tmp/imports.txt

# Agrupar archivos relacionados
git diff HEAD --name-only | while read file; do
  basename=$(basename "$file" .js .ts .py)
  related=$(git diff HEAD --name-only | grep "$basename" | grep -v "^$file$")
  if [ -n "$related" ]; then
    echo "Archivos relacionados: $file <-> $related"
  fi
done
```

##### Paso 5: Optimización de Tamaño de Commit

```bash
# Ajustar tamaño de grupo
MAX_FILES_PER_COMMIT=8
current_group=1
file_count=0

git diff HEAD --name-only | while read file; do
  if [ $file_count -ge $MAX_FILES_PER_COMMIT ]; then
    current_group=$((current_group + 1))
    file_count=0
  fi
  echo "Commit $current_group: $file"
  file_count=$((file_count + 1))
done
```

##### Paso 6: Determinar Grupos Finales

```bash
# Verificar resultados de división
for group in $(seq 1 $current_group); do
  files=$(grep "Commit $group:" /tmp/commit_plan.txt | cut -d':' -f2-)
  lines=$(echo "$files" | xargs git diff HEAD -- | wc -l)
  echo "Commit $group: $(echo "$files" | wc -w) archivos, $lines líneas cambiadas"
done
```

### Cumplimiento con Conventional Commits

#### Formato Básico

```text
<tipo>[ámbito opcional]: <descripción>

[cuerpo opcional]

[pie(s) opcional(es)]
```

#### Tipos Estándar

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
- `test`: Agregando o modificando pruebas

#### Ámbito (Opcional)

Indica el área afectada del cambio:

```text
feat(api): agregar endpoint de autenticación de usuario
fix(ui): resolver problema de alineación de botón
docs(readme): actualizar instrucciones de instalación
```

#### Cambio Disruptivo

Cuando hay cambios disruptivos de API:

```text
feat!: cambiar formato de respuesta de API de usuario

```

o

```text
feat(api)!: cambiar flujo de autenticación
```

#### Detectar Automáticamente Convenciones del Proyecto

**Importante**: Si existen convenciones específicas del proyecto, tienen prioridad.

##### 1. Verificar Configuración CommitLint

Detectar automáticamente configuración de los siguientes archivos:

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- sección `commitlint` en `package.json`

```bash
# Verificar archivos de configuración de ejemplo
cat commitlint.config.mjs
cat .commitlintrc.json
grep -A 10 '"commitlint"' package.json
```

##### 2. Detectar Tipos Personalizados

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
        "wip", // Trabajo en progreso
        "hotfix", // Corrección de emergencia
        "release", // Release
        "deps", // Actualización de dependencias
        "config", // Cambio de configuración
      ],
    ],
  },
};
```

##### 3. Detectar Configuraciones de Idioma

```javascript
// Cuando el proyecto usa mensajes en español
export default {
  rules: {
    "subject-case": [0], // Deshabilitar para soporte de español
    "subject-max-length": [2, "always", 72], // Ajustar límite de caracteres para español
  },
};
```

#### Flujo de Análisis Automático

1. **Búsqueda de Archivo de Configuración**

   ```bash
   find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
   ```

2. **Análisis de Commits Existentes**

   ```bash
   git log --oneline -50 --pretty=format:"%s"
   ```

3. **Estadísticas de Uso de Tipos**

   ```bash
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

#### Ejemplos de Convenciones de Proyecto

##### Estilo Angular

```text
feat(scope): agregar nueva característica
fix(scope): corregir bug
docs(scope): actualizar documentación
```

##### Estilo Combinado con Gitmoji

```text
✨ feat: agregar registro de usuario
🐛 fix: resolver problema de login
📚 docs: actualizar docs de API
```

##### Proyectos en Español

```text
feat: agregar funcionalidad de registro de usuario
fix: resolver bug del proceso de login
docs: actualizar documentación de API
```

### Detección de Idioma

Cómo determinamos tu idioma:

1. **Verificar Configuraciones CommitLint** para configuración de idioma

   ```bash
   # Determinar español si regla subject-case está deshabilitada
   grep -E '"subject-case".*\[0\]|subject-case.*0' commitlint.config.*
   ```

2. **Análisis de git log** para determinación automática

   ```bash
   # Analizar idioma de últimos 20 commits
   git log --oneline -20 --pretty=format:"%s" | \
   grep -E '^[\x{3040}-\x{30ff}]|[\x{4e00}-\x{9fff}]' | wc -l
   # Modo español si más del 50% son en español
   ```

3. **Archivos del proyecto** configuraciones de idioma

   ```bash
   # Verificar idioma de README.md
   head -10 README.md | grep -E '^[\x{3040}-\x{30ff}]|[\x{4e00}-\x{9fff}]' | wc -l

   # Verificar descripción de package.json
   grep -E '"description".*[\x{3040}-\x{30ff}]|[\x{4e00}-\x{9fff}]' package.json
   ```

4. **Análisis de comentarios y cadenas** en archivos cambiados

   ```bash
   # Verificar idioma de comentarios en archivos cambiados
   git diff HEAD | grep -E '^[+-].*//.*[\x{3040}-\x{30ff}]|[\x{4e00}-\x{9fff}]' | wc -l
   ```

#### Algoritmo de Determinación

```bash
# Calcular puntuación de idioma
SPANISH_SCORE=0

# 1. Configuraciones CommitLint (+3 puntos)
if grep -q '"subject-case".*\[0\]' commitlint.config.* 2>/dev/null; then
  SPANISH_SCORE=$((SPANISH_SCORE + 3))
fi

# 2. Análisis de git log (máx +2 puntos)
SPANISH_COMMITS=$(git log --oneline -20 --pretty=format:"%s" | \
  grep -cE '[\x{3040}-\x{30ff}]|[\x{4e00}-\x{9fff}]' 2>/dev/null || echo 0)
if [ $SPANISH_COMMITS -gt 10 ]; then
  SPANISH_SCORE=$((SPANISH_SCORE + 2))
elif [ $SPANISH_COMMITS -gt 5 ]; then
  SPANISH_SCORE=$((SPANISH_SCORE + 1))
fi

# 3. Verificación de README.md (+1 punto)
if head -5 README.md 2>/dev/null | grep -qE '[\x{3040}-\x{30ff}]|[\x{4e00}-\x{9fff}]'; then
  SPANISH_SCORE=$((SPANISH_SCORE + 1))
fi

# 4. Verificación de contenido de archivos cambiados (+1 punto)
if git diff HEAD 2>/dev/null | grep -qE '^[+-].*[\x{3040}-\x{30ff}]|[\x{4e00}-\x{9fff}]'; then
  SPANISH_SCORE=$((SPANISH_SCORE + 1))
fi

# Determinar: modo español si puntuación >= 3
if [ $SPANISH_SCORE -ge 3 ]; then
  LANGUAGE="es"
else
  LANGUAGE="en"
fi
```

### Auto-Carga de Configuración

#### Qué Sucede en Tiempo de Ejecución

Verificamos archivos de configuración en este orden:

1. **Buscar archivos de configuración CommitLint**

   ```bash
   # Buscar en este orden, usar primer archivo encontrado
   commitlint.config.mjs
   commitlint.config.js
   commitlint.config.cjs
   commitlint.config.ts
   .commitlintrc.js
   .commitlintrc.json
   .commitlintrc.yml
   .commitlintrc.yaml
   package.json (sección commitlint)
   ```

2. **Parsear contenido de configuración**
   - Extraer lista de tipos disponibles
   - Verificar restricciones de ámbito
   - Obtener límites de longitud de mensaje
   - Verificar configuraciones de idioma

3. **Analizar historial de commits existente**

   ```bash
   # Aprender patrones de uso de commits recientes
   git log --oneline -100 --pretty=format:"%s" | \
   head -20
   ```

### Requisitos

- Debe estar en un repo Git
- Necesitar cambios sin commit
- Los cambios staged se resetean temporalmente

### Importante

- **No hará push**: Necesitas hacer `git push` tú mismo
- **Misma rama**: Los commits permanecen en la rama actual
- **Hacer backup primero**: Considerar `git stash` por seguridad

### Qué Reglas Ganan

Al hacer mensajes de commit, seguimos este orden:

1. **Configuraciones CommitLint** (prioridad más alta)
   - Configuraciones en archivos `commitlint.config.*`
   - Tipos personalizados y restricciones de ámbito
   - Longitud de mensaje y restricciones de caso

2. **Historial de commits existente** (segunda prioridad)
   - Estadísticas de tipos realmente usados
   - Idioma de mensaje (español/inglés)
   - Patrones de uso de ámbito

3. **Tipo de proyecto** (tercera prioridad)
   - `package.json` → proyecto Node.js
   - `Cargo.toml` → proyecto Rust
   - `pom.xml` → proyecto Java

4. **Estándar Conventional Commits** (respaldo)
   - Comportamiento estándar cuando no se encuentran configuraciones

### Mejores Prácticas

1. **Seguir las reglas**: Usar patrones existentes
2. **Mantenerlo pequeño**: Un cambio lógico por commit
3. **Ser claro**: Decir qué cambió
4. **Agrupar inteligentemente**: Archivos relacionados juntos
5. **Tests separados**: Commits de test por su cuenta
6. **Usar configs**: CommitLint ayuda a los equipos a mantenerse consistentes

#### Análisis de Ejemplos de Configuración

**commitlint.config.mjs estándar**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "perf", "test", "chore"],
    ],
    "scope-enum": [2, "always", ["api", "ui", "core", "auth", "db"]],
  },
};
```

**Configuración compatible con español**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "subject-case": [0], // Desactivado para español
    "subject-max-length": [2, "always", 72],
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "test", "chore"],
    ],
  },
};
```

**Configuración con tipos personalizados**:

```javascript
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
        "wip", // Trabajo en progreso
        "hotfix", // Corrección urgente
        "release", // Preparación de release
        "deps", // Actualización de dependencias
        "config", // Cambios de configuración
      ],
    ],
  },
};
```

#### Comportamiento de Respaldo

Cuando no se encuentra archivo de configuración:

1. **Inferencia automática** mediante análisis de `git log`

   ```bash
   # Extraer tipos de los últimos 100 commits
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

2. **Estándar Conventional Commits** como predeterminado

   ```
   feat, fix, docs, style, refactor, perf, test, chore, build, ci
   ```

3. **Detección de idioma**
   - Commits en español > 50% → Modo español
   - Otros → Modo inglés

#### Ejemplos de Detección de Convenciones

**Detección automática de scope en Monorepo**:

```bash
# Inferir scope desde carpeta packages/
ls packages/ | head -10
# → api, ui, core, auth se sugieren como scopes
```

**Convenciones específicas de framework**:

```javascript
// Proyecto Angular
{
  'scope-enum': [2, 'always', [
    'animations', 'common', 'core', 'forms', 'http', 'platform-browser',
    'platform-server', 'router', 'service-worker', 'upgrade'
  ]]
}

// Proyecto React
{
  'scope-enum': [2, 'always', [
    'components', 'hooks', 'utils', 'types', 'styles', 'api'
  ]]
}
```

**Convenciones específicas de equipo/empresa**:

```javascript
// Patrón común en empresas hispanohablantes
{
  'type-enum': [2, 'always', [
    'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
    'wip',      // Trabajo en progreso (para pull requests)
    'hotfix',   // Corrección urgente
    'release'   // Preparación de release
  ]],
  'subject-case': [0],  // Soporte para español
  'subject-max-length': [2, 'always', 72]  // Configurado más largo para español
}
```

### Ejemplos Reales de División (Antes/Después)

#### Ejemplo 1: Agregando Sistema de Autenticación Grande

**Antes (1 commit gigante):**

```bash
# Archivos cambiados (15 archivos, 850 líneas cambiadas)
src/auth/login.js          # Nuevo archivo
src/auth/register.js       # Nuevo archivo
src/auth/password.js       # Nuevo archivo
src/auth/types.js          # Nuevo archivo
src/api/auth-routes.js     # Nuevo archivo
src/middleware/auth.js     # Nuevo archivo
src/database/migrations/001_users.sql  # Nuevo archivo
src/database/models/user.js            # Nuevo archivo
tests/auth/login.test.js   # Nuevo archivo
tests/auth/register.test.js # Nuevo archivo
tests/api/auth-routes.test.js # Nuevo archivo
docs/authentication.md    # Nuevo archivo
package.json              # Dependencias agregadas
README.md                 # Instrucciones de uso agregadas
.env.example             # Variables de entorno de ejemplo

# Commit problemático tradicional
feat: implementar sistema completo de autenticación de usuario con login, registro, restablecimiento de contraseña, rutas API, modelos de base de datos, tests y documentación
```

**Después (dividido en 5 commits con sentido):**

```bash
# Commit 1: Fundación de base de datos
feat(db): agregar modelo de usuario y esquema de autenticación

Archivos incluidos:
- src/database/migrations/001_users.sql
- src/database/models/user.js
- src/auth/types.js

Razón: La estructura de BD es la base para otras características

# Commit 2: Lógica de autenticación
feat(auth): implementar funcionalidad core de autenticación

Archivos incluidos:
- src/auth/login.js
- src/auth/register.js
- src/auth/password.js
- src/middleware/auth.js

Razón: Lógica de negocio central de autenticación agrupada

# Commit 3: Endpoints API
feat(api): agregar rutas API de autenticación

Archivos incluidos:
- src/api/auth-routes.js

Razón: Capa API depende de lógica de autenticación

# Commit 4: Tests comprehensivos
test(auth): agregar tests completos de autenticación

Archivos incluidos:
- tests/auth/login.test.js
- tests/auth/register.test.js
- tests/api/auth-routes.test.js

Razón: Tests agregados después de implementación completa

# Commit 5: Configuración y documentación
docs(auth): agregar documentación y configuración de autenticación

Archivos incluidos:
- docs/authentication.md
- package.json
- README.md
- .env.example

Razón: Documentación y configuración agrupadas al final
```

#### Ejemplo 2: Corrección de Bug y Refactorización Mezcladas

**Antes (commit problemático mezclado):**

```bash
# Archivos cambiados (8 archivos, 320 líneas cambiadas)
src/user/service.js       # Corrección de bug + refactorización
src/user/validator.js     # Nuevo archivo (refactorización)
src/auth/middleware.js    # Corrección de bug
src/api/user-routes.js    # Corrección de bug + mejora de manejo de errores
tests/user.test.js        # Tests agregados
tests/auth.test.js        # Tests de corrección de bug agregados
docs/user-api.md          # Documentación actualizada
package.json              # Dependencias actualizadas

# Commit problemático
fix: resolver bugs de validación de usuario y refactorizar lógica de validación con mejor manejo de errores
```

**Después (dividido por tipo en 3 commits):**

```bash
# Commit 1: Corrección urgente de bugs
fix: resolver bugs de validación de usuario y autenticación

Archivos incluidos:
- src/user/service.js (solo parte de corrección de bug)
- src/auth/middleware.js
- tests/auth.test.js (solo tests de corrección de bug)

Razón: Bugs que afectan producción tienen prioridad máxima

# Commit 2: Refactorización de lógica de validación
refactor: extraer y mejorar lógica de validación de usuario

Archivos incluidos:
- src/user/service.js (parte de refactorización)
- src/user/validator.js
- src/api/user-routes.js
- tests/user.test.js

Razón: Mejoras estructurales agrupadas por unidad funcional

# Commit 3: Actualización de documentación y dependencias
chore: actualizar documentación y dependencias

Archivos incluidos:
- docs/user-api.md
- package.json

Razón: Mantenimiento del entorno de desarrollo agrupado al final
```

#### Ejemplo 3: Desarrollo Simultáneo de Múltiples Características

**Antes (commit gigante cruzando características):**

```bash
# Archivos cambiados (12 archivos, 600 líneas cambiadas)
src/user/profile.js       # Nueva característica A
src/user/avatar.js        # Nueva característica A
src/notification/email.js # Nueva característica B
src/notification/sms.js   # Nueva característica B
src/api/profile-routes.js # API para característica A
src/api/notification-routes.js # API para característica B
src/dashboard/widgets.js  # Nueva característica C
src/dashboard/charts.js   # Nueva característica C
tests/profile.test.js     # Tests para característica A
tests/notification.test.js # Tests para característica B
tests/dashboard.test.js   # Tests para característica C
package.json              # Dependencias para todas las características

# Commit problemático
feat: agregar gestión de perfil de usuario, sistema de notificaciones y widgets de dashboard
```

**Después (dividido por característica en 4 commits):**

```bash
# Commit 1: Característica de perfil de usuario
feat(profile): agregar gestión de perfil de usuario

Archivos incluidos:
- src/user/profile.js
- src/user/avatar.js
- src/api/profile-routes.js
- tests/profile.test.js

Razón: Característica de perfil es unidad funcional independiente

# Commit 2: Sistema de notificaciones
feat(notification): implementar notificaciones por email y SMS

Archivos incluidos:
- src/notification/email.js
- src/notification/sms.js
- src/api/notification-routes.js
- tests/notification.test.js

Razón: Característica de notificación es unidad funcional independiente

# Commit 3: Widgets de dashboard
feat(dashboard): agregar widgets interactivos y gráficos

Archivos incluidos:
- src/dashboard/widgets.js
- src/dashboard/charts.js
- tests/dashboard.test.js

Razón: Característica de dashboard es unidad funcional independiente

# Commit 4: Actualización de dependencias e infraestructura
chore: actualizar dependencias para nuevas características

Archivos incluidos:
- package.json

Razón: Actualizaciones de dependencias comunes agrupadas al final
```

### Comparación de Efectos de División

| Elemento                | Antes (Commits Gigantes)                   | Después (División Apropiada)                        |
| ----------------------- | ------------------------------------------ | --------------------------------------------------- |
| **Revisabilidad**       | ❌ Muy difícil                             | ✅ Cada commit es pequeño y revisable               |
| **Rastreo de bugs**     | ❌ Difícil identificar problemas           | ✅ Identificación inmediata del commit problemático |
| **Revertir**            | ❌ Necesita revertir todo                  | ✅ Revertir solo la parte problemática              |
| **Desarrollo paralelo** | ❌ Propenso a conflictos                   | ✅ Fácil merge por características                  |
| **Despliegue**          | ❌ Despliegue de todas las características | ✅ Despliegue gradual posible                       |

### Solución de Problemas

#### Cuando el commit falla

- Verificar hooks de pre-commit
- Resolver dependencias
- Reintentar con archivos individuales

#### Cuando la división no es apropiada

- Ajustar con opción `--max-commits`
- Usar modo `edit` manual
- Volver a ejecutar con unidades más pequeñas
