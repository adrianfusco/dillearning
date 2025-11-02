from typing import List

from pydantic import BaseModel

from .exercise import Exercise


class ConceptBase(BaseModel):
    title: str
    explanation: str


class ConceptCreate(ConceptBase):
    pass


class Concept(ConceptBase):
    id: int
    lesson_id: int
    exercises: List[Exercise] = []

    class Config:
        orm_mode = True
