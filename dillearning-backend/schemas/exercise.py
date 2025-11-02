from typing import List, Optional

from pydantic import BaseModel


class ExerciseBase(BaseModel):
    type: str
    prompt: str
    answer: str
    options: Optional[List[str]] = None


class ExerciseCreate(ExerciseBase):
    pass


class Exercise(ExerciseBase):
    id: int
    concept_id: int

    class Config:
        orm_mode = True
