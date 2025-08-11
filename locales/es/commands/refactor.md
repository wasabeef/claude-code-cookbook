## Refactor

Limpia el código de forma segura paso a paso y verifica los principios SOLID.

### Uso

```bash
# Encontrar código complejo para refactorizar
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"Hacer estos archivos grandes más simples"

# Encontrar código duplicado
grep -r "function processUser" . --include="*.js"
"Combinar estas funciones duplicadas"

# Verificar principios SOLID
grep -r "class.*Service" . --include="*.js" | head -10
"¿Estas clases tienen solo un trabajo?"
```

### Ejemplos Básicos

```bash
# Encontrar métodos largos
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"Dividir métodos de más de 50 líneas"

# Encontrar condiciones complejas
grep -r "if.*if.*if" . --include="*.js"
"Simplificar estos ifs anidados"

# Encontrar code smells
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"Arreglar estos comentarios TODO"
```

### Técnicas de Refactoring

#### Extract Method (Dividir Funciones Grandes)

```javascript
// Antes: Método largo
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

#### Replace Conditional with Polymorphism (Eliminar Cadenas Switch/If)

```javascript
// Antes: declaración switch
function getPrice(user) {
  switch (user.type) {
    case 'premium': return basePrice * 0.8;
    case 'regular': return basePrice;
  }
}

// Después: Patrón Strategy
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### Principios SOLID Que Verificamos

```
S - Responsabilidad Única
├─ Una clase = un trabajo
├─ Solo una razón para cambiar
└─ Límites claros

O - Abierto/Cerrado
├─ Fácil de extender
├─ No modificar código existente
└─ Agregar características sin romper cosas

L - Sustitución de Liskov
├─ Clases hijas pueden reemplazar a padres
├─ Mantener el mismo comportamiento
└─ No romper expectativas

I - Segregación de Interfaces
├─ Interfaces pequeñas y enfocadas
├─ Sin métodos no utilizados
└─ Cada interfaz para un rol específico

D - Inversión de Dependencias
├─ Depender de interfaces, no clases
├─ Mantener implementaciones separadas
└─ Usar inyección de dependencias
```

### Cómo Refactorizar de Forma Segura

1. **Verificar el estado actual**
   - Medir complejidad
   - Encontrar código duplicado
   - Mapear dependencias

2. **Hacer cambios pequeños**
   - Fragmentos de 15-30 minutos
   - Probar después de cada cambio
   - Hacer commit frecuentemente

3. **Verificar calidad**
   - Mantener pruebas pasando
   - Verificar rendimiento
   - Hacer revisar el código

### Code Smells a Arreglar

- **God Object**: Clases que hacen todo
- **Long Method**: Funciones de más de 50 líneas
- **Duplicate Code**: La misma lógica en múltiples lugares
- **Large Class**: Clases de más de 300 líneas
- **Long Parameter List**: Más de 3 parámetros

### Soporte de Automatización

```bash
# Análisis estático
npx complexity-report src/
sonar-scanner

# Formateo de código
npm run lint:fix
prettier --write src/

# Ejecución de pruebas
npm test
npm run test:coverage
```

### Reglas Importantes

- **No romper cosas**: Mantener el mismo comportamiento
- **Probar primero**: Escribir pruebas antes de cambiar código
- **Pasos pequeños**: No cambios enormes de una vez
- **Probar frecuentemente**: Ejecutar pruebas después de cada cambio
