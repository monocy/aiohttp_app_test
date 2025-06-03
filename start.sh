#!/bin/bash

echo "Starting aiohttp web application..."

# Check if pipenv is installed, install if not found
if ! command -v pipenv &> /dev/null; then
    echo "pipenv is not installed. Installing pipenv..."
    
    # Try different methods to install pipenv
    if command -v pip3 &> /dev/null; then
        pip3 install --user pipenv
    elif command -v pip &> /dev/null; then
        pip install --user pipenv
    else
        echo "Error: Neither pip nor pip3 is available. Please install pip first."
        exit 1
    fi
    
    # Add user bin to PATH if pipenv is still not found
    if ! command -v pipenv &> /dev/null; then
        export PATH="$HOME/.local/bin:$PATH"
        if ! command -v pipenv &> /dev/null; then
            echo "Error: Failed to install pipenv. Please install it manually:"
            echo "  pip install --user pipenv"
            echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
            exit 1
        fi
    fi
    
    echo "pipenv installed successfully!"
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