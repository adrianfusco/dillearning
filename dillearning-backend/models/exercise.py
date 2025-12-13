from database import Base
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship
from sqlalchemy.types import JSON


class Exercise(Base):
    __tablename__ = "exercises"
    id = Column(Integer, primary_key=True, index=True)
    type = Column(String)
    prompt = Column(String)
    answer = Column(String)
    options = Column(JSON)
    concept_id = Column(Integer, ForeignKey("concepts.id"))
    concept = relationship("Concept", back_populates="exercises")
    user_progress = relationship("UserExerciseProgress", back_populates="exercise")

    def __str__(self) -> str:
        return self.prompt
