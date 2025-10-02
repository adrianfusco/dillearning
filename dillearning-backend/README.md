# dillearning-backend

Servicio de backend para nuestra aplicación dillearning donde tendremos la API disponible con la base de datos para usuarios, contenido y generación con AI.

## Requisitos

- Python 3.12

## Configuración del Entorno

```bash
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt
```

## Cómo Ejecutar la Aplicación

Iniciar entorno:

```bash
uvicorn main:app --host 0.0.0.0 --port 8000
```

## Documentación de la API

FastAPI genera documentación de la API usando Swagger y también ReDoc. Podemos verla accediendo a los siguientes enlaces:

- **Swagger UI**: http://127.0.0.1:8000/docs
- **ReDoc**: http://127.0.0.1:8000/redoc
