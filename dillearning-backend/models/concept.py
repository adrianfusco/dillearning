from database import Base
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship


class Concept(Base):
    __tablename__ = "concepts"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    explanation = Column(String)
    lesson_id = Column(Integer, ForeignKey("lessons.id"))

    lesson = relationship("Lesson", back_populates="concepts")
    exercises = relationship("Exercise", back_populates="concept")
