from auth import get_password_hash
from databases import Database
from models.user import User
from schemas.user import UserCreate
from sqlalchemy import select


async def get_user_by_email(db: Database, email: str):
    query = select(User).where(User.email == email)
    return await db.fetch_one(query)


async def create_user(db: Database, user: UserCreate):
    hashed_password = get_password_hash(user.password)
    query = User.__table__.insert().values(
        name=user.name, email=user.email, hashed_password=hashed_password
    )
    last_record_id = await db.execute(query)
    return {**user.dict(), "id": last_record_id}
