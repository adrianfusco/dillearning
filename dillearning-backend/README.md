# dillearning-backend

Servicio de backend para la aplicación Dillearning, que proporciona la API, la base de datos para usuarios, contenido y generación con IA.

## Requisitos

- Python 3.12 - Recomiendo usar [pyenv](https://github.com/pyenv/pyenv) para cambiar fácilmente de versión de Python.
- Docker y Docker Compose para la configuración con contenedores (o podman).

## Ejecutar la aplicación

### Desarrollo local (con venv)

Para ello debemos tener [tox](https://tox.wiki/en/4.30.3/). Esto creará un entorno virtual bajo la carpeta .tox, instalará todas las dependencias que tenemos en el fichero requirements.txt e iniciará el servidor via uvicorn.

```bash
$tox -e dev

dev: commands[0] dillearning-backend> uvicorn main:app --app-dir dillearning-backend --host 0.0.0.0 --port 8000 --reload
INFO:     Will watch for changes in these directories: ['/home/afuscoar/.personal/a23adrianfa1']
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
INFO:     Started reloader process [1226411] using StatReload
INFO:     Started server process [1226417]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

Vemos que todo está en funcionamiento:

```
[2025-10-04 15:21:36] {afuscoar} - (~)$ -> curl -s http://localhost:8000/health | jq
{
  "status": "ok"
}
```

Debemos tener en cuenta que para el uso de los endpoints de IA debemos tener [ollama](https://ollama.com/) ejecutándose, sea en nuestro host o en un contenedor.

## Documentación de la API

FastAPI genera automáticamente la documentación de la API usando Swagger y ReDoc. Una vez que el servidor esté en funcionamiento, puedes acceder a ella en las siguientes URLs:

- **Swagger UI**: http://127.0.0.1:8000/docs
- **ReDoc**: http://127.0.0.1:8000/redoc

## [sqladmin](https://github.com/aminalaee/sqladmin)

Se ha añadido en la aplicación [sqladmin](https://github.com/aminalaee/sqladmin) con el que podemos acceder a los datos de la base de datos. En este caso a través de [admin_panel.py](./admin_panel.py). Esto permitirá al usuario administrador gestionar los cursos de una manera más sencilla. Así podemos añadir, editar o eliminar idiomas, cursos, conceptos y ejercicios.
