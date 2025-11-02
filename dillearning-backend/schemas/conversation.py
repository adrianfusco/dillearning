from datetime import datetime

from pydantic import BaseModel


class ConversationBase(BaseModel):
    user_id: int
    role: str
    content: str


class ConversationCreate(ConversationBase):
    pass


class Conversation(ConversationBase):
    id: int
    created_at: datetime

    class Config:
        orm_mode = True
