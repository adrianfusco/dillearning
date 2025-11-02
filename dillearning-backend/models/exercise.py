from database import Base
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship
from sqlalchemy.types import JSON


class Exercise(Base):
    __tablename__ = "exercises"
    id = Column(Integer, primary_key=True, index=True)
    # Aún tengo que mejorar esto
    # Podemos tener ejercicios de multiple_choice o
    # translation por ejemplo
    type = Column(String)
    prompt = Column(String)
    answer = Column(String)
    options = Column(JSON, nullable=True)
    concept_id = Column(Integer, ForeignKey("concepts.id"))
    concept = relationship("Concept", back_populates="exercises")
