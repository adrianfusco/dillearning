from typing import List

from crud import course as course_crud
from database import get_db
from fastapi import APIRouter, Depends
from schemas.course import Course
from sqlalchemy.orm import Session

router = APIRouter()


@router.get(
    "/available-languages",
    summary="Get the available languages to learn",
    tags=["Languages"],
    response_model=List[Course],
)
def get_available_languages(db: Session = Depends(get_db)):
    return course_crud.get_courses(db)
