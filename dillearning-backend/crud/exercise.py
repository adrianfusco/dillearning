from models.concept import Concept
from models.exercise import Exercise
from models.user_exercise_progress import UserExerciseProgress
from schemas.exercise import ExerciseCreate
from sqlalchemy.orm import Session

from . import unit as unit_crud


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


def complete_exercise(db: Session, user_id: int, exercise_id: int):
    progress = (
        db.query(UserExerciseProgress)
        .filter_by(user_id=user_id, exercise_id=exercise_id)
        .first()
    )

    if not progress:
        progress = UserExerciseProgress(
            user_id=user_id, exercise_id=exercise_id, completed=True
        )
        db.add(progress)
    else:
        progress.completed = True

    db.commit()

    unit_completed = False

    exercise = get_exercise(db, exercise_id)
    unit_id = (
        db.query(Concept.unit_id).filter(Concept.id == exercise.concept_id).scalar()
    )

    all_exercises_in_unit = (
        db.query(Exercise).join(Concept).filter(Concept.unit_id == unit_id).all()
    )

    completed_exercises_in_unit = (
        db.query(UserExerciseProgress)
        .join(Exercise)
        .join(Concept)
        .filter(
            Concept.unit_id == unit_id,
            UserExerciseProgress.user_id == user_id,
            UserExerciseProgress.completed,
        )
        .count()
    )

    if len(all_exercises_in_unit) == completed_exercises_in_unit:
        unit_crud.complete_unit(db, user_id, unit_id)
        unit_completed = True

    return progress, unit_completed
