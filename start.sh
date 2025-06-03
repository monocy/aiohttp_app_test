#!/bin/bash

echo "Starting aiohttp web application..."

# Check if pipenv is installed
if ! command -v pipenv &> /dev/null; then
    echo "Error: pipenv is not installed. Please install pipenv first:"
    echo "  pip install pipenv"
    exit 1
fi

# Check if Python 3.11 is available
if ! command -v python3.11 &> /dev/null && ! command -v python3 &> /dev/null; then
    echo "Error: Python 3.11 or Python 3 is not installed. Please install Python 3.11 first."
    exit 1
fi

# Install dependencies if Pipfile.lock doesn't exist or if virtual environment doesn't exist
if [ ! -f "Pipfile.lock" ] || ! pipenv --venv &> /dev/null; then
    echo "Installing dependencies..."
    pipenv install
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install dependencies"
        exit 1
    fi
fi

echo "Starting server on http://localhost:8080"
echo "Press Ctrl+C to stop the server"

# Run the application
pipenv run python start.py