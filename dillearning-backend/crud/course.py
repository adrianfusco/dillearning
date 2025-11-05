from models.concept import Concept
from models.course import Course
from models.unit import Unit
from schemas.course import CourseCreate
from sqlalchemy.orm import Session, joinedload


def get_courses(db: Session):
    return (
        db.query(Course)
        .options(
            joinedload(Course.units)
            .joinedload(Unit.concepts)
            .joinedload(Concept.exercises)
        )
        .all()
    )


def get_course(db: Session, course_id: int):
    return (
        db.query(Course)
        .options(
            joinedload(Course.units)
            .joinedload(Unit.concepts)
            .joinedload(Concept.exercises)
        )
        .filter(Course.id == course_id)
        .first()
    )


def get_course_by_code(db: Session, code: str):
    return db.query(Course).filter(Course.code == code).first()


def create_course(db: Session, course: CourseCreate):
    db_course = Course(
        code=course.code,
        title=course.title,
        description=course.description,
        from_language_id=course.from_language_id,
        learning_language_id=course.learning_language_id,
    )
    db.add(db_course)
    db.commit()
    db.refresh(db_course)
    return db_course
