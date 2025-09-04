## Tech Debt

Analiza cuantitativamente la deuda técnica del proyecto y visualiza las puntuaciones de salud junto con el impacto en la eficiencia de desarrollo. Rastrea las mejoras mediante análisis de tendencias, calcula costos temporales y crea un plan de mejora priorizado.

### Uso

```bash
# Verificar configuración del proyecto para analizar deuda técnica
ls -la
"Analizar la deuda técnica de este proyecto y crear un plan de mejora"
```

### Panel de Salud del Proyecto

```
Puntuación de Salud del Proyecto: 72/100
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Puntuaciones por Categoría
├─ Frescura de dependencias: ████████░░ 82% (Actualizadas: 45/55)
├─ Completitud de documentación: ███░░░░░░░ 35% (Faltan README, documentos API)
├─ Cobertura de pruebas: ██████░░░░ 65% (Objetivo: 80%)
├─ Seguridad: ███████░░░ 78% (Vulnerabilidades: 2 Medium)
├─ Arquitectura: ██████░░░░ 60% (Dependencias circulares: 3 ubicaciones)
└─ Calidad del código: ███████░░░ 70% (Complejidad alta: 12 archivos)

📈 Tendencias (últimos 30 días)
├─ Puntuación general: 68 → 72 (+4) ↗️
├─ Elementos mejorados: 12 ✅
├─ Nueva deuda: 3 ⚠️
├─ Deuda resuelta: 8 🎉
└─ Velocidad de mejora: +0.13/día

⏱️ Impacto temporal de la deuda
├─ Desaceleración del desarrollo: -20% (desarrollo de nuevas funciones toma 1.25x tiempo normal)
├─ Tiempo de corrección de errores: +15% (tiempo promedio de corrección 2h → 2.3h)
├─ Revisión de código: +30% (tiempo adicional por complejidad de comprensión)
├─ Incorporación: +50% (tiempo necesario para que nuevos miembros entiendan)
└─ Tiempo de retraso acumulado: Equivalente a 40 horas/semana

🎯 Efectos esperados de mejora (basado en tiempo)
├─ Efecto inmediato: Velocidad de desarrollo +10% (después de 1 semana)
├─ Efecto a corto plazo: Tasa de errores -25% (después de 1 mes)
├─ Efecto a medio plazo: Velocidad de desarrollo +30% (después de 3 meses)
├─ Efecto a largo plazo: Tiempo de mantenimiento -50% (después de 6 meses)
└─ ROI: Inversión 40 horas → Recuperación 120 horas (3 meses)
```

### Ejemplos Básicos

```bash
# Análisis detallado de puntuación de salud
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Calcular la puntuación de salud del proyecto y evaluar por categorías"

# Análisis de impacto de deuda de TODO/FIXME
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"Evaluar estos TODOs por impacto de deuda (tiempo×importancia)"

# Verificación de salud de dependencias
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"Calcular puntuación de frescura de dependencias y analizar riesgos y efectos de actualizaciones"
```

### Colaboración con Claude

```bash
# Análisis integral de deuda técnica
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"Analizar la deuda técnica de este proyecto desde estas perspectivas:
1. Calidad del código (complejidad, duplicación, mantenibilidad)
2. Salud de dependencias
3. Riesgos de seguridad
4. Problemas de rendimiento
5. Falta de cobertura de pruebas"

# Análisis de deuda arquitectural
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"Identificar deuda técnica a nivel arquitectural y proponer un plan de refactorización"

# Plan de mejora priorizado
"Evaluar la deuda técnica según estos criterios y presentar en formato de tabla:
- Impacto (Alto/Medio/Bajo)
- Costo de corrección (tiempo)
- Riesgo técnico (posibilidad de falla del sistema, pérdida de datos)
- Efecto de reducción de tiempo por mejora
- Momento recomendado de implementación"
```

### Ejemplos Detallados

```bash
# Detección automática del tipo de proyecto y análisis
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"Basado en el tipo de proyecto detectado, analizar:
1. Deuda técnica específica del lenguaje/framework
2. Desviaciones de las mejores prácticas
3. Oportunidades de modernización
4. Estrategia de mejora gradual"

# Análisis de métricas de calidad del código
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"Analizar la calidad del código del proyecto y presentar estas métricas:
- Funciones con alta complejidad ciclomática
- Detección de código duplicado
- Archivos/funciones demasiado largos
- Falta de manejo adecuado de errores"

# Detección de deuda de seguridad
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"Detectar deuda técnica relacionada con seguridad y proponer prioridad de corrección y contramedidas"

# Análisis de falta de pruebas
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"Analizar la deuda técnica de cobertura de pruebas y proponer estrategia de pruebas"
```

### Matriz de Prioridades de Deuda

```
Prioridad = (Impacto × Frecuencia) ÷ Costo de corrección
```

| Prioridad                    | Impacto en desarrollo | Costo de corrección | Efecto de reducción de tiempo | Retorno de inversión          | Plazo de respuesta |
| ---------------------------- | --------------------- | ------------------- | ----------------------------- | ----------------------------- | ------------------ |
| **[P0] Respuesta inmediata** | Alto                  | Bajo                | > 5x                          | Inversión 1h→Reducción 5h+    | Inmediato          |
| **[P1] Esta semana**         | Alto                  | Medio               | 2-5x                          | Inversión 1h→Reducción 2-5h   | Dentro de 1 semana |
| **[P2] Este mes**            | Bajo                  | Alto                | 1-2x                          | Inversión 1h→Reducción 1-2h   | Dentro de 1 mes    |
| **[P3] Este trimestre**      | Bajo                  | Bajo                | < 1x                          | Inversión=tiempo de reducción | Dentro de 3 meses  |

### Criterios de Evaluación por Tipo de Deuda

| Tipo de deuda                   | Método de detección                        | Impacto en desarrollo                                 | Tiempo de corrección |
| ------------------------------- | ------------------------------------------ | ----------------------------------------------------- | -------------------- |
| **Deuda arquitectural**         | Dependencias circulares, alto acoplamiento | Gran alcance de impacto en cambios, pruebas difíciles | 40-80h               |
| **Deuda de seguridad**          | Escaneo CVE, OWASP                         | Riesgo de vulnerabilidades, cumplimiento              | 8-40h                |
| **Deuda de rendimiento**        | N+1, pérdidas de memoria                   | Aumento tiempo de respuesta, consumo de recursos      | 16-40h               |
| **Deuda de pruebas**            | Cobertura < 60%                            | Detección tardía de errores, calidad inestable        | 20-60h               |
| **Deuda de documentación**      | Falta README, documentos API               | Tiempo de incorporación aumentado                     | 8-24h                |
| **Deuda de dependencias**       | No actualizadas por 2+ años                | Riesgo de seguridad, problemas de compatibilidad      | 4-16h                |
| **Deuda de calidad del código** | Complejidad > 10                           | Tiempo de comprensión/corrección aumentado            | 2-8h                 |

### Cálculo de Impacto de Deuda Técnica

```
Impacto = Σ(peso de cada elemento × valor medido)

📊 Indicadores de impacto medibles:
├─ Impacto en la velocidad de desarrollo
│  ├─ Tiempo de comprensión del código: +X% (proporcional a complejidad)
│  ├─ Alcance de impacto en cambios: Y archivos (medido por acoplamiento)
│  └─ Tiempo de ejecución de pruebas: Z minutos (pipeline CI/CD)
│
├─ Impacto en la calidad
│  ├─ Tasa de ocurrencia de errores: +25% cada 10 de complejidad
│  ├─ Tiempo de revisión: líneas de código × coeficiente de complejidad
│  └─ Riesgo por falta de pruebas: Alto riesgo si cobertura < 60%
│
└─ Impacto en la eficiencia del equipo
   ├─ Tiempo de incorporación: +100% por falta de documentación
   ├─ Concentración de conocimiento: Atención necesaria si tasa de contribuidor único >80%
   └─ Lugares de corrección por duplicación de código: tasa de duplicación × frecuencia de cambio
```

### Cálculo de ROI basado en tiempo

```
ROI = (tiempo reducido - tiempo de inversión) ÷ tiempo de inversión × 100

Ejemplo: Resolución de dependencias circulares
├─ Tiempo de inversión: 16 horas (refactorización)
├─ Efecto de reducción (mensual):
│  ├─ Tiempo de compilación: -10 min/día × 20 días = 200 min
│  ├─ Tiempo de depuración: -2 horas/semana × 4 semanas = 8 horas
│  └─ Adición de nuevas funciones: -30% reducción de tiempo = 12 horas
├─ Tiempo de reducción mensual: 23.3 horas
└─ ROI en 3 meses: (70 - 16) ÷ 16 × 100 = 337%
```

### Notas

- Auto-detecta el lenguaje y framework del proyecto para realizar análisis específicos
- Evalúa la puntuación de salud en escala de 0-100 puntos, considerando saludable 70+ puntos y necesitando mejora <50 puntos
- Calcula costos temporales y efectos de mejora de forma específica, apoyando la toma de decisiones basada en datos
- Para conversión monetaria, especificar por separado el salario promedio por hora del equipo o coeficientes específicos del proyecto
