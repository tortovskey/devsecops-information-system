@echo off
title DevSecOps Information System - Docker Start
echo.
echo Cleaning old broken containers from previous versions if they exist...
docker rm -f devsecops_db devsecops_web 2>nul

echo.
echo Starting DevSecOps Information System through Docker...
echo.
echo Site:
echo http://localhost:8000/
echo.
echo Health-check:
echo http://localhost:8000/health/
echo.
docker compose up --build
pause
