from pydantic import BaseModel


class LessonBase(BaseModel):
    title: str
    description: str


class LessonCreate(LessonBase):
    order: int


class Lesson(LessonBase):
    id: int
    unit_id: int

    class Config:
        orm_mode = True
