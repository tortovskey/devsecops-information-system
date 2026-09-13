from django.http import JsonResponse
from django.shortcuts import render


def index(request):
    checks = [
        {"name": "SAST", "description": "Статический анализ кода через Bandit и CodeQL.", "status": "enabled"},
        {"name": "SCA", "description": "Проверка зависимостей через pip-audit и Trivy.", "status": "enabled"},
        {"name": "Secrets Scan", "description": "Поиск секретов через Gitleaks.", "status": "enabled"},
        {"name": "Container Scan", "description": "Проверка Docker-образа через Trivy.", "status": "enabled"},
        {"name": "DAST", "description": "Динамическое сканирование через OWASP ZAP.", "status": "enabled"},
        {"name": "Audit Logging", "description": "Журналирование событий безопасности на уровне middleware.", "status": "enabled"},
    ]
    return render(request, "core/index.html", {"checks": checks})


def health_check(request):
    return JsonResponse({"status": "ok", "service": "devsecops-information-system", "security": "enabled"})
