@echo off
echo Starting aiohttp web application with Poetry...

REM Check if poetry is installed
poetry --version >nul 2>&1
if errorlevel 1 (
    echo Poetry is not installed. Installing Poetry...
    
    REM Install Poetry using pip
    pip install poetry
    if errorlevel 1 (
        echo Error: Failed to install Poetry. Please install it manually:
        echo   pip install poetry
        echo   Or visit: https://python-poetry.org/docs/#installation
        pause
        exit /b 1
    )
    
    echo Poetry installed successfully!
)

REM Install dependencies
echo Installing dependencies with Poetry...
poetry install
if errorlevel 1 (
    echo Error: Failed to install dependencies with Poetry
    pause
    exit /b 1
)

echo Starting server on http://localhost:8080
echo Press Ctrl+C to stop the server

REM Run the application
poetry run python start.py
pause