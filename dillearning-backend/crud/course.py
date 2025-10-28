from models.course import Course
from schemas.course import CourseCreate
from sqlalchemy.orm import Session


def get_courses(db: Session):
    return db.query(Course).all()


def get_course(db: Session, course_id: int):
    return db.query(Course).filter(Course.id == course_id).first()


def get_course_by_code(db: Session, code: str):
    return db.query(Course).filter(Course.code == code).first()


def create_course(db: Session, course: CourseCreate):
    db_course = Course(
        code=course.code,
        title=course.title,
        description=course.description,
        source_language_id=course.source_language_id,
        target_language_id=course.target_language_id,
    )
    db.add(db_course)
    db.commit()
    db.refresh(db_course)
    return db_course
