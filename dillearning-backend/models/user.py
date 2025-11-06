import sqlalchemy
from database import Base
from sqlalchemy import Integer, String
from sqlalchemy.orm import relationship


class User(Base):
    __tablename__ = "users"
    id = sqlalchemy.Column(Integer, primary_key=True, index=True)
    name = sqlalchemy.Column(String)
    email = sqlalchemy.Column(String, unique=True, index=True)
    hashed_password = sqlalchemy.Column(String)
    courses = relationship("UserCourse", back_populates="user")
    unit_progress = relationship("UserUnitProgress", back_populates="user")
    exercise_progress = relationship("UserExerciseProgress", back_populates="user")
