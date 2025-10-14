## Verificar Hechos

Verifica si una declaración es verdadera revisando el código y documentación de tu proyecto.

### Uso

```bash
# Uso básico
/check-fact "La aplicación Flutter usa Riverpod"

# Verificar múltiples hechos a la vez
/check-fact "Este proyecto usa GraphQL y gestiona el routing con auto_route"

# Verificar detalles técnicos
/check-fact "JWT se usa para autenticación, y Firebase Auth no se usa"
```

### Cómo Funciona

1. **Dónde Busco (en orden)**
   - El código real (más confiable)
   - README.md y carpeta docs/
   - Archivos de configuración (package.json, pubspec.yaml, etc.)
   - Discusiones de issues y PR

2. **Lo que Verás**
   - `✅ Correcto` - La declaración coincide exactamente con el código
   - `❌ Incorrecto` - La declaración es errónea
   - `⚠️ Parcialmente correcto` - Algunas partes son correctas, otras no
   - `❓ No se puede determinar` - No hay suficiente información para verificar

3. **Prueba que Proporciono**
   - Nombre de archivo y número de línea
   - Fragmentos de código relevantes
   - Documentación que coincide

### Formato de Reporte

```text
## Resultados de Verificación de Hechos

### Lo que Preguntaste
"[Tu declaración]"

### Veredicto
[✅/❌/⚠️/❓] [Verdadero/Falso/Parcial/Desconocido]

### Evidencia
- **Archivo**: `ruta/al/archivo.dart:123`
- **Código**: [El código real]
- **Nota**: [Por qué esto lo prueba]

### Detalles
[Si es incorrecto, aquí está lo que realmente es verdad]
[Si es parcial, aquí está lo que falta]
[Si es desconocido, aquí está lo que necesitaría verificar]
```

### Ejemplos Básicos

```bash
# Verificar el stack tecnológico
/check-fact "Esta aplicación está construida con Flutter + Riverpod + GraphQL"

# Verificar si existe una característica
/check-fact "El modo oscuro está implementado y se puede cambiar desde configuración de usuario"

# Verificar decisiones de arquitectura
/check-fact "Toda la gestión de estado se hace con Riverpod, BLoC no se usa"

# Verificar configuración de seguridad
/check-fact "Los tokens de autenticación están cifrados y almacenados en almacenamiento seguro"
```

### Colaboración con Claude

```bash
# Verificar dependencias
ls -la && find . -name "pubspec.yaml" -exec cat {} \;
/check-fact "Las principales dependencias usadas en este proyecto son..."

# Verificar cómo está construido algo
grep -r "authentication" . --include="*.dart"
/check-fact "La autenticación es construida de forma personalizada, no usa auth de terceros"

# Verificar si los docs coinciden con la realidad
cat README.md
/check-fact "Todo en el README está realmente implementado"
```

### Cuándo Usar Esto

- Escribiendo especificaciones: Asegurar que tus descripciones son precisas
- Tomando control de un proyecto: Verificar si lo entiendes correctamente
- Actualizaciones de cliente: Verificar lo que realmente está construido
- Posts de blog: Verificar hechos de tu contenido técnico
- Presentaciones: Confirmar detalles del proyecto antes de presentar

### Importante

- El código gana sobre docs: Si no coinciden, el código tiene razón
- Los docs viejos pasan: La implementación es lo que importa
- Sin adivinanzas: Si no puedo verificarlo, lo diré
- La seguridad importa: Extra cuidadoso con hechos relacionados con seguridad
