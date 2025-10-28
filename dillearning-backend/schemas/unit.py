from typing import List

from pydantic import BaseModel

from .lesson import Lesson


class UnitBase(BaseModel):
    title: str
    order: int


class UnitCreate(UnitBase):
    pass


class Unit(UnitBase):
    id: int
    course_id: int
    lessons: List[Lesson] = []

    class Config:
        orm_mode = True
