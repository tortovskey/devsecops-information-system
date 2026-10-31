# DevSecOps Information System

An educational Django and PostgreSQL project demonstrating security practices
throughout the design, development, and operation of an information system.

The application runs through Docker Compose on Windows. Python runs inside the
container, so a local Python installation is not required.

## Quick start

1. Clone the repository and open the project directory.
2. Create a local `.env` file from the example and replace the passwords:

```bash
cp .env.example .env
```

On Windows, use `copy .env.example .env`.

3. Start the application:

```bat
start-docker.bat
```

Or use Docker Compose directly:

```bash
docker compose up --build
```

| Endpoint | Address |
|---|---|
| Application | http://localhost:8000/ |
| Health check | http://localhost:8000/health/ |
| Admin interface | http://localhost:8000/admin/ |

A demo administrator is created at startup only when `DJANGO_SUPERUSER_PASSWORD`
is set in `.env`. Account credentials are not stored in the repository.

## Resolve an old container-name conflict

Explicit `container_name` values have been removed from `docker-compose.yml`.
If a `devsecops_db` container from an older version still causes a conflict, run:

```bat
clean-old-containers.bat
start-docker.bat
```

## Stop the application

```bash
docker compose down
```

To remove volumes and reset the database as well:

```bash
docker compose down -v --remove-orphans
```

## Included features

- A Django web application with PostgreSQL in Docker.
- Automatic database migrations at startup.
- Optional demo administrator creation.
- A health-check endpoint.
- Security middleware and security-oriented Django settings.
- A GitHub Actions DevSecOps pipeline.
- Bandit, pip-audit, Gitleaks, Trivy, and OWASP ZAP checks.
