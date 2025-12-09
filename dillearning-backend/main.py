import os
from contextlib import asynccontextmanager

import models.conversation  # noqa: F401
import models.course  # noqa: F401
import models.exercise  # noqa: F401
import models.language  # noqa: F401
import models.token  # noqa: F401
import models.unit  # noqa: F401
import models.user  # noqa: F401
import models.user_exercise_progress  # noqa: F401
from apis import ai, auth, courses, health, languages, users
from database import Base, engine
from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse

load_dotenv()


@asynccontextmanager
async def lifespan(app: FastAPI):
    Base.metadata.create_all(bind=engine)
    yield


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
app.include_router(languages.router)
app.include_router(users.router)
app.include_router(courses.router)
app.include_router(auth.router)
