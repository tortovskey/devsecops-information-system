# DevSecOps Information System

Учебный проект для темы:

**«Внедрение DevSecOps-практик в жизненный цикл проектирования и эксплуатации информационной системы»**

Проект запускается через Docker Compose на Windows. Локальный `python` не нужен.
Если на Windows установлен только `py`, это нормально: Docker использует Python внутри контейнера.

## Быстрый запуск

1. Клонируй репозиторий и открой папку проекта.
2. Создай локальный `.env` из примера и замени пароли:

```bash
cp .env.example .env
```

На Windows: `copy .env.example .env`.

3. Запусти:

```bat
start-docker.bat
```

Или вручную:

```bash
docker compose up --build
```

Сайт:

```text
http://localhost:8000/
```

Health-check:

```text
http://localhost:8000/health/
```

Админка:

```text
http://localhost:8000/admin/
```

Демо-администратор создаётся при старте только если в `.env` задан `DJANGO_SUPERUSER_PASSWORD`. Логин и пароль не хранятся в репозитории.

## Если Docker пишет conflict про devsecops_db

В этой версии конфликта уже быть не должно, потому что из `docker-compose.yml` убраны жёсткие `container_name`.
Но если старый контейнер остался от прошлой версии, запусти:

```bat
clean-old-containers.bat
```

И потом снова:

```bat
start-docker.bat
```

## Остановка

```bash
docker compose down
```

Полная очистка базы:

```bash
docker compose down -v --remove-orphans
```

## Что реализовано

- Django веб-приложение.
- PostgreSQL в Docker.
- Автоматические миграции при запуске.
- Автоматическое создание demo-admin.
- Health-check endpoint.
- Security middleware.
- Безопасные настройки Django.
- DevSecOps pipeline для GitHub Actions.
- Bandit, pip-audit, Gitleaks, Trivy, OWASP ZAP.
