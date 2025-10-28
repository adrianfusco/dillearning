from models.exercise import Exercise
from schemas.exercise import ExerciseCreate
from sqlalchemy.orm import Session


def get_exercise(db: Session, exercise_id: int):
    return db.query(Exercise).filter(Exercise.id == exercise_id).first()


def get_exercises_by_lesson(db: Session, lesson_id: int):
    return db.query(Exercise).filter(Exercise.lesson_id == lesson_id).all()


def create_exercise(db: Session, lesson_id: int, exercise: ExerciseCreate):
    db_exercise = Exercise(**exercise.dict(), lesson_id=lesson_id)
    db.add(db_exercise)
    db.commit()
    db.refresh(db_exercise)
    return db_exercise
