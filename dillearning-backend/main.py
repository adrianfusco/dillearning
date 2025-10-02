from contextlib import asynccontextmanager
from fastapi import FastAPI
from dotenv import load_dotenv
from apis import users
from data import engine, metadata, database

load_dotenv()

metadata.create_all(bind=engine)

@asynccontextmanager
async def lifespan(app: FastAPI):
    await database.connect()
    yield
    await database.disconnect()

app = FastAPI(lifespan=lifespan)

app.include_router(users.router)
