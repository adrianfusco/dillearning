from pydantic import BaseModel


class LanguageBase(BaseModel):
    name: str


class Language(LanguageBase):
    id: int

    class Config:
        orm_mode = True
