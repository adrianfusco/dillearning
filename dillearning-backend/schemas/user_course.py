from pydantic import BaseModel

from .course import Course
from .user import User


class UserCourseBase(BaseModel):
    user_id: int
    course_id: int


class UserCourse(UserCourseBase):
    user: User
    course: Course

    class Config:
        orm_mode = True
