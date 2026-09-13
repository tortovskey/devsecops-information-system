@echo off
title DevSecOps Information System - Clean Old Containers
echo.
echo Removing old containers from previous broken versions...
docker rm -f devsecops_db devsecops_web 2>nul

echo.
echo Removing current compose stack and volumes...
docker compose down -v --remove-orphans

echo.
echo Docker containers with devsecops in name:
docker ps -a --filter "name=devsecops"

echo.
echo Done. Now run start-docker.bat
pause
