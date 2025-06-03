#!/bin/bash

echo "Starting aiohttp web application..."

# Check if pipenv is installed, install if not found
if ! command -v pipenv &> /dev/null; then
    echo "pipenv is not installed. Installing pipenv..."
    
    # Check if pip is available, install if not
    if ! command -v pip3 &> /dev/null && ! command -v pip &> /dev/null; then
        echo "pip is not installed. Installing pip..."
        
        # Try to install pip using package manager
        if command -v apt-get &> /dev/null; then
            echo "Installing python3-pip using apt-get..."
            sudo apt-get update && sudo apt-get install -y python3-pip
        elif command -v yum &> /dev/null; then
            echo "Installing python3-pip using yum..."
            sudo yum install -y python3-pip
        elif command -v dnf &> /dev/null; then
            echo "Installing python3-pip using dnf..."
            sudo dnf install -y python3-pip
        elif command -v pacman &> /dev/null; then
            echo "Installing python-pip using pacman..."
            sudo pacman -S python-pip
        else
            echo "Error: Unable to install pip automatically."
            echo "Please install pip manually for your distribution:"
            echo "  Ubuntu/Debian: sudo apt-get install python3-pip"
            echo "  CentOS/RHEL: sudo yum install python3-pip"
            echo "  Fedora: sudo dnf install python3-pip"
            echo "  Arch: sudo pacman -S python-pip"
            exit 1
        fi
        
        # Verify pip installation
        if ! command -v pip3 &> /dev/null && ! command -v pip &> /dev/null; then
            echo "Error: Failed to install pip. Please install it manually."
            exit 1
        fi
        
        echo "pip installed successfully!"
    fi
    
    # Try different methods to install pipenv (handle PEP 668)
    echo "Installing pipenv..."
    if command -v pip3 &> /dev/null; then
        # Try --user first, then --break-system-packages if needed
        pip3 install --user pipenv || pip3 install --user pipenv --break-system-packages
    elif command -v pip &> /dev/null; then
        # Try --user first, then --break-system-packages if needed
        pip install --user pipenv || pip install --user pipenv --break-system-packages
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