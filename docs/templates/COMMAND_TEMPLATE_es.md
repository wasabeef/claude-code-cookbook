## Nombre del Comando

Descripción concisa del comando (explicar en una línea qué hace el comando).

<!-- 
Notas para usar la plantilla:
- Secciones obligatorias: Título, descripción, uso, ejemplos básicos, colaboración con Claude, notas
- Secciones opcionales: Opciones, funciones detalladas, ejemplo de salida, mejores prácticas, comandos relacionados
- Use solo las secciones necesarias según la complejidad del comando
-->

### Uso

```bash
/nombre-comando [opciones]
```

### Opciones

- Sin opciones: Comportamiento por defecto
- `--opcion1` : Descripción de la opción 1
- `--opcion2 <valor>` : Descripción de opción que toma parámetro
- `--flag` : Descripción de opción de indicador

Nota: Si el comando no requiere opciones, esta sección completa puede omitirse.

### Ejemplos Básicos

```bash
# Uso básico
/nombre-comando
"Descripción al ejecutar"

# Ejemplo con opción
/nombre-comando --opcion1
"Descripción cuando se usa la opción 1"

# Ejemplo con opción con parámetro
/nombre-comando --opcion2 valor
"Ejemplo de uso con opción con parámetro"

# Combinación de múltiples opciones
/nombre-comando --opcion1 --flag
"Ejemplo combinando múltiples opciones"
```

### Funciones Detalladas (Opcional)

#### Categoría de Función 1

Descripción detallada de la función y escenarios de uso.

```bash
# Ejemplo de código concreto
comando ejemplo
```

#### Categoría de Función 2

Descripción detallada de otra función.

- **Característica 1**: Descripción
- **Característica 2**: Descripción
- **Característica 3**: Descripción

Nota: Para comandos simples, esta sección puede omitirse.

### Ejemplo de Salida (Opcional)

```
Ejemplo del formato de salida esperado
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Muestra del contenido de salida real
├─ Elemento 1: Valor
├─ Elemento 2: Valor
└─ Elemento 3: Valor
```

Nota: Si la salida es simple o los ejemplos básicos son suficientes, esta sección puede omitirse.

### Colaboración con Claude

```bash
# Ejemplo de uso combinado con archivo
cat archivo.txt
/nombre-comando
"Solicitar análisis incluyendo contenido del archivo"

# Ejemplo de uso en pipeline
comando1 | comando2
/nombre-comando
"Procesamiento usando salida del comando anterior"

# Ejemplo de análisis complejo
ls -la && cat config.json
/nombre-comando --opcion1
"Análisis combinando múltiple información"
```

### Notas

- **Prerrequisitos**: Condiciones necesarias para ejecutar el comando
- **Limitaciones**: Limitaciones de funcionalidad o puntos a tener en cuenta
- **Recomendaciones**: Formas recomendadas de uso efectivo

### Mejores Prácticas (Opcional)

1. **Principio 1**: Descripción del método de uso recomendado
2. **Principio 2**: Descripción de métodos de uso a evitar
3. **Principio 3**: Recomendaciones sobre rendimiento y eficiencia
4. **Principio 4**: Recomendaciones sobre seguridad

Nota: Para comandos simples sin puntos especiales de atención, esta sección puede omitirse.

### Comandos Relacionados (Opcional)

- `/comando-relacionado1` : Comando con funcionalidad relacionada
- `/comando-relacionado2` : Comando efectivo cuando se usa en combinación
- `/comando-relacionado3` : Comando que puede usarse como alternativa

Nota: Si no hay comandos relacionados, esta sección puede omitirse.
