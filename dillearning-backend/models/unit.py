# models/unit.py
from database import Base
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship


class Unit(Base):
    __tablename__ = "units"
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    order = Column(Integer)
    course_id = Column(Integer, ForeignKey("courses.id"))
    course = relationship("Course", back_populates="units")
    lessons = relationship("Lesson", back_populates="unit")
