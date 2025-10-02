from contextlib import asynccontextmanager

from apis import users
from data import database, engine, metadata
from dotenv import load_dotenv
from fastapi import FastAPI

load_dotenv()

metadata.create_all(bind=engine)


@asynccontextmanager
async def lifespan(app: FastAPI):
    await database.connect()
    yield
    await database.disconnect()


app = FastAPI(lifespan=lifespan)

app.include_router(users.router)
