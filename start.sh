#!/bin/bash

echo "Starting aiohttp web application with Poetry..."

# Check if poetry is installed, install if not found
if ! command -v poetry &> /dev/null; then
    echo "Poetry is not installed. Installing Poetry..."
    
    # Check if curl is available
    if command -v curl &> /dev/null; then
        echo "Installing Poetry using the official installer..."
        curl -sSL https://install.python-poetry.org | python3 -
        
        # Add Poetry to PATH
        export PATH="$HOME/.local/bin:$PATH"
        
        # Check if installation was successful
        if ! command -v poetry &> /dev/null; then
            echo "Error: Poetry installation failed via official installer."
            echo "Trying alternative method with pip..."
            
            # Install pip if not available
            if ! command -v pip3 &> /dev/null && ! command -v pip &> /dev/null; then
                echo "Installing pip..."
                if command -v apt-get &> /dev/null; then
                    sudo apt-get update && sudo apt-get install -y python3-pip
                elif command -v yum &> /dev/null; then
                    sudo yum install -y python3-pip
                elif command -v dnf &> /dev/null; then
                    sudo dnf install -y python3-pip
                elif command -v pacman &> /dev/null; then
                    sudo pacman -S python-pip
                else
                    echo "Error: Unable to install pip automatically."
                    echo "Please install pip manually for your distribution."
                    exit 1
                fi
            fi
            
            # Try installing Poetry with pip
            if command -v pip3 &> /dev/null; then
                pip3 install --user poetry
            elif command -v pip &> /dev/null; then
                pip install --user poetry
            fi
            
            export PATH="$HOME/.local/bin:$PATH"
            
            if ! command -v poetry &> /dev/null; then
                echo "Error: Failed to install Poetry. Please install it manually:"
                echo "  curl -sSL https://install.python-poetry.org | python3 -"
                echo "  Or visit: https://python-poetry.org/docs/#installation"
                exit 1
            fi
        fi
        
        echo "Poetry installed successfully!"
    else
        echo "Error: curl is not available. Please install curl first:"
        echo "  Ubuntu/Debian: sudo apt-get install curl"
        echo "  CentOS/RHEL: sudo yum install curl"
        echo "  Fedora: sudo dnf install curl"
        exit 1
    fi
fi

# Always add Poetry to PATH
export PATH="$HOME/.local/bin:$PATH"

# Check if Python is available
PYTHON_CMD=""
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo "Error: No Python interpreter found. Please install Python 3."
    exit 1
fi

echo "Using Python: $PYTHON_CMD"

# Install dependencies using Poetry
echo "Installing dependencies with Poetry..."
poetry install

if [ $? -ne 0 ]; then
    echo "Error: Failed to install dependencies with Poetry"
    exit 1
fi

echo "Starting server on http://localhost:8080"
echo "Press Ctrl+C to stop the server"

# Run the application using Poetry
poetry run python start.py