## Actualización de Dependencias Node

Actualiza de forma segura las dependencias en tu proyecto Node.js.

### Uso

```bash
# Verificar estado de dependencias y solicitar ayuda de Claude
npm outdated
"Por favor actualiza las dependencias en package.json a sus últimas versiones"
```

### Ejemplos Básicos

```bash
# Verificar dependencias actuales
cat package.json
"Analizar las dependencias de este proyecto Node.js y decirme qué paquetes pueden actualizarse"

# Verificar lista de paquetes actualizables
npm outdated
"Analizar el nivel de riesgo de actualizar estos paquetes"
```

### Integración con Claude

```bash
# Actualización comprensiva de dependencias
cat package.json
"Analizar dependencias Node.js y realizar lo siguiente:
1. Investigar la última versión de cada paquete
2. Verificar cambios disruptivos
3. Evaluar nivel de riesgo (seguro, precaución, peligroso)
4. Sugerir cambios de código necesarios
5. Generar package.json actualizado"

# Actualización segura y gradual
npm outdated
"Actualizar solo paquetes que puedan actualizarse de forma segura, evitando actualizaciones de versión mayor"

# Análisis de impacto para actualización de paquete específico
"Decirme el impacto y cambios necesarios al actualizar express a la última versión"
```

### Ejemplos Detallados

```bash
# Análisis detallado incluyendo notas de lanzamiento
cat package.json && npm outdated
"Analizar dependencias y proporcionar lo siguiente para cada paquete en formato tabla:
1. Versión actual → Última versión
2. Evaluación de riesgo (seguro, precaución, peligroso)
3. Cambios principales (del CHANGELOG)
4. Correcciones de código requeridas"

# Proyecto TypeScript con consideración de definiciones de tipo
cat package.json tsconfig.json
"Actualizar dependencias incluyendo definiciones de tipo TypeScript y crear un plan de actualización que evite errores de tipo"
```

### Criterios de Riesgo

```text
Seguro (🟢):
- Actualización de versión de parche (1.2.3 → 1.2.4)
- Solo correcciones de errores
- Compatibilidad hacia atrás garantizada

Precaución (🟡):
- Actualización de versión menor (1.2.3 → 1.3.0)
- Nuevas características agregadas
- Advertencias de deprecación

Peligroso (🔴):
- Actualización de versión mayor (1.2.3 → 2.0.0)
- Cambios disruptivos
- Eliminaciones o modificaciones de API
```

### Ejecución de Actualización

```bash
# Crear respaldos
cp package.json package.json.backup
cp package-lock.json package-lock.json.backup

# Ejecutar actualización
npm update

# Verificar después de actualización
npm test
npm run build
npm audit
```

### Notas

Siempre verificar funcionalidad después de actualizaciones. Si ocurren problemas, restaurar con:

```bash
cp package.json.backup package.json
cp package-lock.json.backup package-lock.json
npm install
```
