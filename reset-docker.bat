@echo off
title DevSecOps Information System - Docker Reset
echo.
echo Stopping containers and removing database volume...
docker compose down -v --remove-orphans
docker rm -f devsecops_db devsecops_web 2>nul
echo.
echo Done.
pause
