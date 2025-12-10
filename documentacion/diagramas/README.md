# Diagramas con Mermaid

He usado el paquete [mermaid-js/mermaid](https://github.com/mermaid-js/mermaid) para realizar y generar los diagramas del proyecto Dillearning.

Para más información sobre Mermaid, puedes consultar su documentación oficial en [https://mermaid.js.org/](https://mermaid.js.org/).

## Diagramas Disponibles

*   ### Arquitectura del Sistema ([arquitectura_sistema.mmd](./arquitectura_sistema.mmd))
    Este diagrama ofrece una vista de alto nivel de la estructura del sistema Dillearning, mostrando cómo interactúan los componentes del frontend (Flutter), backend (FastAPI), servicios de IA (Ollama) y el pipeline CI/CD (GitLab).

*   ### Persistencia de Datos ([persistencia_datos_esquema_bd.mmd](./persistencia_datos_esquema_bd.mmd))
    Este diagrama detalla la estructura de la base de datos SQLite, incluyendo tablas como `users`, `languages`, `courses`, `units`, `concepts`, `exercises`, `conversations` y tablas de progreso (`user_unit_progress`, `user_exercise_progress`), así como sus relaciones.

*   ### Interfaz de Usuario ([interfaz_usuario.mmd](./interfaz_usuario.mmd))
    Este diagrama describe el flujo de navegación principal de la aplicación, desde la pantalla de inicio (splash screen) y autenticación, hasta las secciones clave como la selección de idioma, el centro de aprendizaje, el perfil de usuario y las herramientas de IA integradas.

## Generación de Diagramas

Una vez modificados los ficheros `.mmd`, puedes ejecutar el script [generate_diagrams.sh](./generate_diagrams.sh) para generar los diagramas en formato `.png`:

```bash
$ bash generate_diagrams.sh
```
