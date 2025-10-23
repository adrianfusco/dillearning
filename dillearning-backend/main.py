import os
from contextlib import asynccontextmanager

import models.language  # noqa: F401
import models.language_pair  # noqa: F401
import models.user  # noqa: F401
import models.user_language  # noqa: F401
from apis import ai, health, lessons, users
from database import Base, database, engine
from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse

load_dotenv()


@asynccontextmanager
async def lifespan(app: FastAPI):
    await database.connect()
    Base.metadata.create_all(bind=engine)
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


app.include_router(ai.router)
app.include_router(health.router)
app.include_router(lessons.router)
app.include_router(users.router)
