# Gestionar sistemáticamente comentarios DartDoc

Gestiona sistemáticamente los comentarios DartDoc en archivos Dart y mantiene documentación en español de alta calidad.

## Uso

```bash
# Realizar nuevas adiciones y actualizaciones simultáneamente
"Agregar comentarios DartDoc a clases sin ellos y actualizar comentarios que no cumplen estándares"

# Verificar archivos cambiados en PR
"Verificar si hay marcadores Claude en el DartDoc de archivos cambiados en PR #4308"

# Mantener documentación para directorios específicos
"Agregar DartDoc a clases Widget bajo packages/app/lib/ui/screen/"

# Ejecutar sin marcadores
/update-dart-doc --marker false
"Mejorar DartDoc en proyecto existente (sin marcadores Claude)"
```

## Opciones

- `--marker <true|false>` : Si agregar marcadores Claude (por defecto: true)

## Ejemplos Básicos

```bash
# 1. Analizar archivos objetivo
find . -name "*.dart" -not -path "*/.*" | grep -v "_test.dart" | grep -v "_vrt.dart"
"Identificar clases con DartDoc insuficiente (0 líneas o menos de 30 caracteres)"

# 2. Agregar documentación
"Agregar comentarios DartDoc que contengan elementos requeridos a las clases identificadas"

# 3. Verificar marcadores
"Asegurar que todos los DartDoc agregados/actualizados tengan marcadores Claude"
```

## Procedimiento de Ejecución

### 1. Prioridad de Elementos Objetivo

1. 🔴 **Prioridad más alta**: Elementos sin comentarios DartDoc (0 líneas de comentario)
2. 🟡 **Siguiente prioridad**: Elementos que no cumplen estándares (menos de 30 caracteres o elementos requeridos faltantes)
3. 🟢 **Objetivo de verificación**: Comentarios existentes sin marcadores Claude

**Elementos objetivo**:

- Clases (todas las definiciones de clase)
- Enums
- Extensiones
- Funciones importantes (funciones de nivel superior, opcional)

### 2. Reglas de Escritura DartDoc

**Estructura básica**:

```dart
/// {Resumen del elemento} (30-60 caracteres, requerido)
///
/// {Descripción detallada} (debe incluir rol, contexto de uso y notas, 50-200 caracteres)
///
/// Generado por Claude 🤖
@annotation  // No cambiar anotaciones existentes
class ClassName {
```

**Estilo de texto**:

- Lenguaje formal: "muestra", "es una clase que gestiona"
- Usar puntuación española: 「.」「,」
- Agregar espacio de ancho medio entre caracteres españoles y alfanuméricos
- Usar español para términos técnicos: "Estado de autenticación"
- Mantener cada línea dentro de 80 caracteres

### 3. Ejemplos de Escritura por Categoría de Clase

**Clase de gestión de estado (Riverpod)**:

```dart
/// Estado que gestiona el estado deshabilitado de gestos de deslizamiento horizontal.
///
/// Se utiliza cuando los deslizamientos horizontales necesitan ser deshabilitados durante pantallas u operaciones específicas,
/// como durante visualizaciones de carrusel o entradas específicas.
///
/// Generado por Claude 🤖
@Riverpod(keepAlive: true, dependencies: [])
class HorizontalDragGestureIgnoreState extends _$HorizontalDragGestureIgnoreState {
```

**Clase Widget**:

```dart
/// Widget que muestra un perfil de usuario.
///
/// Organiza verticalmente imagen de avatar, nombre de usuario e información de estado,
/// y navega a la pantalla de detalle de perfil cuando se toca.
///
/// Generado por Claude 🤖
class UserProfileWidget extends HookConsumerWidget {
```

### 4. Reglas para Preservar Contenido Existente

1. **Si el comentario existente cumple estándares**: Mantener como está (no agregar nuevo comentario)
   - Estándares: 30+ caracteres e incluye elementos requeridos (resumen, detalles, marcador)
2. **Si el comentario existente no cumple estándares**: Reemplazar completamente (sin duplicación)
3. **Si no hay comentario existente**: Agregar nuevo comentario

**Información importante a preservar**:

- URLs y enlaces: Referencias que comienzan con `Ver también:`
- Comentarios TODO: En el formato `TODO(nombre_usuario):`
- Notas: Advertencias como `Nota:` o `Advertencia:`
- Ejemplos de uso: Código que comienza con `Ejemplo:` o `Uso:`
- Restricciones técnicas: Descripciones de rendimiento o limitaciones

## Gestión de Marcadores Claude

```bash
# Formato de marcador
/// Generado por Claude 🤖

# Verificar marcadores en archivos cambiados de PR
gh pr diff 4308 --name-only | grep "\.dart$" | xargs grep -l "Generado por Claude"
"Agregar marcadores a archivos que no los tienen"
```

## Lista de Verificación de Calidad

- ✅ **Conteo de caracteres**: Adherir estrictamente a 30-60 caracteres para resumen, 50-200 para detalles
- ✅ **Elementos requeridos**: Incluir siempre 3 elementos - resumen, explicación detallada y marcador Claude
- ✅ **Completitud**: Describir rol, contexto de uso y notas
- ✅ **Consistencia**: Unificar estilo con lenguaje formal
- ✅ **Formato**: Agregar espacio de ancho medio entre español e inglés
- ✅ **Precisión**: Analizar implementación y solo incluir descripciones basadas en hechos
- ✅ **Estructura**: Preservar anotaciones, colocar comentarios arriba
- ✅ **Longitud**: Mantener cada línea dentro de 80 caracteres
- ✅ **Marcador**: Agregar siempre marcador para cambios por Claude

## Notas

**🔴 Prohibiciones absolutas**:

- ❌ Cambios de código distintos a comentarios de documentación
- ❌ Especulación sobre detalles de implementación (solo descripciones fácticas)
- ❌ Mezcla no natural de inglés y español
- ❌ Eliminación o modificación de anotaciones existentes
- ❌ Duplicación con comentarios existentes
- ❌ Comentarios bajo estándares de conteo de caracteres en archivos de prueba (`*_test.dart`)
- ❌ Comentarios bajo estándares de conteo de caracteres en archivos VRT (`*_vrt.dart`)

**Análisis estático y commit**:

```bash
# Registrar resultados de ejecución
ADDED_COMMENTS=0
UPDATED_COMMENTS=0
ERRORS=0

# Verificar después de cambios
melos analyze
if [ $? -ne 0 ]; then
  echo "🔴 Error: Falló análisis estático"
  exit 1
fi

# Generar resumen de ejecución
echo "📊 Resultados de ejecución:"
echo "- Comentarios agregados: $ADDED_COMMENTS"
echo "- Comentarios actualizados: $UPDATED_COMMENTS"
echo "- Errores: $ERRORS"

# Ejemplo de commit
git commit -m "docs: Agregar y actualizar comentarios DartDoc

- Agregar DartDoc a clases, enums y extensiones que no cumplen estándares
- Actualizar comentarios bajo 30 caracteres para cumplir estándares
- Agregar uniformemente marcadores Claude

Resultados de ejecución:
- Agregados: $ADDED_COMMENTS
- Actualizados: $UPDATED_COMMENTS

Generado por Claude 🤖"
```

## Criterios de Éxito de Ejecución

1. **Éxito completo**: Cuando se cumplen todos los siguientes
   - `melos analyze` PASÓ
   - 0 errores
   - Todos los comentarios agregados/actualizados cumplen estándares

2. **Éxito parcial**: Cuando
   - Menos de 5 errores
   - 90% o más de todos los comentarios cumplen estándares

3. **Falla**: Cuando
   - `melos analyze` FALLÓ
   - 5 o más errores
