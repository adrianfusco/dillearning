from pydantic import BaseModel


class TranslateRequest(BaseModel):
    text: str
    source_language: str
    target_language: str


class GrammarRequest(BaseModel):
    sentence: str


class ExampleRequest(BaseModel):
    word: str
    language: str


class ChatRequest(BaseModel):
    question: str
    user_id: int


class GenerateExerciseRequest(BaseModel):
    concept: str
