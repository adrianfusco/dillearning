from datetime import datetime

from models.token import TokenBlocklist
from sqlalchemy.orm import Session


def add_token_to_blocklist(db: Session, jti: str):
    db_token = TokenBlocklist(jti=jti, created_at=datetime.utcnow())
    db.add(db_token)
    db.commit()
    db.refresh(db_token)
    return db_token


def is_token_blocklisted(db: Session, jti: str) -> bool:
    return (
        db.query(TokenBlocklist).filter(TokenBlocklist.jti == jti).first() is not None
    )
