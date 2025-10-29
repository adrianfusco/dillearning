from typing import List

from pydantic import BaseModel

from .unit import Unit


class CourseBase(BaseModel):
    code: str
    title: str
    description: str


class CourseCreate(CourseBase):
    from_language_id: int
    learning_language_id: int


class Course(CourseBase):
    id: int
    from_language_id: int
    learning_language_id: int
    units: List[Unit] = []

    class Config:
        orm_mode = True
