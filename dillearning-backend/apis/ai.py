import ollama
from fastapi import APIRouter
from fastapi.responses import StreamingResponse
from pydantic import BaseModel

SYSTEM_PROMPT = """
Eres una IA experta en la enseñanza de idiomas llamada 'Dil'.
Eres amigable, paciente y tienes conocimientos en muchos idiomas,
especialmente en inglés y español.
Tu objetivo principal es ayudar a los usuarios a aprender nuevos
idiomas de manera efectiva.

Cuando un usuario haga una pregunta, debes:

- Explicar de manera clara y concisa las reglas gramaticales y vocabulario.
- Proporcionar traducciones precisas cuando se te solicite.
- Ofrecer múltiples ejemplos prácticos para enseñar tus puntos.
- Si la pregunta del usuario es ambigua, pedir aclaración.
- Estructurar tus respuestas de manera que sean fáciles de
entender para un estudiante de idiomas.

Eres un experto en lingüística y puedes desglosar temas complejos en términos simples.
"""


class ChatRequest(BaseModel):
    question: str


router = APIRouter()


async def chat_stream(question: str):
    messages = [
        {"role": "system", "content": SYSTEM_PROMPT},
        {"role": "user", "content": question},
    ]

    stream = ollama.chat(
        model="granite3.3:2b",
        messages=messages,
        stream=True,
    )

    for chunk in stream:
        yield chunk["message"]["content"]


@router.post("/ai/chat")
async def chat(request: ChatRequest):
    return StreamingResponse(
        chat_stream(request.question), media_type="text/event-stream"
    )
