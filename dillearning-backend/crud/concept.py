from models.concept import Concept
from sqlalchemy.orm import Session


def get_concept(db: Session, concept_id: int):
    return db.query(Concept).filter(Concept.id == concept_id).first()


def get_concepts_by_lesson(db: Session, lesson_id: int):
    return db.query(Concept).filter(Concept.lesson_id == lesson_id).all()
