from models.concept import Concept
from sqlalchemy.orm import Session


def get_concept(db: Session, concept_id: int):
    return db.query(Concept).filter(Concept.id == concept_id).first()


def get_concepts_by_unit(db: Session, unit_id: int):
    return db.query(Concept).filter(Concept.unit_id == unit_id).all()
