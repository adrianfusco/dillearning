import schemas
import sqlalchemy
from auth import get_password_hash
from databases import Database
from sqlalchemy import MetaData, create_engine
from sqlalchemy.orm import Session

DATABASE_URL = "sqlite:///./dillearning.db"
database = Database(DATABASE_URL)
metadata = MetaData()
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})

users = sqlalchemy.Table(
    "users",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True),
    sqlalchemy.Column("email", sqlalchemy.String, unique=True, index=True),
    sqlalchemy.Column("hashed_password", sqlalchemy.String),
)


async def get_user_by_email(db: Session, email: str):
    query = users.select().where(users.c.email == email)
    return await db.fetch_one(query)


async def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = get_password_hash(user.password)
    query = users.insert().values(email=user.email, hashed_password=hashed_password)
    last_record_id = await db.execute(query)
    return {**user.dict(), "id": last_record_id}
