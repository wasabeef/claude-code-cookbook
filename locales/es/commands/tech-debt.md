## Deuda Técnica

Encuentra deuda técnica en tu proyecto y crea un plan para arreglarla.

### Uso

```bash
# Verificar estructura del proyecto por deuda técnica
ls -la
"Encontrar la deuda técnica en este proyecto y hacer un plan para arreglarla"
```

### Ejemplos Básicos

```bash
# Encontrar comentarios TODO/FIXME
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"Ordenar estos TODOs por prioridad y decirme cómo arreglarlos"

# Verificar dependencias
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"¿Qué dependencias están desactualizadas? ¿Cuáles son los riesgos?"

# Encontrar archivos grandes y código complejo
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -exec wc -l {} + | sort -rn | head -10
"¿Qué archivos son demasiado grandes? ¿Cómo deberíamos dividirlos?"
```

### Colaboración con Claude

```bash
# Análisis completo de deuda técnica
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"Verificar la deuda técnica de este proyecto:
1. Calidad de código (¿demasiado complejo? ¿duplicado? ¿difícil de mantener?)
2. ¿Las dependencias están saludables?
3. ¿Problemas de seguridad?
4. ¿Problemas de rendimiento?
5. ¿Pruebas faltantes?"

# Verificación de deuda de arquitectura
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"¿Qué está mal con la arquitectura? ¿Cómo lo arreglamos?"

# Hacer una lista de prioridades
"Calificar la deuda técnica y mostrarme una tabla con:
- Impacto (Alto/Medio/Bajo)
- Tiempo para arreglar
- Riesgo de negocio
- Lo que ganamos
- Cuándo hacerlo"
```

### Ejemplos Detallados

```bash
# Auto-detectar tipo de proyecto y analizar
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"Para este tipo de proyecto, verificar:
1. Deuda específica del lenguaje
2. Dónde rompemos mejores prácticas
3. Qué puede ser modernizado
4. Plan de corrección paso a paso"

# Verificación de calidad de código
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"Verificar calidad de código:
- ¿Qué funciones son demasiado complejas?
- ¿Dónde está el código duplicado?
- ¿Qué es demasiado largo?
- ¿Dónde falta manejo de errores?"

# Verificación de deuda de seguridad
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"Encontrar problemas de seguridad y decirme qué arreglar primero"

# Verificación de cobertura de pruebas
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"¿Dónde faltan pruebas? ¿Cuál es nuestra estrategia de testing?"
```

### Notas

- Auto-detecta tu lenguaje y framework
- Divide deuda en "arreglar ahora" vs "arreglar después"
- Equilibra necesidades de negocio con mejoras técnicas
- Muestra ROI - lo que obtienes por el esfuerzo
