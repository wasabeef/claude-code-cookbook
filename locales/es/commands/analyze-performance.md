## Analizar Rendimiento

Encuentra cuellos de botella de rendimiento y sugiere correcciones basadas en el análisis de deuda técnica.

### Uso

```bash
# Encontrar problemas de rendimiento comprensivamente
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Muéstrame los archivos grandes y problemas de rendimiento, luego sugiere correcciones"

# Detectar patrones ineficientes
grep -r "for.*await\|forEach.*await" . --include="*.js"
"Encontrar consultas N+1 y otros asesinos del rendimiento"

# Verificar fugas de memoria
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
"¿Dónde podríamos tener fugas de memoria y cómo las arreglamos?"
```

### Ejemplos Básicos

```bash
# Verificar tamaño de bundle y tiempo de carga
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"¿Cómo podemos reducir los bundles y optimizar los assets?"

# Rendimiento de consultas de base de datos
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"¿Qué consultas de base de datos necesitan optimización?"

# Impacto del rendimiento de dependencias
npm outdated && npm audit
"¿Las dependencias obsoletas nos están frenando?"
```

### Qué Buscamos

#### 1. Problemas a Nivel de Código

- **Algoritmos O(n²)**: Operaciones de array lentas que no escalan
- **I/O Síncrono**: Operaciones bloqueantes que congelan todo
- **Procesamiento Redundante**: Hacer el mismo trabajo una y otra vez
- **Fugas de Memoria**: Event listeners y timers que siguen ejecutándose

#### 2. Problemas de Arquitectura

- **Consultas N+1**: Demasiados viajes de ida y vuelta a la base de datos
- **Caché Faltante**: Repetir operaciones costosas
- **Hinchazón del Bundle**: Enviar código que los usuarios no necesitan
- **Desperdicio de Recursos**: Gestión pobre de conexiones y threads

#### 3. Impacto de la Deuda Técnica

- **Código Legacy**: Implementaciones antiguas que nos frenan
- **Diseño Pobre**: Todo está demasiado acoplado
- **Pruebas Faltantes**: Las regresiones de rendimiento pasan inadvertidas
- **Puntos Ciegos**: No podemos ver problemas hasta que es demasiado tarde

### Prioridades de Mejora

```
🔴 Crítico: Riesgo de falla del sistema
├─ Fugas de memoria (crashes del servidor)
├─ Consultas N+1 (carga de la base de datos)
└─ I/O Síncrono (retrasos de respuesta)

🟡 Alto: Impacto en experiencia del usuario
├─ Tamaño del bundle (tiempo de carga inicial)
├─ Optimización de imágenes (velocidad de visualización)
└─ Estrategia de caché (velocidad de respuesta)

🟢 Medio: Eficiencia operacional
├─ Actualizaciones de dependencias (seguridad)
├─ Duplicación de código (mantenibilidad)
└─ Monitoreo mejorado (carga operacional)
```

### Medición y Herramientas

#### Node.js / JavaScript

```bash
# Profiling
node --prof app.js
clinic doctor -- node app.js

# Análisis de bundle
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### Base de Datos

```sql
-- Análisis de consultas
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```

#### Frontend

```bash
# Rendimiento de React
grep -r "useMemo\|useCallback" . --include="*.jsx"

# Análisis de recursos
find ./src -name "*.png" -o -name "*.jpg" | xargs ls -lh
```

### Seguir Mejorando

- **Verificaciones semanales**: Ejecutar pruebas de rendimiento regularmente
- **Hacer seguimiento de métricas**: Observar tiempos de respuesta y uso de memoria
- **Configurar alertas**: Recibir notificaciones cuando las cosas se ralenticen
- **Compartir conocimiento**: Documentar qué funciona y qué no
