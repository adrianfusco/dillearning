import ollama
import schemas
from fastapi import APIRouter
from fastapi.responses import StreamingResponse

CHAT_PROMPT = """
Eres una IA experta en la enseñanza de idiomas llamada 'Dil'.
Eres amigable, paciente y tienes conocimientos en muchos idiomas,
especialmente en inglés y español.
Tu objetivo principal es ayudar a los usuarios a aprender nuevos
idiomas de manera efectiva. Mantén un tono alentador y de apoyo.
"""

TRANSLATE_PROMPT = """
Eres un traductor experto. Tu única tarea es traducir el texto proporcionado
del idioma de origen al idioma de destino. No añadas explicaciones, comentarios
o disculpas adicionales. Proporciona únicamente la traducción directa.
"""

GRAMMAR_PROMPT = """
Eres un experto en lingüística llamado. Tu tarea es explicar la estructura gramatical de
la oración proporcionada. Descomponla en sus componentes (sujeto, verbo,
objeto, cláusulas, tiempo, modo, ...). Proporciona una explicación clara y concisa
adecuada para un estudiante de idiomas.
"""

EXAMPLE_PROMPT = """
Eres un profesor de idiomas. Tu tarea es generar varios ejemplos distintos
y prácticas para la palabra o frase dada en el idioma especificado. Para cada
ejemplo, proporciona también una traducción si se solicita. Formatea la salida
de forma clara.
"""

router = APIRouter()


async def _stream_ai_response(messages: list):
    stream = ollama.chat(
        model="granite3.3:2b",
        messages=messages,
        stream=True,
    )
    for chunk in stream:
        yield chunk["message"]["content"]


@router.post(
    "/ai/chat",
    summary="Chat with the AI Language Teacher",
    tags=["AI"],
)
async def chat(request: schemas.ChatRequest):
    """
    Endpoint to receive an user question and return a response from the
    language teacher AI.
    """
    question = request.question

    messages = [
        {"role": "system", "content": CHAT_PROMPT},
        {"role": "user", "content": question},
    ]
    return StreamingResponse(
        _stream_ai_response(messages), media_type="text/event-stream"
    )


@router.post(
    "/ai/translate",
    summary="Translate text between languages",
    tags=["AI"],
)
async def translate(request: schemas.TranslateRequest):
    """
    Translates a piece of text from a source language to a target language using AI.
    """
    source_language = request.source_language
    target_language = request.target_language
    text = request.text

    user_content = (
        f"Translate the following text from {source_language} "
        f"to {target_language}: '{text}'"
    )
    messages = [
        {"role": "system", "content": TRANSLATE_PROMPT},
        {"role": "user", "content": user_content},
    ]
    return StreamingResponse(
        _stream_ai_response(messages), media_type="text/event-stream"
    )


@router.post(
    "/ai/explain-grammar",
    summary="Explain the grammar of a sentence",
    tags=["AI"],
)
async def explain_grammar(request: schemas.GrammarRequest):
    """
    Provides a grammatical explanation of a sentence or word using AI.
    """
    sentence = request.sentence

    messages = [
        {"role": "system", "content": GRAMMAR_PROMPT},
        {"role": "user", "content": sentence},
    ]
    return StreamingResponse(
        _stream_ai_response(messages), media_type="text/event-stream"
    )


@router.post(
    "/ai/create-examples",
    summary="Create example sentences for a word",
    tags=["AI"],
)
async def create_examples(request: schemas.ExampleRequest):
    """
    Generates example sentences for a word or sentence using AI.
    """
    word = request.word
    language = request.language

    user_content = f"Create examples for the word '{word}' in {language}."
    messages = [
        {"role": "system", "content": EXAMPLE_PROMPT},
        {"role": "user", "content": user_content},
    ]
    return StreamingResponse(
        _stream_ai_response(messages), media_type="text/event-stream"
    )
