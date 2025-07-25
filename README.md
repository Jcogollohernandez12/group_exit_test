
# Grupo Éxito - Prueba Técnica Flutter

Este proyecto es una prueba técnica desarrollada para el Grupo Éxito. Consiste en una aplicación Flutter que permite:

- Consultar y mostrar las categorías disponibles (llamado a API).
- Visualizar los productos de una categoría seleccionada.
- Agregar productos al carrito de compras.

## Arquitectura y Estructura de Carpetas

El proyecto está organizado siguiendo buenas prácticas de arquitectura limpia y separación de responsabilidades:

- **lib/core/**: Código base, configuración, recursos, utilidades y router.
- **lib/ui/feature/**: Funcionalidades principales (splash, home, categorías, productos, carrito, etc.).
- **lib/ui/shared/**: Widgets reutilizables y temas visuales.
- **assets/**: Recursos gráficos, fuentes, imágenes y colores.
- **test/**: Pruebas unitarias y de widgets.

## Principales Funcionalidades

1. **Pantalla de Splash**: Animación de bienvenida con identidad visual de Grupo Éxito.
2. **Listado de Categorías**: Consulta a la API y visualización en tarjetas.
3. **Productos por Categoría**: Al seleccionar una categoría, se muestran sus productos.
4. **Carrito de Compras**: Permite agregar productos y visualizar el resumen del carrito.

## Tecnologías y Paquetes Utilizados

- Flutter
- flutter_bloc (gestión de estado)
- go_router (navegación)
- get_it (inyección de dependencias)


## Cómo Ejecutar

1. Instala las dependencias:
   ```bash
   flutter pub get
   ```
2. Agrega los archivos de configuración necesarios en la carpeta `assets/envs` (por ejemplo, archivos `.env.development` - `.env.production` para variables de entorno, endpoints, etc.).
3. Ejecuta la app:
   ```bash
   flutter run
   ```

## Notas

- El proyecto utiliza una arquitectura escalable y modular.
- Los colores, fuentes y gradientes están alineados con la identidad visual de Grupo Éxito.
- El código está documentado y estructurado para facilitar la extensión y el mantenimiento.
- Recuerda agregar los archivos de configuración en `assets/envs` antes de ejecutar la app.

---
Desarrollado como prueba técnica para Grupo Éxito.
