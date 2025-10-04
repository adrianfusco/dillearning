from fastapi import APIRouter

router = APIRouter()


@router.get(
    "/health",
    summary="Check the health of the API",
    tags=["Health"],
)
async def health_check():
    return {"status": "ok"}
