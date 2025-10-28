from typing import List

from crud import course as course_crud
from crud import exercise as exercise_crud
from crud import lesson as lesson_crud
from crud import unit as unit_crud
from database import get_db
from fastapi import APIRouter, Depends, HTTPException
from schemas.course import Course, CourseCreate
from schemas.exercise import Exercise, ExerciseCreate
from schemas.lesson import Lesson, LessonCreate
from schemas.unit import Unit, UnitCreate
from sqlalchemy.orm import Session

router = APIRouter()


@router.get("/courses", response_model=List[Course])
def read_courses(db: Session = Depends(get_db)):
    return course_crud.get_courses(db)


@router.post("/courses", response_model=Course)
def create_course(course: CourseCreate, db: Session = Depends(get_db)):
    db_course = course_crud.get_course_by_code(db, code=course.code)
    if db_course:
        raise HTTPException(
            status_code=400, detail="Course with this code already exists"
        )
    return course_crud.create_course(db=db, course=course)


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


@router.post("/courses/{course_id}/units", response_model=Unit)
def create_unit_for_course(
    course_id: int, unit: UnitCreate, db: Session = Depends(get_db)
):
    db_course = course_crud.get_course(db, course_id=course_id)
    if db_course is None:
        raise HTTPException(status_code=404, detail="Course not found")
    return unit_crud.create_unit(db=db, course_id=course_id, unit=unit)


@router.get("/units/{unit_id}", response_model=Unit)
def read_unit(unit_id: int, db: Session = Depends(get_db)):
    db_unit = unit_crud.get_unit(db, unit_id=unit_id)
    if db_unit is None:
        raise HTTPException(status_code=404, detail="Unit not found")
    return db_unit


@router.get("/units/{unit_id}/lessons", response_model=List[Lesson])
def read_lessons_for_unit(unit_id: int, db: Session = Depends(get_db)):
    db_unit = unit_crud.get_unit(db, unit_id=unit_id)
    if db_unit is None:
        raise HTTPException(status_code=404, detail="Unit not found")
    return lesson_crud.get_lessons_by_unit(db, unit_id=unit_id)


@router.post("/units/{unit_id}/lessons", response_model=Lesson)
def create_lesson_for_unit(
    unit_id: int, lesson: LessonCreate, db: Session = Depends(get_db)
):
    db_unit = unit_crud.get_unit(db, unit_id=unit_id)
    if db_unit is None:
        raise HTTPException(status_code=404, detail="Unit not found")
    return lesson_crud.create_lesson(db=db, unit_id=unit_id, lesson=lesson)


@router.get("/lessons/{lesson_id}", response_model=Lesson)
def read_lesson(lesson_id: int, db: Session = Depends(get_db)):
    db_lesson = lesson_crud.get_lesson(db, lesson_id=lesson_id)
    if db_lesson is None:
        raise HTTPException(status_code=404, detail="Lesson not found")
    return db_lesson


@router.get("/lessons/{lesson_id}/exercises", response_model=List[Exercise])
def read_exercises_for_lesson(lesson_id: int, db: Session = Depends(get_db)):
    db_lesson = lesson_crud.get_lesson(db, lesson_id=lesson_id)
    if db_lesson is None:
        raise HTTPException(status_code=404, detail="Lesson not found")
    return exercise_crud.get_exercises_by_lesson(db, lesson_id=lesson_id)


@router.post("/lessons/{lesson_id}/exercises", response_model=Exercise)
def create_exercise_for_lesson(
    lesson_id: int, exercise: ExerciseCreate, db: Session = Depends(get_db)
):
    db_lesson = lesson_crud.get_lesson(db, lesson_id=lesson_id)
    if db_lesson is None:
        raise HTTPException(status_code=404, detail="Lesson not found")
    return exercise_crud.create_exercise(db=db, lesson_id=lesson_id, exercise=exercise)


@router.get("/exercises/{exercise_id}", response_model=Exercise)
def read_exercise(exercise_id: int, db: Session = Depends(get_db)):
    db_exercise = exercise_crud.get_exercise(db, exercise_id=exercise_id)
    if db_exercise is None:
        raise HTTPException(status_code=404, detail="Exercise not found")
    return db_exercise
