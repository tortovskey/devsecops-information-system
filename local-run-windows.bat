@echo off
title DevSecOps Information System - Local Windows Run
echo.
echo Creating virtual environment through py launcher...
py -m venv .venv

if not exist ".venv\Scripts\python.exe" (
    echo Failed to create virtual environment.
    pause
    exit /b 1
)

echo.
echo Installing dependencies...
.venv\Scripts\python.exe -m pip install --upgrade pip
.venv\Scripts\python.exe -m pip install -r requirements.txt -r requirements-dev.txt

echo.
echo Applying SQLite migrations...
for /f %%i in ('.venv\Scripts\python.exe -c "import secrets; print(secrets.token_urlsafe(48))"') do set DJANGO_SECRET_KEY=%%i
set DJANGO_DEBUG=True
set DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1
.venv\Scripts\python.exe manage.py migrate

echo.
echo Starting local server...
echo http://localhost:8000/
.venv\Scripts\python.exe manage.py runserver 0.0.0.0:8000
pause
