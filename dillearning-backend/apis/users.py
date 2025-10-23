from auth import create_access_token, verify_password
from crud.user import create_user, get_user_by_email
from database import database
from fastapi import APIRouter, HTTPException
from schemas.user import User, UserCreate, UserLogin

router = APIRouter()


@router.post(
    "/register/",
    response_model=User,
    summary="Register a new user",
    tags=["Users"],
)
async def register(user: UserCreate):
    """
    Creates a new user with the provided email and password.
    If the email is already registered, it returns a 400 error.
    """
    db_user = await get_user_by_email(database, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    created_user = await create_user(db=database, user=user)

    return User(
        id=created_user["id"],
        email=created_user["email"],
        name=created_user["name"],
    )


@router.post("/login/", summary="User login", tags=["Users"])
async def login(user: UserLogin):
    """
    Auth an user and returns a JWT access token.
    If the credentials are incorrect, it returns a 401.
    """
    db_user = await get_user_by_email(database, email=user.email)
    if not db_user or not verify_password(user.password, db_user["hashed_password"]):
        raise HTTPException(status_code=401, detail="Incorrect email or password")

    access_token = create_access_token(data={"sub": user.email})

    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user_id": db_user["id"],
        "email": db_user["email"],
        "name": db_user["name"],
    }
