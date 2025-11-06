from database import Base
from sqlalchemy import Boolean, Column, ForeignKey, Integer
from sqlalchemy.orm import relationship


class UserUnitProgress(Base):
    __tablename__ = "user_unit_progress"

    user_id = Column(Integer, ForeignKey("users.id"), primary_key=True)
    unit_id = Column(Integer, ForeignKey("units.id"), primary_key=True)
    completed = Column(Boolean, default=False)

    user = relationship("User", back_populates="unit_progress")
    unit = relationship("Unit", back_populates="user_progress")
