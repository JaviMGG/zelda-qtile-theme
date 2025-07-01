#!/bin/bash

# Zelda Qtile Theme Installer
# This script installs a Zelda-themed configuration for Qtile window manager

echo "Installing Zelda Qtile Theme..."

# Create backup of original config
BACKUP_DATE=$(date +"%Y%m%d%H%M%S")
QTILE_CONFIG_DIR="$HOME/.config/qtile"

if [ -d "$QTILE_CONFIG_DIR" ]; then
    echo "Creating backup of existing Qtile configuration..."
    cp -r "$QTILE_CONFIG_DIR" "${QTILE_CONFIG_DIR}_backup_${BACKUP_DATE}"
fi

# Create Qtile config directory if it doesn't exist
mkdir -p "$QTILE_CONFIG_DIR"

# Copy configuration files
echo "Copying Zelda theme configuration files..."
cp -r ./config/* "$QTILE_CONFIG_DIR/"

# Install dependencies
echo "Installing dependencies..."

# Check if we're on Arch Linux
if command -v pacman &> /dev/null; then
    echo "Detected Arch Linux, installing dependencies..."
    sudo pacman -S --needed python-pip python-xcffib python-cairocffi python-cffi
    sudo pacman -S --needed neofetch imagemagick
else
    echo "This script is designed for Arch Linux. Please install the following packages manually:"
    echo "- python-pip"
    echo "- python-xcffib"
    echo "- python-cairocffi"
    echo "- python-cffi"
    echo "- neofetch"
    echo "- imagemagick"
fi

# Install Python dependencies
pip install --user psutil

# Set up Neofetch with Triforce logo
echo "Setting up Neofetch with Triforce logo..."
mkdir -p "$HOME/.config/neofetch"
cp ./neofetch/config.conf "$HOME/.config/neofetch/"
cp ./neofetch/triforce.txt "$HOME/.config/neofetch/"

echo "Installation complete!"
echo "Please log out and log back in to apply the Zelda Qtile theme."
echo "Alternatively, you can restart Qtile by pressing Mod+Control+r"