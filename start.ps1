# Aiohttp + React Web Application Starter (PowerShell)
Write-Host "Starting aiohttp web application..." -ForegroundColor Green
Write-Host ""

# Check Python installation
Write-Host "Checking Python installation..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host "Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Python is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Python 3.11 or later from: https://www.python.org/downloads/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Check if pip is available
Write-Host "Checking pip installation..." -ForegroundColor Yellow
try {
    $pipVersion = pip --version 2>&1
    Write-Host "Pip found: $pipVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: pip is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please ensure pip is installed with Python" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Install required packages
Write-Host "Installing required packages..." -ForegroundColor Yellow
try {
    pip install aiohttp requests 2>&1 | Out-Null
    Write-Host "Required packages installed successfully" -ForegroundColor Green
} catch {
    Write-Host "Error: Failed to install required packages" -ForegroundColor Red
    Write-Host "Please check your internet connection and try again" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Check if start.py exists
if (-not (Test-Path "start.py")) {
    Write-Host "Error: start.py not found in current directory" -ForegroundColor Red
    Write-Host "Please run this script from the project directory" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Starting server on http://localhost:8080" -ForegroundColor Green
Write-Host "React app available at: http://localhost:8080" -ForegroundColor Cyan
Write-Host "API endpoint at: http://localhost:8080/api/hello" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Run the application
try {
    python start.py
} catch {
    Write-Host "Error occurred while running the application" -ForegroundColor Red
}

Write-Host ""
Write-Host "Application stopped." -ForegroundColor Yellow
Read-Host "Press Enter to exit"