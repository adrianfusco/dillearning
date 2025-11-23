import prompts
from crud import conversation as crud_conversation
from database import get_db
from fastapi import APIRouter, Depends
from fastapi.responses import StreamingResponse
from schemas.ai import (
    ChatRequest,
    ExampleRequest,
    GenerateExerciseRequest,
    GrammarRequest,
    TranslateRequest,
)
from schemas.conversation import ConversationCreate
from services.ai_service import AIService, get_ai_service
from sqlalchemy.orm import Session

router = APIRouter()


@router.post(
    "/ai/chat",
    summary="Chat with the AI Language Teacher",
    tags=["AI"],
)
async def chat(
    request: ChatRequest,
    db: Session = Depends(get_db),
    ai_service: AIService = Depends(get_ai_service),
):
    history = crud_conversation.get_conversation_history(db, request.user_id)

    messages = [{"role": "system", "content": prompts.CHAT_PROMPT}]
    for message in history:
        messages.append({"role": message.role, "content": message.content})

    messages.append({"role": "user", "content": request.question})

    crud_conversation.create_conversation_message(
        db,
        ConversationCreate(
            user_id=request.user_id, role="user", content=request.question
        ),
    )

    async def _stream_and_save_response():
        full_response = ""
        async for chunk in ai_service.get_chat_response(messages):
            full_response += chunk
            yield chunk

        crud_conversation.create_conversation_message(
            db,
            ConversationCreate(
                user_id=request.user_id, role="assistant", content=full_response
            ),
        )

    return StreamingResponse(
        _stream_and_save_response(), media_type="text/event-stream"
    )


@router.post(
    "/ai/translate",
    summary="Translate text between languages",
    tags=["AI"],
)
async def translate(
    request: TranslateRequest, ai_service: AIService = Depends(get_ai_service)
):
    """
    Translates a piece of text from a source language to a target language using AI.
    """
    return StreamingResponse(
        ai_service.get_translation(request), media_type="text/event-stream"
    )


@router.post(
    "/ai/explain-grammar",
    summary="Explain the grammar of a sentence",
    tags=["AI"],
)
async def explain_grammar(
    request: GrammarRequest, ai_service: AIService = Depends(get_ai_service)
):
    """
    Provides a grammatical explanation of a sentence or word using AI.
    """
    return StreamingResponse(
        ai_service.get_grammar_explanation(request), media_type="text/event-stream"
    )


@router.post(
    "/ai/create-examples",
    summary="Create example sentences for a word",
    tags=["AI"],
)
async def create_examples(
    request: ExampleRequest, ai_service: AIService = Depends(get_ai_service)
):
    """
    Generates example sentences for a word or sentence using AI.
    """
    return StreamingResponse(
        ai_service.get_examples(request), media_type="text/event-stream"
    )


@router.post(
    "/ai/generate-exercise",
    summary="Generate an exercise for a concept",
    tags=["AI"],
)
async def generate_exercise(
    request: GenerateExerciseRequest, ai_service: AIService = Depends(get_ai_service)
):
    """
    Generates an exercise for a given concept using AI.
    """
    return StreamingResponse(
        ai_service.generate_exercise(request), media_type="application/json"
    )
