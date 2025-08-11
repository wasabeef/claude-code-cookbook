## Explicar Código

Explica cómo funciona el código en detalle.

### Uso

```bash
# Mostrar un archivo y pedir explicación
cat <archivo>
"Explica cómo funciona este código"
```

### Ejemplos Básicos

```bash
# Entender ownership de Rust
cat main.rs
"Explica el ownership y lifetimes en este código Rust"

# Explicar un algoritmo
grep -A 50 "quicksort" sort.rs
"¿Cómo funciona este ordenamiento? ¿Cuál es su complejidad temporal?"

# Explicar patrones de diseño
cat factory.rs
"¿Qué patrón de diseño es este? ¿Cuáles son los beneficios?"
```

### Colaboración con Claude

```bash
# Explicación amigable para principiantes
cat complex_function.py
"Explica este código línea por línea para alguien nuevo en programación"

# Verificación de rendimiento
cat algorithm.rs
"Encuentra problemas de rendimiento y cómo arreglarlos"

# Explicación visual
cat state_machine.js
"Muéstrame el flujo con diagramas ASCII"

# Verificación de seguridad
cat auth_handler.go
"¿Qué problemas de seguridad ves?"
```

### Ejemplos Detallados

```bash
# Desglose de lógica compleja
cat recursive_parser.rs
"Desglosa este parser recursivo:
1. ¿Cómo fluye?
2. ¿Qué hace cada función?
3. ¿Cómo se manejan los casos límite?
4. ¿Qué podría ser mejor?"

# Explicación de código asíncrono
cat async_handler.ts
"Explica este código asíncrono:
1. ¿Cómo fluyen las Promises?
2. ¿Cómo se manejan los errores?
3. ¿Qué se ejecuta en paralelo?
4. ¿Podría esto generar deadlock?"

# Resumen de arquitectura
ls -la src/ && cat src/main.rs src/lib.rs
"Explica cómo está estructurado este proyecto"
```

### Lo Que Obtendrás

No solo qué hace el código, sino también:

- Por qué está escrito de esa manera
- Qué beneficios proporciona
- Qué problemas podrían surgir
