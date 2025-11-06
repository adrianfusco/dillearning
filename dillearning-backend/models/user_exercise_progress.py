from database import Base
from sqlalchemy import Boolean, Column, ForeignKey, Integer
from sqlalchemy.orm import relationship


class UserExerciseProgress(Base):
    __tablename__ = "user_exercise_progress"

    user_id = Column(Integer, ForeignKey("users.id"), primary_key=True)
    exercise_id = Column(Integer, ForeignKey("exercises.id"), primary_key=True)
    completed = Column(Boolean, default=False)

    user = relationship("User", back_populates="exercise_progress")
    exercise = relationship("Exercise", back_populates="user_progress")
