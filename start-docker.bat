@echo off
REM Fitness Tracker Docker Startup Script for Windows

echo Starting Fitness Tracker Application with Docker Compose...

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Docker is not running. Please start Docker Desktop and try again.
    pause
    exit /b 1
)

REM Check if Docker Compose is available
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Docker Compose is not installed or not in PATH.
    pause
    exit /b 1
)

REM Stop any existing containers
echo Stopping any existing containers...
docker-compose down

REM Remove any existing images to force rebuild
echo Removing existing images...
docker-compose down --rmi all

REM Build and start the services
echo Building and starting services...
docker-compose up --build -d

REM Wait for services to be ready
echo Waiting for services to be ready...
timeout /t 30 /nobreak >nul

REM Check service status
echo Checking service status...
docker-compose ps

REM Display access information
echo.
echo ==========================================
echo Fitness Tracker Application is running!
echo ==========================================
echo Frontend: http://localhost:3000
echo Backend API: http://localhost:8081
echo MySQL: localhost:3306
echo.
echo To view logs: docker-compose logs -f
echo To stop: docker-compose down
echo ==========================================
pause
