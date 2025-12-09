from models.concept import Concept
from models.exercise import Exercise
from models.unit import Unit
from models.user_exercise_progress import UserExerciseProgress
from models.user_unit_progress import UserUnitProgress
from schemas.unit import UnitCreate
from sqlalchemy.orm import Session, joinedload


def get_unit(db: Session, unit_id: int):
    return (
        db.query(Unit)
        .options(joinedload(Unit.concepts).joinedload(Concept.exercises))
        .filter(Unit.id == unit_id)
        .first()
    )


def get_units_by_course(db: Session, course_id: int):
    return (
        db.query(Unit)
        .options(joinedload(Unit.concepts).joinedload(Concept.exercises))
        .filter(Unit.course_id == course_id)
        .all()
    )


def create_unit(db: Session, course_id: int, unit: UnitCreate):
    db_unit = Unit(**unit.dict(), course_id=course_id)
    db.add(db_unit)
    db.commit()
    db.refresh(db_unit)
    return db_unit


def can_access_unit(db, user_id: int, unit_id: int) -> bool:
    unit = db.query(Unit).filter(Unit.id == unit_id).first()
    if not unit:
        return False

    # Siempre estará desbloqueada la primeraa unidad
    if unit.order == 1:
        return True

    previous_unit = (
        db.query(Unit)
        .filter(Unit.course_id == unit.course_id, Unit.order == unit.order - 1)
        .first()
    )

    if not previous_unit:
        return True

    previous_progress = (
        db.query(UserUnitProgress)
        .filter_by(user_id=user_id, unit_id=previous_unit.id, completed=True)
        .first()
    )

    return previous_progress is not None


def complete_unit(db, user_id: int, unit_id: int):
    progress = (
        db.query(UserUnitProgress).filter_by(user_id=user_id, unit_id=unit_id).first()
    )

    if not progress:
        progress = UserUnitProgress(user_id=user_id, unit_id=unit_id, completed=True)
        db.add(progress)
    else:
        progress.completed = True

    db.commit()
    return progress


def get_unit_progress(db: Session, user_id: int, unit_id: int) -> list[int]:
    """
    Get the completed exercise IDs for a user in a specific unit.
    """
    unit = get_unit(db, unit_id)
    if not unit:
        return []

    concept_ids = [concept.id for concept in unit.concepts]
    exercise_ids = (
        db.query(Exercise.id).filter(Exercise.concept_id.in_(concept_ids)).subquery()
    )

    completed_exercises = (
        db.query(UserExerciseProgress.exercise_id)
        .filter(
            UserExerciseProgress.user_id == user_id,
            UserExerciseProgress.exercise_id.in_(exercise_ids),
        )
        .all()
    )

    return [exercise_id for exercise_id, in completed_exercises]
