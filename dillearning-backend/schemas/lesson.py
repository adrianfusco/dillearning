from typing import List

from pydantic import BaseModel

from .exercise import Exercise


class LessonBase(BaseModel):
    title: str
    description: str


class LessonCreate(LessonBase):
    order: int


class Lesson(LessonBase):
    id: int
    unit_id: int
    exercises: List[Exercise] = []

    class Config:
        orm_mode = True
