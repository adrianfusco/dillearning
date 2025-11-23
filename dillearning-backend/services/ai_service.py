import ollama
import prompts
from schemas.ai import (
    ExampleRequest,
    GenerateExerciseRequest,
    GrammarRequest,
    TranslateRequest,
)


class AIService:
    def __init__(self, model: str = "granite4:micro-h"):
        self.model = model

    async def _stream_ai_response(self, messages: list):
        stream = ollama.chat(
            model=self.model,
            messages=messages,
            stream=True,
        )
        for chunk in stream:
            yield chunk["message"]["content"]

    def get_chat_response(self, messages: list):
        return self._stream_ai_response(messages)

    def get_translation(self, request: TranslateRequest):
        user_content = (
            f"Translate the following text from {request.source_language} "
            f"to {request.target_language}: '{request.text}'"
        )
        messages = [
            {"role": "system", "content": prompts.TRANSLATE_PROMPT},
            {"role": "user", "content": user_content},
        ]
        return self._stream_ai_response(messages)

    def get_grammar_explanation(self, request: GrammarRequest):
        messages = [
            {"role": "system", "content": prompts.GRAMMAR_PROMPT},
            {"role": "user", "content": request.sentence},
        ]
        return self._stream_ai_response(messages)

    def get_examples(self, request: ExampleRequest):
        user_content = (
            f"Create examples for the word '{request.word}' " f"in {request.language}."
        )
        messages = [
            {"role": "system", "content": prompts.EXAMPLE_PROMPT},
            {"role": "user", "content": user_content},
        ]
        return self._stream_ai_response(messages)

    def generate_exercise(self, request: GenerateExerciseRequest):
        user_content = f"Genera un ejercicio para el concepto: '{request.concept}'"
        messages = [
            {"role": "system", "content": prompts.GENERATE_EXERCISE_PROMPT},
            {"role": "user", "content": user_content},
        ]
        return self._stream_ai_response(messages)


def get_ai_service():
    return AIService()
