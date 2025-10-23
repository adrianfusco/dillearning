import sqlalchemy
from database import Base
from sqlalchemy import Integer, String


class Language(Base):
    __tablename__ = "languages"
    id = sqlalchemy.Column(Integer, primary_key=True, index=True)
    name = sqlalchemy.Column(String, unique=True, index=True)
