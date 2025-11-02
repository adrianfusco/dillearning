from models.exercise import Exercise
from schemas.exercise import ExerciseCreate
from sqlalchemy.orm import Session


def get_exercise(db: Session, exercise_id: int):
    return db.query(Exercise).filter(Exercise.id == exercise_id).first()


def get_exercises_by_concept(db: Session, concept_id: int):
    return db.query(Exercise).filter(Exercise.concept_id == concept_id).all()


def create_exercise(db: Session, concept_id: int, exercise: ExerciseCreate):
    db_exercise = Exercise(**exercise.dict(), concept_id=concept_id)
    db.add(db_exercise)
    db.commit()
    db.refresh(db_exercise)
    return db_exercise
