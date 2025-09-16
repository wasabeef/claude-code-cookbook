## Actualización de Dependencias Flutter

Actualiza de forma segura las dependencias en tu proyecto Flutter.

### Uso

```bash
# Verificar estado de dependencias y solicitar ayuda de Claude
flutter pub deps --style=compact
"Por favor actualiza las dependencias en pubspec.yaml a sus últimas versiones"
```

### Ejemplos Básicos

```bash
# Verificar dependencias actuales
cat pubspec.yaml
"Analizar las dependencias de este proyecto Flutter y decirme qué paquetes pueden actualizarse"

# Verificar antes de actualizar
flutter pub upgrade --dry-run
"Verificar si hay cambios disruptivos en esta actualización planeada"
```

### Integración con Claude

```bash
# Actualización comprensiva de dependencias
cat pubspec.yaml
"Analizar dependencias Flutter y realizar lo siguiente:
1. Investigar la última versión de cada paquete
2. Verificar cambios disruptivos
3. Evaluar nivel de riesgo (seguro, precaución, peligroso)
4. Sugerir cambios de código necesarios
5. Generar pubspec.yaml actualizado"

# Actualización segura y gradual
flutter pub outdated
"Actualizar solo paquetes que puedan actualizarse de forma segura, evitando actualizaciones de versión mayor"

# Análisis de impacto para actualización de paquete específico
"Decirme el impacto y cambios necesarios al actualizar provider a la última versión"
```

### Ejemplos Detallados

```bash
# Análisis detallado incluyendo notas de lanzamiento
cat pubspec.yaml && flutter pub outdated
"Analizar dependencias y proporcionar lo siguiente para cada paquete en formato tabla:
1. Versión actual → Última versión
2. Evaluación de riesgo (seguro, precaución, peligroso)
3. Cambios principales (del CHANGELOG)
4. Correcciones de código requeridas"

# Análisis de migración Null Safety
cat pubspec.yaml
"Identificar paquetes no compatibles con Null Safety y crear un plan de migración"
```

### Criterios de Riesgo

```text
Seguro (🟢):
- Actualización de versión de parche (1.2.3 → 1.2.4)
- Solo correcciones de errores
- Compatibilidad hacia atrás garantizada

Precaución (🟡):
- Actualización de versión menor (1.2.3 → 1.3.0)
- Nuevas características agregadas
- Advertencias de deprecación

Peligroso (🔴):
- Actualización de versión mayor (1.2.3 → 2.0.0)
- Cambios disruptivos
- Eliminaciones o modificaciones de API
```

### Ejecución de Actualización

```bash
# Crear respaldos
cp pubspec.yaml pubspec.yaml.backup
cp pubspec.lock pubspec.lock.backup

# Ejecutar actualización
flutter pub upgrade

# Verificar después de actualización
flutter analyze
flutter test
flutter pub deps --style=compact
```

### Notas

Siempre verificar funcionalidad después de actualizaciones. Si ocurren problemas, restaurar con:

```bash
cp pubspec.yaml.backup pubspec.yaml
cp pubspec.lock.backup pubspec.lock
flutter pub get
```
