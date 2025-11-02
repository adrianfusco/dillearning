from models.conversation import Conversation
from schemas.conversation import ConversationCreate
from sqlalchemy.orm import Session


def create_conversation_message(db: Session, message: ConversationCreate):
    db_message = Conversation(**message.dict())
    db.add(db_message)
    db.commit()
    db.refresh(db_message)
    return db_message


def get_conversation_history(db: Session, user_id: int, limit: int = 10):
    return (
        db.query(Conversation)
        .filter(Conversation.user_id == user_id)
        .order_by(Conversation.created_at.desc())
        .limit(limit)
        .all()[::-1]
    )
