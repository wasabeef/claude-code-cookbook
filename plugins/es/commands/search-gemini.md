## Búsqueda Web Gemini

Ejecuta búsquedas web vía Gemini CLI para obtener la información más reciente.

### Uso

```bash
# Búsqueda web vía Gemini CLI (requerido)
gemini --prompt "WebSearch: <consulta_de_búsqueda>"
```

### Ejemplos Básicos

```bash
# Usando Gemini CLI
gemini --prompt "WebSearch: React 19 nuevas características"
gemini --prompt "WebSearch: TypeError Cannot read property of undefined solución"
```

### Colaboración con Claude

```bash
# Búsqueda y resumen de documentación
gemini --prompt "WebSearch: Next.js 14 App Router documentación oficial"
"Resume los resultados de búsqueda y explica las características principales"

# Investigación de errores
cat error.log
gemini --prompt "WebSearch: [mensaje_de_error] solución"
"Propón la solución más apropiada de los resultados de búsqueda"

# Comparación de tecnologías
gemini --prompt "WebSearch: Rust vs Go benchmark rendimiento 2024"
"Resume las diferencias de rendimiento de los resultados de búsqueda"
```

### Ejemplos Detallados

```bash
# Recopilación de información de múltiples fuentes
gemini --prompt "WebSearch: GraphQL mejores prácticas 2024 múltiples fuentes"
"Resume información de múltiples fuentes confiables de los resultados de búsqueda"

# Investigación de cambios temporales
gemini --prompt "WebSearch: JavaScript ES2015 ES2016 ES2017 ES2018 ES2019 ES2020 ES2021 ES2022 ES2023 ES2024 características"
"Resume los cambios principales de cada versión en orden cronológico"

# Búsqueda en dominio específico
gemini --prompt "WebSearch: site:github.com Rust WebAssembly proyectos stars:>1000"
"Lista 10 proyectos ordenados por número de estrellas"

# Información de seguridad reciente
gemini --prompt "WebSearch: CVE-2024 Node.js vulnerabilidades"
"Resume el impacto y contramedidas de las vulnerabilidades encontradas"
```

### Prohibiciones

- **El uso de la herramienta WebSearch integrada de Claude está prohibido**
- Cuando se necesite búsqueda web, siempre usar `gemini --prompt "WebSearch: ..."`

### Notas Importantes

- **Si Gemini CLI está disponible, siempre usar `gemini --prompt "WebSearch: ..."`**
- Los resultados de búsqueda web no siempre son los más recientes
- Se recomienda verificar información importante en documentación oficial o fuentes confiables
