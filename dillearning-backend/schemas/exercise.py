from typing import Optional

from pydantic import BaseModel


class ExerciseBase(BaseModel):
    type: str
    prompt: str
    answer: str
    options: Optional[str] = None


class ExerciseCreate(ExerciseBase):
    pass


class Exercise(ExerciseBase):
    id: int
    lesson_id: int

    class Config:
        orm_mode = True
