## Actualización Automática de PR

## Resumen

Un comando que actualiza automáticamente las descripciones y etiquetas de Pull Request. Analiza los cambios de Git para generar y establecer descripciones y etiquetas apropiadas.

## Uso

```bash
/pr-auto-update [opciones] [número de PR]
```

### Opciones

- `--pr <número>`: Especificar número de PR objetivo (se detecta automáticamente desde la rama actual si se omite)
- `--description-only`: Actualizar solo la descripción (mantener etiquetas sin cambios)
- `--labels-only`: Actualizar solo etiquetas (mantener descripción sin cambios)
- `--dry-run`: Mostrar contenido generado sin realizar actualizaciones reales
- `--lang <idioma>`: Especificar idioma (ja, en, es)

### Ejemplos Básicos

```bash
# Auto-actualizar PR para rama actual
/pr-auto-update

# Actualizar PR específico
/pr-auto-update --pr 1234

# Actualizar solo descripción
/pr-auto-update --description-only

# Verificar con dry-run
/pr-auto-update --dry-run
```

## Detalles de Características

### 1. Auto Detección de PR

Detecta automáticamente el PR correspondiente desde la rama actual:

- Busca PR abierto relacionado con la rama actual
- Obtiene información del PR usando GitHub CLI
- Soporta tanto GitHub.com como GitHub Enterprise

### 2. Generación de Descripción

Genera automáticamente descripción del PR analizando:

- **Análisis de Commits**: Resumen de mensajes de commit
- **Detección de Cambios**: Cambios principales en archivos
- **Extracción de Propósito**: Identificación del objetivo del cambio
- **Referencias de Issues**: Detección automática de #123 mentions

### 3. Sugerencia de Etiquetas

Sugiere etiquetas apropiadas basadas en:

- **Tipo de Cambio**: `enhancement`, `bug`, `documentation`
- **Área de Impacto**: `frontend`, `backend`, `database`
- **Prioridad**: `high priority`, `low priority`
- **Estado**: `work in progress`, `ready for review`

### 4. Análisis de Impacto

Analiza el impacto de los cambios:

- **Archivos Modificados**: Lista de archivos y estadísticas
- **Dependencias**: Cambios en package.json, Gemfile, etc.
- **Breaking Changes**: Detección de cambios incompatibles
- **Cobertura de Tests**: Verificación de tests agregados

## Formato de Descripción Generada

### Estructura Estándar

```markdown
## 📋 Resumen
[Descripción breve del propósito del PR]

## 🎯 Objetivo
- [Problema que resuelve]
- [Beneficio que aporta]

## 📝 Cambios Realizados
- [Cambio principal 1]
- [Cambio principal 2]
- [Cambio principal 3]

## 🧪 Testing
- [ ] Tests unitarios agregados/actualizados
- [ ] Tests de integración pasando
- [ ] Probado manualmente

## 📊 Impacto
- **Archivos modificados**: X archivos
- **Líneas agregadas**: +XXX
- **Líneas eliminadas**: -XXX

## 📌 Issues Relacionados
- Resuelve #123
- Relacionado con #456

## 📸 Capturas de Pantalla
[Si aplica, capturas de UI/resultado]

## ⚠️ Notas para Revisores
[Puntos específicos que necesitan atención]
```

### Personalización por Tipo

**Para Features**:

- Enfoque en funcionalidad nueva
- Documentación de uso
- Ejemplos de implementación

**Para Bugfixes**:

- Descripción del bug original
- Causa raíz identificada
- Solución implementada

**Para Refactoring**:

- Justificación del cambio
- Mejoras de rendimiento/mantenibilidad
- Compatibilidad hacia atrás

## Integración con CI/CD

### GitHub Actions

```yaml
name: Auto Update PR
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  update-pr:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Update PR Description
        run: |
          /pr-auto-update --pr ${{ github.event.pull_request.number }}
```

### Pre-commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-push
if [ -n "$(git status --porcelain)" ]; then
  echo "Actualizando PR antes de push..."
  /pr-auto-update --dry-run
fi
```

## Configuración

### Archivo `.pr-auto-update.yml`

```yaml
# Configuración personalizada
language: es  # Idioma por defecto
labels:
  enabled: true
  custom:
    - "needs-review"
    - "urgent"
description:
  template: "custom"  # usar template personalizado
  include_stats: true
  include_screenshots: false
```

### Variables de Entorno

```bash
export PR_AUTO_UPDATE_LANG=es
export PR_AUTO_UPDATE_TEMPLATE=detailed
export GITHUB_TOKEN=ghp_xxxxx
```

## Solución de Problemas

### Error: "No se encontró PR asociado"

```bash
# Verificar rama actual
git branch --show-current

# Listar PRs abiertos
gh pr list

# Crear PR si no existe
gh pr create
```

### Error: "Permisos insuficientes"

```bash
# Verificar autenticación
gh auth status

# Re-autenticar si necesario
gh auth login
```

### Descripción no se actualiza

```bash
# Forzar actualización
/pr-auto-update --pr 1234 --force

# Verificar cambios locales
git status
git diff main...HEAD
```

## Patrones Comunes

### Proyecto Flutter

```markdown
Implementado {nombre_funcionalidad} para resolver {problema_usuario}.

- **Implementación UI**: Creada nueva pantalla {nombre_pantalla}
- **Gestión de Estado**: Agregados providers de Riverpod
- **Integración API**: Implementadas queries y mutaciones GraphQL
- **Tests**: Agregados tests de widgets y tests unitarios

- **Arquitectura**: {patrón_utilizado}
- **Dependencias**: {paquetes_agregados}
- **Rendimiento**: {optimizaciones_realizadas}
```

### Proyecto Node.js

```markdown
Implementado endpoint {nombre_API} para {caso_uso}.

- **Implementación API**: Creado nuevo endpoint {ruta_endpoint}
- **Validación**: Agregada lógica de validación de requests
- **Base de Datos**: Implementadas operaciones en tabla {nombre_tabla}
- **Tests**: Agregados tests de integración y unitarios

- **Autenticación**: Validación de tokens JWT
- **Autorización**: Control de acceso basado en roles
- **Validación de Entrada**: Protección contra inyección SQL
```

### Mejora CI/CD

```markdown
Mejorado workflow de GitHub Actions para {efecto_logrado}.

- **Rendimiento**: Reducido tiempo de build en {tiempo}
- **Confiabilidad**: Reforzado manejo de errores
- **Seguridad**: Mejorada gestión de secretos

- **Paralelización**: Ejecución paralela de {nombre_jobs}
- **Caché**: Optimizada estrategia de caché para {objetivo_cache}
- **Monitoreo**: Agregado monitoreo de {métricas}
```

## Mejores Prácticas

1. **Ejecutar antes de solicitar revisión**: Asegura descripciones actualizadas
2. **Usar `--dry-run` primero**: Revisa cambios antes de aplicar
3. **Mantener commits limpios**: Facilita generación de descripción
4. **Configurar templates**: Consistencia en equipo
5. **Integrar con CI**: Automatización completa

## Casos de Uso Avanzados

### Monorepo con Múltiples Packages

```bash
# Detectar cambios por package
git diff main...HEAD --name-only | grep "^packages/"
/pr-auto-update
"Genera descripción separada para cada package modificado"
```

### PR con Múltiples Colaboradores

```bash
# Incluir co-autores
git log --format="%an <%ae>" | sort -u
/pr-auto-update
"Incluye sección de colaboradores en la descripción"
```

### Release PR

```bash
# Para PRs de release
git log v1.0.0...HEAD --oneline
/pr-auto-update --labels-only
"Agrega etiquetas de release y changelog"
```

## Limitaciones

- Requiere GitHub CLI instalado y configurado
- No modifica PRs ya mergeados
- Límite de 65,536 caracteres en descripción
- No puede cambiar título del PR (usar `gh pr edit` para eso)

## Ver También

- `/pr-create` - Crear nuevo PR
- `/pr-review` - Generar revisión de PR
- `/commit-message` - Generar mensajes de commit
- `gh pr` - GitHub CLI para PRs
