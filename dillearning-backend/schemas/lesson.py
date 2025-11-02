from typing import List

from pydantic import BaseModel

from .concept import Concept


class LessonBase(BaseModel):
    title: str
    description: str


class LessonCreate(LessonBase):
    order: int


class Lesson(LessonBase):
    id: int
    unit_id: int
    concepts: List[Concept] = []

    class Config:
        orm_mode = True
