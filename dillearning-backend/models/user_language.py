import sqlalchemy
from database import Base
from sqlalchemy import ForeignKey, Integer
from sqlalchemy.orm import relationship


class UserLanguage(Base):
    __tablename__ = "user_languages"
    user_id = sqlalchemy.Column(Integer, ForeignKey("users.id"), primary_key=True)
    language_pair_id = sqlalchemy.Column(
        Integer, ForeignKey("language_pairs.id"), primary_key=True
    )

    user = relationship("User", back_populates="languages")
    language_pair = relationship("LanguagePair")
