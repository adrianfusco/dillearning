import os
from contextlib import asynccontextmanager

from apis import ai, health, users
from data import database, engine, metadata
from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse

load_dotenv()

metadata.create_all(bind=engine)


@asynccontextmanager
async def lifespan(app: FastAPI):
    await database.connect()
    yield
    await database.disconnect()


app = FastAPI(lifespan=lifespan)

# Configuramos CORS ya que nuestra aplicación backend estará separada del frontend
if os.getenv("ENVIRONMENT") == "dev":
    # En caso de que estemos en dev permitimos localhost:
    app.add_middleware(
        CORSMiddleware,
        # Flutter inicia en puertos aleatorios así que usamos regex:
        allow_origin_regex=r"http://(localhost|127\.0\.0\.1):\d+",
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
# Para producción tendremos algo como:
# else:
#     app.add_middleware(
#         CORSMiddleware,
#         allow_origins=["https://dillearning.com"],
#         allow_credentials=True,
#         allow_methods=["GET", "POST"],
#         allow_headers=["Content-Type", "Authorization"],
#     )


@app.get("/")
async def root():
    """
    Redirect to /docs
    """
    return RedirectResponse(url="/docs")


app.include_router(users.router)
app.include_router(ai.router)
app.include_router(health.router)
