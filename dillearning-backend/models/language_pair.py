import sqlalchemy
from database import Base
from sqlalchemy import ForeignKey, Integer
from sqlalchemy.orm import relationship


class LanguagePair(Base):
    __tablename__ = "language_pairs"
    id = sqlalchemy.Column(Integer, primary_key=True, index=True)
    source_language_id = sqlalchemy.Column(Integer, ForeignKey("languages.id"))
    target_language_id = sqlalchemy.Column(Integer, ForeignKey("languages.id"))

    source_language = relationship("Language", foreign_keys=[source_language_id])
    target_language = relationship("Language", foreign_keys=[target_language_id])
