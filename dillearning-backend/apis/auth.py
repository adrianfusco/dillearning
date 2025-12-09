from auth import ALGORITHM, SECRET_KEY, oauth2_scheme
from crud.token import add_token_to_blocklist
from database import get_db
from fastapi import APIRouter, Depends, HTTPException, status
from jose import JWTError, jwt
from sqlalchemy.orm import Session

router = APIRouter()


@router.post("/logout")
async def logout(db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    """
    Adds the user's token's jti to a blocklist to invalidate it.
    """
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        jti = payload.get("jti")
        if jti is None:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Token does not contain jti",
            )
        add_token_to_blocklist(db, jti=jti)
        return {"message": "Successfully logged out"}
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
