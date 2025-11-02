# models/lesson.py
from database import Base
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship


class Lesson(Base):
    __tablename__ = "lessons"
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    description = Column(String)
    order = Column(Integer)
    unit_id = Column(Integer, ForeignKey("units.id"))
    unit = relationship("Unit", back_populates="lessons")
    concepts = relationship("Concept", back_populates="lesson")
