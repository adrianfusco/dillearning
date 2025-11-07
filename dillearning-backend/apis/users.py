from auth import create_access_token
from crud.user import create_user, get_user_by_email
from database import get_db
from fastapi import APIRouter, Depends, HTTPException
from password import verify_password
from schemas.user import User, UserCreate, UserLogin
from sqlalchemy.orm import Session

router = APIRouter()


@router.post(
    "/register/",
    response_model=User,
    summary="Register a new user",
    tags=["Users"],
)
def register(user: UserCreate, db: Session = Depends(get_db)):
    """
    Creates a new user with the provided email and password.
    If the email is already registered, it returns a 400 error.
    """
    db_user = get_user_by_email(db, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    return create_user(db=db, user=user)


@router.post("/login/", summary="User login", tags=["Users"])
def login(user: UserLogin, db: Session = Depends(get_db)):
    """
    Auth an user and returns a JWT access token.
    If the credentials are incorrect, it returns a 401.
    """
    db_user = get_user_by_email(db, email=user.email)
    if not db_user or not verify_password(user.password, db_user.hashed_password):
        raise HTTPException(status_code=401, detail="Incorrect email or password")

    access_token = create_access_token(data={"sub": user.email})

    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user_id": db_user.id,
        "email": db_user.email,
        "name": db_user.name,
    }
