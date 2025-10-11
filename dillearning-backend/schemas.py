from pydantic import BaseModel


class UserBase(BaseModel):
    email: str


class UserCreate(UserBase):
    name: str
    password: str


class UserLogin(UserBase):
    password: str


class User(UserBase):
    id: int

    class Config:
        from_attributes = True


class TranslateRequest(BaseModel):
    text: str
    source_language: str
    target_language: str


class GrammarRequest(BaseModel):
    sentence: str


class ExampleRequest(BaseModel):
    word: str
    language: str


class ChatRequest(BaseModel):
    question: str
    user_id: str
