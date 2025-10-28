from database import Base
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship


class Exercise(Base):
    __tablename__ = "exercises"
    id = Column(Integer, primary_key=True, index=True)
    # Aún tengo que mejorar esto
    # Podemos tener ejercicios de multiple_choice o
    # translation por ejemplo
    type = Column(String)
    prompt = Column(String)
    answer = Column(String)
    options = Column(String, nullable=True)
    lesson_id = Column(Integer, ForeignKey("lessons.id"))
    lesson = relationship("Lesson", back_populates="exercises")
