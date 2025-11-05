from typing import List

from pydantic import BaseModel

from .concept import Concept


class UnitBase(BaseModel):
    title: str
    order: int


class UnitCreate(UnitBase):
    pass


class Unit(UnitBase):
    id: int
    course_id: int
    concepts: List[Concept] = []

    class Config:
        orm_mode = True
