## Refactor

Implementa refactorización de código segura y gradual, evalúa cuantitativamente la adherencia a los principios SOLID. Visualiza la deuda técnica y clarifica las prioridades de mejora.

### Uso

```bash
# Identificación de código complejo y plan de refactorización
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"Refactoriza estos archivos grandes para reducir la complejidad"

# Detección e integración de código duplicado
grep -r "function processUser" . --include="*.js"
"Unifica estas funciones duplicadas con Extract Method"

# Detección de violaciones de principios SOLID
grep -r "class.*Service" . --include="*.js" | head -10
"Evalúa si estas clases siguen el principio de responsabilidad única"
```

### Ejemplos básicos

```bash
# Detección de métodos largos
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"Divide métodos de más de 50 líneas con Extract Method"

# Complejidad de ramificaciones condicionales
grep -r "if.*if.*if" . --include="*.js"
"Mejora estas declaraciones condicionales anidadas con patrón Strategy"

# Detección de code smells
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"Resuelve los comentarios que se han convertido en deuda técnica"
```

### Técnicas de refactorización

#### Extract Method (Extracción de método)

```javascript
// Antes: Método extenso
function processOrder(order) {
  // 50 líneas de procesamiento complejo
}

// Después: Separación de responsabilidades
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### Replace Conditional with Polymorphism

```javascript
// Antes: sentencia switch
function getPrice(user) {
  switch (user.type) {
    case 'premium': return basePrice * 0.8;
    case 'regular': return basePrice;
  }
}

// Después: patrón Strategy
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### Puntuación de principios SOLID (0-100 puntos)

#### Criterios de evaluación y puntuación

```
S - Single Responsibility (20 puntos)
├─ Número de responsabilidades de clase: 1 (20 pts) | 2 (15 pts) | 3 (10 pts) | 4+ (5 pts)
├─ Número de métodos: <7 (+5 pts) | 7-15 (+3 pts) | >15 (0 pts)
├─ Claridad de razón de cambio: Clara (+5 pts) | Ambigua (0 pts)
└─ Ejemplo de puntuación: UserService(autenticación+procesamiento de datos) = 10 puntos

O - Open/Closed (20 puntos)
├─ Puntos de extensión: Strategy/Template Method (20 pts) | Solo herencia (10 pts) | Ninguno (5 pts)
├─ Cambios en código existente al agregar nuevas funciones: No necesario (+5 pts) | Mínimo (+3 pts) | Necesario (0 pts)
├─ Uso de interfaces: Apropiado (+5 pts) | Parcial (+3 pts) | Ninguno (0 pts)
└─ Ejemplo de puntuación: PaymentProcessor(Strategy) = 20 puntos

L - Liskov Substitution (20 puntos)
├─ Adherencia al contrato de clases derivadas: Completa (20 pts) | Parcial (10 pts) | Violación (0 pts)
├─ Fortalecimiento de precondiciones: Ninguno (+5 pts) | Existe (-5 pts)
├─ Debilitamiento de postcondiciones: Ninguno (+5 pts) | Existe (-5 pts)
└─ Ejemplo de puntuación: Square extends Rectangle = 0 puntos (violación)

I - Interface Segregation (20 puntos)
├─ Tamaño de interfaz: 1-3 métodos (20 pts) | 4-7 (15 pts) | 8+ (5 pts)
├─ Implementación de métodos no utilizados: Ninguno (+5 pts) | 1-2 (+2 pts) | 3+ (0 pts)
├─ Claridad de rol: Rol único (+5 pts) | Múltiples roles (0 pts)
└─ Ejemplo de puntuación: Separación Readable/Writable = 20 puntos

D - Dependency Inversion (20 puntos)
├─ Dirección de dependencia: Solo abstracción (20 pts) | Mixta (10 pts) | Solo concreta (5 pts)
├─ Uso de DI: Constructor Injection (+5 pts) | Setter (+3 pts) | Ninguno (0 pts)
├─ Capacidad de prueba: Mockeable (+5 pts) | Difícil (0 pts)
└─ Ejemplo de puntuación: Repository Pattern = 20 puntos

Puntuación total = S + O + L + I + D
├─ 90-100 puntos: Excelente (Cumplimiento completo SOLID)
├─ 70-89 puntos: Bueno (Margen de mejora leve)
├─ 50-69 puntos: Aceptable (Refactorización recomendada)
├─ 30-49 puntos: Pobre (Mejora a gran escala necesaria)
└─ 0-29 puntos: Crítico (Revisión de diseño obligatoria)
```

### Cuantificación de deuda técnica

#### Fórmula de cálculo de deuda

```
Deuda técnica (tiempo) = Puntuación de complejidad × Alcance de impacto × Dificultad de corrección

Puntuación de complejidad:
├─ Complejidad ciclomática: 1-5(baja) | 6-10(media) | 11-20(alta) | 21+(peligrosa)
├─ Complejidad cognitiva: Profundidad de anidación × Número de ramificaciones condicionales
├─ Líneas de código: <50(1 pt) | 50-200(2 pts) | 200-500(3 pts) | 500+(5 pts)
└─ Tasa de duplicación: 0-10%(1 pt) | 10-30%(2 pts) | 30-50%(3 pts) | 50%+(5 pts)

Alcance de impacto:
├─ Número de módulos dependientes: Dependencia directa + Dependencia indirecta × 0.5
├─ Frecuencia de uso: Número de llamadas API/día
├─ Importancia comercial: Crítica(×3) | Alta(×2) | Media(×1) | Baja(×0.5)
└─ Conocimiento del equipo: 1 persona que entiende(×3) | 2-3(×2) | 4+(×1)

Dificultad de corrección:
├─ Cobertura de pruebas: 0%(×3) | <50%(×2) | 50-80%(×1.5) | >80%(×1)
├─ Documentación: Ninguna(×2) | Insuficiente(×1.5) | Suficiente(×1)
├─ Relaciones de dependencia: Acoplamiento fuerte(×3) | Moderado(×2) | Acoplamiento débil(×1)
└─ Riesgo de cambio: Breaking Change(×3) | Consideración de compatibilidad(×2) | Seguro(×1)

Conversión de costos:
├─ Costo de tiempo: Tiempo de deuda × Salario por hora del desarrollador
├─ Costo de oportunidad: Días de retraso en desarrollo de nuevas funciones × Impacto diario en ventas
├─ Costo de calidad: Probabilidad de aparición de bugs × Costo de corrección × Frecuencia de aparición
└─ Costo total: Tiempo + Costo de oportunidad + Costo de calidad
```

#### Matriz de prioridades

| Prioridad | Grado de impacto | Costo de corrección | Plazo de respuesta | Ejemplo concreto | Acción recomendada |
|--------|--------|-----------|---------|--------|--------------|
| **Critical (Respuesta inmediata)** | Alto | Bajo | Dentro de 1 semana | God Object, dependencia circular | Iniciar refactorización inmediatamente |
| **Important (Respuesta planificada)** | Alto | Alto | Dentro de 1 mes | Separación de responsabilidades a gran escala, cambio de arquitectura | Incorporar en planificación de sprint |
| **Watch (Objeto de monitoreo)** | Bajo | Alto | Dentro de 3 meses | Procesamiento interno de alta complejidad | Monitoreo de métricas, respuesta cuando empeore |
| **Acceptable (Rango aceptable)** | Bajo | Bajo | No requiere respuesta | Code smells leves | Respuesta con refactorización normal |

### Procedimiento de refactorización

1. **Análisis y medición del estado actual**
   - Medición de complejidad (ciclomática・cognitiva)
   - Cálculo de puntuación SOLID (0-100 puntos)
   - Cuantificación de deuda técnica (tiempo/costo)
   - Creación de matriz de prioridades

2. **Ejecución gradual**
   - Pasos pequeños (unidades de 15-30 minutos)
   - Ejecución de pruebas después de cada cambio
   - Commits frecuentes
   - Medición continua de puntuación SOLID

3. **Confirmación de calidad**
   - Mantenimiento de cobertura de pruebas
   - Medición de rendimiento
   - Confirmación de reducción de deuda técnica
   - Revisión de código

### Code smells comunes y puntuación de deuda

| Code Smell | Criterio de detección | Puntuación de deuda | Método de mejora |
|-------------|---------|-----------|---------|
| **God Object** | Responsabilidades >3, métodos >20 | Alta (15-20h) | Extract Class, aplicación SRP |
| **Long Method** | Líneas >50, complejidad >10 | Media (5-10h) | Extract Method |
| **Duplicate Code** | Tasa de duplicación >30% | Alta (10-15h) | Extract Method/Class |
| **Large Class** | Líneas >300, métodos >15 | Alta (10-20h) | Extract Class |
| **Long Parameter List** | Parámetros >4 | Baja (2-5h) | Parameter Object |
| **Feature Envy** | Referencias a otras clases >5 | Media (5-10h) | Move Method |
| **Data Clumps** | Repetición de mismo grupo de argumentos | Baja (3-5h) | Extract Class |
| **Primitive Obsession** | Uso excesivo de tipos primitivos | Media (5-8h) | Replace with Object |
| **Switch Statements** | case >5 | Media (5-10h) | Strategy Pattern |
| **Shotgun Surgery** | Áreas afectadas al cambiar >3 | Alta (10-15h) | Move Method/Field |

### Ejemplo práctico: Evaluación de puntuación SOLID

```javascript
// Objeto de evaluación: clase UserService
class UserService {
  constructor(db, cache, logger, emailService) { // 4 dependencias
    this.db = db;
    this.cache = cache;
    this.logger = logger;
    this.emailService = emailService;
  }
  
  // Responsabilidad 1: autenticación
  authenticate(username, password) { /* ... */ }
  refreshToken(token) { /* ... */ }
  
  // Responsabilidad 2: gestión de usuarios
  createUser(data) { /* ... */ }
  updateUser(id, data) { /* ... */ }
  deleteUser(id) { /* ... */ }
  
  // Responsabilidad 3: notificación
  sendWelcomeEmail(user) { /* ... */ }
  sendPasswordReset(email) { /* ... */ }
}

// Resultado de evaluación de puntuación SOLID
S: 10 puntos (3 responsabilidades: autenticación, CRUD, notificación)
O: 5 puntos (sin puntos de extensión, implementación directa)
L: 15 puntos (sin herencia, no aplicable)
I: 10 puntos (interfaz no segregada)
D: 10 puntos (dependencia de clases concretas)
Total: 50 puntos (Aceptable - Refactorización recomendada)

// Deuda técnica
Complejidad: 15 (7 métodos, 3 responsabilidades)
Alcance de impacto: 8 (autenticación usada en todas las funciones)
Dificultad de corrección: 2 (con pruebas, documentación insuficiente)
Tiempo de deuda: 15 × 8 × 2 = 240 horas
Prioridad: Critical (sistema de autenticación requiere respuesta inmediata)
```

### Ejemplo de implementación después de mejora

```javascript
// Después de aplicar principios SOLID (Puntuación: 90 puntos)

// S: Responsabilidad única (20 puntos)
class AuthenticationService {
  authenticate(credentials) { /* ... */ }
  refreshToken(token) { /* ... */ }
}

// O: Abierto/cerrado (20 puntos)
class UserRepository {
  constructor(storage) { // Strategy Pattern
    this.storage = storage;
  }
  save(user) { return this.storage.save(user); }
}

// I: Segregación de interfaz (20 puntos)
interface Readable {
  find(id);
  findAll();
}
interface Writable {
  save(entity);
  delete(id);
}

// D: Inversión de dependencia (20 puntos)
class UserService {
  constructor(
    private auth: IAuthService,
    private repo: IUserRepository,
    private notifier: INotificationService
  ) {}
}

// Reducción de deuda: 240 horas → 20 horas (92% de reducción)
```

### Soporte de automatización

```bash
# Medición de puntuación SOLID
npx solid-analyzer src/ --output report.json

# Análisis de complejidad
npx complexity-report src/ --format json
sonar-scanner -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info

# Visualización de deuda técnica
npx code-debt-analyzer --config .debt.yml

# Formato de código
npm run lint:fix
prettier --write src/

# Ejecución de pruebas y cobertura
npm test -- --coverage
npm run test:mutation  # pruebas de mutación
```

### Precauciones

- **Prohibición de cambios funcionales**: No cambiar el comportamiento externo
- **Test first**: Agregar pruebas antes de la refactorización
- **Enfoque gradual**: No hacer cambios grandes de una vez
- **Verificación continua**: Ejecución de pruebas en cada paso