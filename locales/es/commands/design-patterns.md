## Patrones de Diseño

Sugiere patrones de diseño para tu código y verifica si sigue los principios SOLID.

### Uso

```bash
/design-patterns [objetivo_análisis] [opciones]
```

### Opciones

- `--suggest`: Sugerir patrones aplicables (por defecto)
- `--analyze`: Analizar uso de patrones existentes
- `--refactor`: Generar propuestas de refactoring
- `--solid`: Verificar cumplimiento con principios SOLID
- `--anti-patterns`: Detectar anti-patrones

### Ejemplos Básicos

```bash
# Analizar patrones para todo el proyecto
/design-patterns

# Sugerir patrones para archivo específico
/design-patterns src/services/user.js --suggest

# Verificar principios SOLID
/design-patterns --solid

# Detectar anti-patrones
/design-patterns --anti-patterns
```

### Categorías de Patrones

#### 1. Patrones Creacionales

- **Patrón Factory**: Abstrae la creación de objetos
- **Patrón Builder**: Construcción paso a paso de objetos complejos
- **Patrón Singleton**: Asegura que solo exista una instancia
- **Patrón Prototype**: Crea clones de objetos

#### 2. Patrones Estructurales

- **Patrón Adapter**: Convierte interfaces
- **Patrón Decorator**: Agrega funcionalidad dinámicamente
- **Patrón Facade**: Simplifica subsistemas complejos
- **Patrón Proxy**: Controla acceso a objetos

#### 3. Patrones de Comportamiento

- **Patrón Observer**: Implementa notificaciones de eventos
- **Patrón Strategy**: Cambia algoritmos
- **Patrón Command**: Encapsula operaciones
- **Patrón Iterator**: Recorre colecciones

### Principios SOLID Que Verificamos

```
S - Responsabilidad Única (una clase, un trabajo)
O - Abierto/Cerrado (abierto para extensión, cerrado para modificación)
L - Sustitución de Liskov (los subtipos deben ser reemplazables)
I - Segregación de Interfaces (no forzar métodos no utilizados)
D - Inversión de Dependencias (depender de abstracciones, no detalles)
```

### Ejemplo de Salida

```
Reporte de Análisis de Patrones de Diseño
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Patrones Actualmente Utilizados
├─ Patrón Observer: EventEmitter (12 instancias)
├─ Patrón Factory: UserFactory (3 instancias)
├─ Patrón Singleton: DatabaseConnection (1 instancia)
└─ Patrón Strategy: PaymentProcessor (5 instancias)

Patrones Recomendados
├─ [ALTO] Patrón Repository
│  └─ Dónde: src/models/*.js
│  └─ Por qué: Separar acceso a datos de lógica de negocio
│  └─ Ejemplo:
│      class UserRepository {
│        async findById(id) { ... }
│        async save(user) { ... }
│      }
│
├─ [MED] Patrón Command
│  └─ Dónde: src/api/handlers/*.js
│  └─ Por qué: Estandarizar cómo se manejan las solicitudes
│
└─ [BAJO] Patrón Decorator
   └─ Dónde: src/middleware/*.js
   └─ Por qué: Mejor manera de combinar características

Violaciones SOLID Encontradas
├─ [S] UserService: Hace demasiado (autenticación Y autorización)
├─ [O] PaymentGateway: Debe cambiar código para agregar tipos de pago
├─ [D] EmailService: Depende de clases específicas, no interfaces
└─ [I] IDataStore: Tiene métodos que nadie usa

Cómo Arreglar
1. Dividir UserService en AuthService y AuthorizationService
2. Agregar una interfaz PaymentStrategy para nuevos tipos de pago
3. Crear una interfaz EmailService
4. Dividir IDataStore en interfaces más pequeñas
```

### Ejemplos de Uso Avanzado

```bash
# Ver qué pasa si usas un patrón
/design-patterns --impact-analysis Repository

# Obtener código de ejemplo para un patrón
/design-patterns --generate Factory --for src/models/Product.js

# Encontrar patrones que funcionan bien juntos
/design-patterns --combine --context "API con caché"

# Verificar tu arquitectura
/design-patterns --architecture MVC
```

### Ejemplo: Antes y Después

#### Antes (Código Problemático)

```javascript
class OrderService {
  processOrder(order, paymentType) {
    if (paymentType === "credit") {
      // Procesamiento de tarjeta de crédito
    } else if (paymentType === "paypal") {
      // Procesamiento de PayPal
    }
    // Otros métodos de pago...
  }
}
```

#### Después (Aplicando Patrón Strategy)

```javascript
// Interfaz Strategy
class PaymentStrategy {
  process(amount) {
    throw new Error("Debe implementar el método process");
  }
}

// Estrategias concretas
class CreditCardPayment extends PaymentStrategy {
  process(amount) {
    /* Implementación */
  }
}

// Contexto
class OrderService {
  constructor(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  processOrder(order) {
    this.paymentStrategy.process(order.total);
  }
}
```

### Anti-Patrones Que Encontramos

- **Objeto Dios**: Clases que hacen todo
- **Código Espagueti**: Desorden enredado de flujo de control
- **Programación Copy-Paste**: El mismo código en todas partes
- **Números Mágicos**: Números aleatorios sin explicación
- **Infierno de Callbacks**: Callbacks dentro de callbacks dentro de callbacks

### Mejores Prácticas

1. **Ve despacio**: Agrega patrones de uno en uno
2. **Necesidad primero**: Solo usa patrones para resolver problemas reales
3. **Háblalo**: Obtén el apoyo del equipo antes de grandes cambios
4. **Escríbelo**: Documenta por qué elegiste cada patrón
