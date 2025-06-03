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

# Check if pyenv is installed, install if not found
if ! command -v pyenv &> /dev/null; then
    echo "pyenv is not installed. Installing pyenv..."
    
    # Install pyenv using the official installer
    if command -v curl &> /dev/null; then
        curl https://pyenv.run | bash
        
        # Add pyenv to PATH and initialize
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
        
        # Add to shell profile for persistence
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
        echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
        echo 'eval "$(pyenv init -)"' >> ~/.bashrc
        echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
        
        if ! command -v pyenv &> /dev/null; then
            echo "Error: pyenv installation failed. Please install it manually:"
            echo "  curl https://pyenv.run | bash"
            echo "  Or visit: https://github.com/pyenv/pyenv#installation"
            exit 1
        fi
        
        echo "pyenv installed successfully!"
    else
        echo "Error: curl is not available. Please install curl first."
        exit 1
    fi
else
    # Initialize pyenv if already installed
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Check if Python 3.11 is available via pyenv, install if not
PYTHON_VERSION="3.11.9"
if ! pyenv versions | grep -q "$PYTHON_VERSION"; then
    echo "Python $PYTHON_VERSION is not installed via pyenv. Installing..."
    
    # Install build dependencies for Ubuntu/Debian
    if command -v apt-get &> /dev/null; then
        echo "Installing Python build dependencies..."
        sudo apt-get update
        sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
        libffi-dev liblzma-dev
    fi
    
    pyenv install $PYTHON_VERSION
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Python $PYTHON_VERSION via pyenv"
        echo "Trying to use available Python version..."
        AVAILABLE_VERSION=$(pyenv versions --bare | grep "^3\." | head -1)
        if [ -n "$AVAILABLE_VERSION" ]; then
            PYTHON_VERSION=$AVAILABLE_VERSION
            echo "Using available Python version: $PYTHON_VERSION"
        else
            echo "Error: No Python 3.x version available in pyenv"
            exit 1
        fi
    fi
fi

# Set the Python version for this project
pyenv local $PYTHON_VERSION
echo "Using Python: $PYTHON_VERSION (via pyenv)"

# Install dependencies using Poetry
echo "Installing dependencies with Poetry..."

# Check if lock file needs to be updated
if ! poetry check --lock &> /dev/null; then
    echo "Updating poetry.lock file..."
    poetry lock --no-update
fi

poetry install

if [ $? -ne 0 ]; then
    echo "Error: Failed to install dependencies with Poetry"
    exit 1
fi

echo "Starting server on http://localhost:8080"
echo "Press Ctrl+C to stop the server"

# Run the application using Poetry
poetry run python start.py