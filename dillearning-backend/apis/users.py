import schemas
from auth import create_access_token, verify_password
from data import create_user, database, get_user_by_email
from fastapi import APIRouter, HTTPException

router = APIRouter()


@router.post("/register/", response_model=schemas.User)
async def register(user: schemas.UserCreate):
    db_user = await get_user_by_email(database, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    return await create_user(db=database, user=user)


@router.post("/login/")
async def login(user: schemas.UserCreate):
    db_user = await get_user_by_email(database, email=user.email)
    if not db_user or not verify_password(user.password, db_user["hashed_password"]):
        raise HTTPException(status_code=401, detail="Incorrect email or password")

    access_token = create_access_token(data={"sub": user.email})
    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user_id": db_user["id"],
    }
