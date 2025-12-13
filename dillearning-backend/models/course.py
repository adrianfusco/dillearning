from database import Base
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship


class Course(Base):
    __tablename__ = "courses"
    id = Column(Integer, primary_key=True, index=True)
    code = Column(String, unique=True, index=True)  # e.g. "es-en"
    from_language_id = Column(Integer, ForeignKey("languages.id"))
    learning_language_id = Column(Integer, ForeignKey("languages.id"))
    title = Column(String)
    description = Column(String)

    units = relationship("Unit", back_populates="course")

    def __str__(self) -> str:
        return self.title
