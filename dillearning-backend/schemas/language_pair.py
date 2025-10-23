from pydantic import BaseModel

from .language import Language


class LanguagePairBase(BaseModel):
    source_language: str
    target_language: str


class LanguagePair(LanguagePairBase):
    id: int
    source_language: Language
    target_language: Language

    class Config:
        orm_mode = True
