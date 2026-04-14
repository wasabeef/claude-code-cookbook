---
description: "Actualizar dependencias de Rust de forma segura"
---

## Actualizar dependencias de Rust de forma segura

Actualiza de forma segura las dependencias en tu proyecto Rust.

### Uso

```bash
# Verificar estado de dependencias y solicitar ayuda de Claude
cargo tree
"Por favor actualiza las dependencias en Cargo.toml a sus últimas versiones"
```

### Ejemplos Básicos

```bash
# Verificar dependencias actuales
cat Cargo.toml
"Analizar las dependencias de este proyecto Rust y decirme qué crates pueden actualizarse"

# Verificar lista de crates actualizables
cargo update --dry-run
"Analizar el nivel de riesgo de actualizar estos crates"
```

### Integración con Claude

```bash
# Actualización comprensiva de dependencias
cat Cargo.toml
"Analizar dependencias Rust y realizar lo siguiente:
1. Investigar la última versión de cada crate
2. Verificar cambios disruptivos
3. Evaluar nivel de riesgo (seguro, precaución, peligroso)
4. Sugerir cambios de código necesarios
5. Generar Cargo.toml actualizado"

# Actualización segura y gradual
cargo tree
"Actualizar solo crates que puedan actualizarse de forma segura, evitando actualizaciones de versión mayor"

# Análisis de impacto para actualización de crate específico
"Decirme el impacto y cambios necesarios al actualizar tokio a la última versión"
```

### Ejemplos Detallados

```bash
# Análisis detallado incluyendo notas de lanzamiento
cat Cargo.toml && cargo tree
"Analizar dependencias y proporcionar lo siguiente para cada crate en formato tabla:
1. Versión actual → Última versión
2. Evaluación de riesgo (seguro, precaución, peligroso)
3. Cambios principales (del CHANGELOG)
4. Cambios de trait bound
5. Correcciones de código requeridas"

# Análisis de migración de async runtime
cat Cargo.toml src/main.rs
"Presentar todos los cambios necesarios para migrar de async-std a tokio o actualizar tokio a una nueva versión mayor"
```

### Criterios de Riesgo

```text
Seguro (🟢):
- Actualización de versión de parche (0.1.2 → 0.1.3)
- Solo correcciones de errores
- Compatibilidad hacia atrás garantizada

Precaución (🟡):
- Actualización de versión menor (0.1.0 → 0.2.0)
- Nuevas características agregadas
- Advertencias de deprecación

Peligroso (🔴):
- Actualización de versión mayor (0.x.y → 1.0.0, 1.x.y → 2.0.0)
- Cambios disruptivos
- Eliminaciones o modificaciones de API
- Cambios de trait bound
```

### Ejecución de Actualización

```bash
# Crear respaldos
cp Cargo.toml Cargo.toml.backup
cp Cargo.lock Cargo.lock.backup

# Ejecutar actualización
cargo update

# Verificar después de actualización
cargo check
cargo test
cargo clippy
```

### Notas

Siempre verificar funcionalidad después de actualizaciones. Si ocurren problemas, restaurar con:

```bash
cp Cargo.toml.backup Cargo.toml
cp Cargo.lock.backup Cargo.lock
cargo build
```
