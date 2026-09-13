#!/bin/sh
set -e

echo "Waiting for PostgreSQL..."

python <<'PY'
import os
import time
import psycopg

host = os.getenv("POSTGRES_HOST", "db")
port = os.getenv("POSTGRES_PORT", "5432")
dbname = os.getenv("POSTGRES_DB", "devsecops_db")
user = os.getenv("POSTGRES_USER", "devsecops_user")
password = os.environ["POSTGRES_PASSWORD"]

dsn = f"host={host} port={port} dbname={dbname} user={user} password={password}"

for attempt in range(60):
    try:
        with psycopg.connect(dsn, connect_timeout=3):
            print("PostgreSQL is ready.")
            break
    except Exception as exc:
        print(f"Database is not ready yet: {exc}")
        time.sleep(2)
else:
    raise SystemExit("PostgreSQL connection timeout.")
PY

echo "Applying migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput || true

echo "Creating demo superuser if needed..."
python manage.py shell <<'PY'
import os
from django.contrib.auth import get_user_model

User = get_user_model()

username = os.getenv("DJANGO_SUPERUSER_USERNAME", "admin")
email = os.getenv("DJANGO_SUPERUSER_EMAIL", "admin@example.com")
password = os.getenv("DJANGO_SUPERUSER_PASSWORD")

if not password:
    print("DJANGO_SUPERUSER_PASSWORD is not set; skipping superuser creation.")
elif not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username=username, email=email, password=password)
    print(f"Demo superuser created: {username}")
else:
    print("Demo superuser already exists.")
PY

echo "Starting application..."
exec "$@"
