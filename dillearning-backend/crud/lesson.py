from models.lesson import Lesson
from schemas.lesson import LessonCreate
from sqlalchemy.orm import Session, joinedload


def get_lesson(db: Session, lesson_id: int):
    return (
        db.query(Lesson)
        .options(joinedload(Lesson.exercises))
        .filter(Lesson.id == lesson_id)
        .first()
    )


def get_lessons_by_unit(db: Session, unit_id: int):
    return (
        db.query(Lesson)
        .options(joinedload(Lesson.exercises))
        .filter(Lesson.unit_id == unit_id)
        .all()
    )


def create_lesson(db: Session, unit_id: int, lesson: LessonCreate):
    db_lesson = Lesson(**lesson.dict(), unit_id=unit_id)
    db.add(db_lesson)
    db.commit()
    db.refresh(db_lesson)
    return db_lesson
