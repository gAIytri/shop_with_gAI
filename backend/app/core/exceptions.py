from fastapi import Request, status
from fastapi.responses import JSONResponse


class AppException(Exception):  # noqa: N818
    def __init__(self, status_code: int, detail: str):
        self.status_code = status_code
        self.detail = detail


class NotFoundError(AppException):
    def __init__(self, resource: str, identifier: str | None = None):
        detail = f"{resource} not found"
        if identifier:
            detail = f"{resource} '{identifier}' not found"
        super().__init__(status_code=status.HTTP_404_NOT_FOUND, detail=detail)


class ConflictError(AppException):
    def __init__(self, detail: str):
        super().__init__(status_code=status.HTTP_409_CONFLICT, detail=detail)


class ValidationError(AppException):
    def __init__(self, detail: str):
        super().__init__(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail=detail)


class InsufficientStockError(AppException):
    def __init__(self, product_name: str):
        super().__init__(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"Insufficient stock for '{product_name}'",
        )


async def app_exception_handler(request: Request, exc: AppException) -> JSONResponse:
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.detail},
    )


async def generic_exception_handler(request: Request, exc: Exception) -> JSONResponse:
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={"detail": "Internal server error"},
    )
