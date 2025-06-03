#!/bin/bash

echo "Setting up desktop shortcut for Aiohttp React App..."

# Get the current directory (project directory)
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create desktop entry content with absolute path
DESKTOP_CONTENT="[Desktop Entry]
Version=1.0
Type=Application
Name=Start Aiohttp React App
Comment=Launch Aiohttp + React web application
Exec=gnome-terminal -- bash -c 'cd \"$PROJECT_DIR\" && ./start.sh; echo \"Press Enter to close...\"; read'
Icon=applications-internet
Path=$PROJECT_DIR
Terminal=false
StartupNotify=true
Categories=Development;Network;WebDevelopment;
Keywords=aiohttp;react;python;web;development;"

# Create desktop file in user's desktop directory
DESKTOP_FILE="$HOME/Desktop/start-aiohttp-app.desktop"

echo "$DESKTOP_CONTENT" > "$DESKTOP_FILE"

# Make the desktop file executable
chmod +x "$DESKTOP_FILE"

# Also make start.sh executable
chmod +x "$PROJECT_DIR/start.sh"

echo "Desktop shortcut created: $DESKTOP_FILE"
echo "You can now double-click the shortcut on your desktop to run the app!"
echo ""
echo "If the shortcut doesn't work immediately, you might need to:"
echo "1. Right-click on the desktop file"
echo "2. Select 'Allow Launching' or 'Trust this application'"
echo ""
echo "Alternative: You can also copy the .desktop file to ~/.local/share/applications/"
echo "to make it appear in the application menu."

# Optionally copy to applications directory
read -p "Do you want to add it to the application menu as well? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mkdir -p "$HOME/.local/share/applications"
    cp "$DESKTOP_FILE" "$HOME/.local/share/applications/"
    echo "Added to application menu!"
fi

echo "Setup complete!"