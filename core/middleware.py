import logging
import time
from collections.abc import Callable
from django.http import HttpRequest, HttpResponse

security_logger = logging.getLogger("security")

class SecurityAuditMiddleware:
    def __init__(self, get_response: Callable[[HttpRequest], HttpResponse]):
        self.get_response = get_response

    def __call__(self, request: HttpRequest) -> HttpResponse:
        started_at = time.time()
        response = self.get_response(request)
        duration = round(time.time() - started_at, 4)
        security_logger.info(
            "ip=%s method=%s path=%s status=%s duration=%s user=%s",
            self._get_client_ip(request),
            request.method,
            request.path,
            response.status_code,
            duration,
            request.user.username if request.user.is_authenticated else "anonymous",
        )
        return response

    @staticmethod
    def _get_client_ip(request: HttpRequest) -> str:
        forwarded_for = request.META.get("HTTP_X_FORWARDED_FOR")
        if forwarded_for:
            return forwarded_for.split(",")[0].strip()
        return request.META.get("REMOTE_ADDR", "unknown")
