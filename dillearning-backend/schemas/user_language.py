from pydantic import BaseModel

from .language_pair import LanguagePair
from .user import User


class UserLanguageBase(BaseModel):
    user_id: int
    language_pair_id: int


class UserLanguage(UserLanguageBase):
    user: User
    language_pair: LanguagePair

    class Config:
        orm_mode = True
