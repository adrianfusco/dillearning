from typing import List

from auth import get_current_user
from crud import concept as concept_crud
from crud import course as course_crud
from crud import exercise as exercise_crud
from crud import unit as unit_crud
from database import get_db
from fastapi import APIRouter, Depends, HTTPException
from models.user import User
from schemas.concept import Concept
from schemas.course import Course
from schemas.exercise import Exercise
from schemas.unit import Unit
from sqlalchemy.orm import Session

router = APIRouter()


@router.get("/courses", response_model=List[Course])
def read_courses(db: Session = Depends(get_db)):
    return course_crud.get_courses(db)


@router.get("/courses/{course_id}", response_model=Course)
def read_course(course_id: int, db: Session = Depends(get_db)):
    db_course = course_crud.get_course(db, course_id=course_id)
    if db_course is None:
        raise HTTPException(status_code=404, detail="Course not found")
    return db_course


@router.get("/courses/{course_id}/units", response_model=List[Unit])
def read_units_for_course(course_id: int, db: Session = Depends(get_db)):
    db_course = course_crud.get_course(db, course_id=course_id)
    if db_course is None:
        raise HTTPException(status_code=404, detail="Course not found")
    return unit_crud.get_units_by_course(db, course_id=course_id)


@router.get("/units/{unit_id}", response_model=Unit)
def read_unit(unit_id: int, db: Session = Depends(get_db)):
    db_unit = unit_crud.get_unit(db, unit_id=unit_id)
    if db_unit is None:
        raise HTTPException(status_code=404, detail="Unit not found")
    return db_unit


@router.get("/units/{unit_id}/concepts", response_model=List[Concept])
def read_concepts_for_unit(unit_id: int, db: Session = Depends(get_db)):
    db_unit = unit_crud.get_unit(db, unit_id=unit_id)
    if db_unit is None:
        raise HTTPException(status_code=404, detail="Unit not found")
    return concept_crud.get_concepts_by_unit(db, unit_id=unit_id)


@router.get("/concepts/{concept_id}/exercises", response_model=List[Exercise])
def read_exercises_for_concept(concept_id: int, db: Session = Depends(get_db)):
    db_concept = concept_crud.get_concept(db, concept_id=concept_id)
    if db_concept is None:
        raise HTTPException(status_code=404, detail="Concept not found")
    return exercise_crud.get_exercises_by_concept(db, concept_id=concept_id)


@router.get("/exercises/{exercise_id}", response_model=Exercise)
def read_exercise(exercise_id: int, db: Session = Depends(get_db)):
    db_exercise = exercise_crud.get_exercise(db, exercise_id=exercise_id)
    if db_exercise is None:
        raise HTTPException(status_code=44, detail="Exercise not found")
    return db_exercise


@router.get("/courses/{course_id}/progress", response_model=float)
def get_course_progress(
    course_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    db_course = course_crud.get_course(db, course_id=course_id)
    if db_course is None:
        raise HTTPException(status_code=404, detail="Course not found")
    return course_crud.get_course_progress(db, current_user.id, course_id)


@router.get("/units/{unit_id}/access", response_model=bool)
def can_access_unit_api(
    unit_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return unit_crud.can_access_unit(db, current_user.id, unit_id)


@router.get("/units/{unit_id}/progress", response_model=List[int])
def get_unit_progress(
    unit_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return unit_crud.get_unit_progress(db, current_user.id, unit_id)


@router.post("/units/{unit_id}/complete", response_model=dict)
def complete_unit_api(
    unit_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    db_unit = unit_crud.get_unit(db, unit_id=unit_id)
    if db_unit is None:
        raise HTTPException(status_code=404, detail="Unit not found")
    unit_crud.complete_unit(db, current_user.id, unit_id)
    return {"message": "Unit marked as completed"}


@router.post("/exercises/{exercise_id}/complete", response_model=dict)
def complete_exercise_api(
    exercise_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    db_exercise = exercise_crud.get_exercise(db, exercise_id=exercise_id)
    if db_exercise is None:
        raise HTTPException(status_code=404, detail="Exercise not found")
    _, unit_completed = exercise_crud.complete_exercise(
        db, current_user.id, exercise_id
    )
    return {"message": "Exercise marked as completed", "unit_completed": unit_completed}
