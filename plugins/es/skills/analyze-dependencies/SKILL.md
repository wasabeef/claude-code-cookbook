---
description: "Analizar dependencias del proyecto y evaluar salud arquitectónica"
---

## Análisis de Dependencias

Analiza las dependencias de tu proyecto y verifica la salud de la arquitectura.

### Uso

```bash
/dependency-analysis [opciones]
```

### Opciones

- `--visual`: Mostrar dependencias visualmente
- `--circular`: Detectar solo dependencias circulares
- `--depth <número>`: Especificar profundidad de análisis (por defecto: 3)
- `--focus <ruta>`: Enfocarse en módulo/directorio específico

### Ejemplos Básicos

```bash
# Analizar dependencias de todo el proyecto
/dependency-analysis

# Detectar dependencias circulares
/dependency-analysis --circular

# Análisis detallado de módulo específico
/dependency-analysis --focus src/core --depth 5
```

### Qué Se Analiza

#### 1. Matriz de Dependencias

Muestra cómo los módulos se conectan entre sí:

- Dependencias directas
- Dependencias indirectas
- Profundidad de dependencias
- Fan-in/fan-out

#### 2. Violaciones de Arquitectura

- Violaciones de capas (cuando capas inferiores dependen de superiores)
- Dependencias circulares
- Acoplamiento excesivo (demasiadas conexiones)
- Módulos huérfanos

#### 3. Verificación de Clean Architecture

- ¿Es independiente la capa de dominio?
- ¿Está la infraestructura separada correctamente?
- ¿Fluyen correctamente las dependencias de casos de uso?
- ¿Se están usando las interfaces correctamente?

### Ejemplo de Salida

```text
Reporte de Análisis de Dependencias
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Resumen de Métricas
├─ Total de módulos: 42
├─ Dependencias promedio: 3.2
├─ Profundidad máxima de dependencias: 5
└─ Dependencias circulares: 2 detectadas

⚠️  Violaciones de Arquitectura
├─ [ALTO] src/domain/user.js → src/infra/database.js
│  └─ Capa de dominio depende directamente de capa de infraestructura
├─ [MED] src/api/auth.js ⟲ src/services/user.js
│  └─ Dependencia circular detectada
└─ [BAJO] src/utils/helper.js → 12 módulos
   └─ Fan-out excesivo

✅ Acciones Recomendadas
1. Introducir interfaz UserRepository
2. Rediseñar responsabilidades del servicio de autenticación
3. Dividir funciones helper por funcionalidad

📈 Gráfico de Dependencias
[Diagrama visual de dependencias mostrado en arte ASCII]
```

### Ejemplos de Uso Avanzado

```bash
# Verificaciones automáticas CI/CD
/dependency-analysis --circular --fail-on-violation

# Verificar contra reglas de arquitectura
/dependency-analysis --rules .architecture-rules.yml

# Ver cómo cambiaron las dependencias
/dependency-analysis --compare HEAD~10
```

### Ejemplo de Archivo de Configuración (.dependency-analysis.yml)

```yaml
rules:
  - name: "Independencia de Dominio"
    source: "src/domain/**"
    forbidden: ["src/infra/**", "src/api/**"]

  - name: "Dependencias de Capa API"
    source: "src/api/**"
    allowed: ["src/domain/**", "src/application/**"]
    forbidden: ["src/infra/**"]

thresholds:
  max_dependencies: 8
  max_depth: 4
  coupling_threshold: 0.7

ignore:
  - "**/test/**"
  - "**/mocks/**"
```

### Herramientas Que Usamos

- `madge`: Muestra dependencias de JavaScript/TypeScript visualmente
- `dep-cruiser`: Verifica reglas de dependencias
- `nx`: Gestiona dependencias de monorepo
- `plato`: Analiza complejidad y dependencias juntas

### Colaboración con Claude

```bash
# Verificar dependencias con package.json
cat package.json
/analyze-dependencies
"Encontrar problemas de dependencias en este proyecto"

# Profundizar en un módulo específico
ls -la src/core/
/analyze-dependencies --focus src/core
"Verificar las dependencias del módulo core en detalle"

# Comparar diseño vs realidad
cat docs/architecture.md
/analyze-dependencies --visual
"¿Nuestra implementación coincide con los documentos de arquitectura?"
```

### Notas

- **Ejecutar desde**: Directorio raíz del proyecto
- **Ten paciencia**: Los proyectos grandes toman tiempo para analizar
- **Actúa rápido**: Corrige las dependencias circulares tan pronto como las encuentres

### Mejores Prácticas

1. **Verificar semanalmente**: Mantén un ojo en la salud de las dependencias
2. **Escribir reglas**: Pon las reglas de arquitectura en archivos de configuración
3. **Pasos pequeños**: Corrige las cosas gradualmente, no todo a la vez
4. **Seguir tendencias**: Observa cómo cambia la complejidad a lo largo del tiempo
