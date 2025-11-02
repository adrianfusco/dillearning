from models.concept import Concept
from models.lesson import Lesson
from models.unit import Unit
from schemas.unit import UnitCreate
from sqlalchemy.orm import Session, joinedload


def get_unit(db: Session, unit_id: int):
    return (
        db.query(Unit)
        .options(
            joinedload(Unit.lessons)
            .joinedload(Lesson.concepts)
            .joinedload(Concept.exercises)
        )
        .filter(Unit.id == unit_id)
        .first()
    )


def get_units_by_course(db: Session, course_id: int):
    return (
        db.query(Unit)
        .options(
            joinedload(Unit.lessons)
            .joinedload(Lesson.concepts)
            .joinedload(Concept.exercises)
        )
        .filter(Unit.course_id == course_id)
        .all()
    )


def create_unit(db: Session, course_id: int, unit: UnitCreate):
    db_unit = Unit(**unit.dict(), course_id=course_id)
    db.add(db_unit)
    db.commit()
    db.refresh(db_unit)
    return db_unit
