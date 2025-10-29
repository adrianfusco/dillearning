import sqlalchemy
from database import Base
from sqlalchemy import ForeignKey, Integer
from sqlalchemy.orm import relationship


class UserCourse(Base):
    __tablename__ = "user_courses"
    user_id = sqlalchemy.Column(Integer, ForeignKey("users.id"), primary_key=True)
    course_id = sqlalchemy.Column(Integer, ForeignKey("courses.id"), primary_key=True)

    user = relationship("User", back_populates="courses")
    course = relationship("Course")
