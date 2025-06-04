@echo off
echo Starting aiohttp web application...
echo Launching PowerShell script for better error handling...
echo.

REM Check if PowerShell script exists
if not exist "start.ps1" (
    echo Error: start.ps1 not found in current directory
    echo Please ensure all project files are present
    pause
    exit /b 1
)

REM Run PowerShell script with execution policy bypass
powershell -ExecutionPolicy Bypass -File start.ps1

REM If PowerShell fails, fallback to direct execution
if errorlevel 1 (
    echo.
    echo PowerShell execution failed, trying direct method...
    echo.
    
    REM Check Python installation
    python --version >nul 2>&1
    if errorlevel 1 (
        echo Error: Python is not installed or not in PATH
        echo Please install Python 3.11 or later from: https://www.python.org/downloads/
        pause
        exit /b 1
    )
    
    REM Install required packages
    echo Installing required packages...
    pip install aiohttp requests
    
    REM Run the application
    echo Starting server...
    python start.py
)

pause