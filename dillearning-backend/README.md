# dillearning-backend

Servicio de backend para la aplicación Dillearning, que proporciona la API, la base de datos para usuarios, contenido y generación con IA.

## Requisitos

- Python 3.12
- Docker y Docker Compose para la configuración con contenedores (o podman).

## Ejecutar la aplicación

### Desarrollo local (con venv)

Para ello debemos tener [tox](https://tox.wiki/en/4.30.3/). Esto creará un entorno virtual bajo la carpeta .tox, instalará todas las dependencias que tenemos en el fichero requirements.txt e iniciará el servidor via uvicorn.

```bash
$ tox -e dev
```

### Docker Compose

Esta es la forma recomendada de ejecutar la aplicación para un entorno similar al de producción o si prefieres usar contenedores. Esta configuración también levantará el servicio `ollama` requerido para consultas a IA.

Desde el directorio `dillearning-backend`, simplemente ejecuta:
```bash
docker-compose up -d
```

Esto iniciará dos servicios:
- **api**: La aplicación FastAPI, disponible en el puerto `8000`.
- **ollama**: El servicio Ollama, que descargará el modelo `granite3.3:2b` y estará disponible en el puerto `11434`.

## Documentación de la API

FastAPI genera automáticamente la documentación de la API usando Swagger y ReDoc. Una vez que el servidor esté en funcionamiento, puedes acceder a ella en las siguientes URLs:

- **Swagger UI**: http://127.0.0.1:8000/docs
- **ReDoc**: http://127.0.0.1:8000/redoc
