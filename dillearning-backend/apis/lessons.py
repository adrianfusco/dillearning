from fastapi import APIRouter

router = APIRouter()


@router.get(
    "/available-languages",
    summary="Get the available languages to learn",
    tags=["Lessons"],
)
async def get_available_languages():
    return {
        "available_languages": [
            {"code": "es-en", "name": "Inglés desde Español"},
            {"code": "en-es", "name": "Spanish from English"},
        ]
    }
