#!/bin/bash

# Zelda Qtile Theme Installer
# This script installs a Zelda-themed configuration for Qtile window manager

# Function to display colored messages
show_message() {
    local color=$1
    local message=$2
    
    case $color in
        "green") echo -e "\e[32m$message\e[0m" ;;
        "red") echo -e "\e[31m$message\e[0m" ;;
        "yellow") echo -e "\e[33m$message\e[0m" ;;
        *) echo "$message" ;;
    esac
}

show_message "green" "=== Installing Zelda Qtile Theme ==="

# Create backup of original config
BACKUP_DATE=$(date +"%Y%m%d%H%M%S")
QTILE_CONFIG_DIR="$HOME/.config/qtile"

if [ -d "$QTILE_CONFIG_DIR" ]; then
    show_message "yellow" "Creating backup of existing Qtile configuration..."
    if cp -r "$QTILE_CONFIG_DIR" "${QTILE_CONFIG_DIR}_backup_${BACKUP_DATE}"; then
        show_message "green" "✓ Backup created at ${QTILE_CONFIG_DIR}_backup_${BACKUP_DATE}"
    else
        show_message "red" "✗ Error creating backup. Continuing anyway..."
    fi
fi

# Create Qtile config directory if it doesn't exist
show_message "yellow" "Verifying Qtile config directory..."
if mkdir -p "$QTILE_CONFIG_DIR"; then
    show_message "green" "✓ Config directory ready"
else
    show_message "red" "✗ Error creating config directory"
    exit 1
fi

# Verify config directory exists
if [ ! -d "./config" ]; then
    show_message "red" "✗ Error: Config directory ./config not found"
    exit 1
fi

# Copy configuration files
show_message "yellow" "Copying Zelda theme configuration files..."
if cp -r ./config/* "$QTILE_CONFIG_DIR/"; then
    show_message "green" "✓ Configuration files copied successfully"
else
    show_message "red" "✗ Error copying configuration files"
    exit 1
fi

# Ensure picom.conf has the right permissions and inform about optimizations
show_message "yellow" "Setting up optimized picom.conf for better performance..."
if [ -f "$QTILE_CONFIG_DIR/picom.conf" ]; then
    if chmod 644 "$QTILE_CONFIG_DIR/picom.conf"; then
        show_message "green" "✓ Optimized picom configuration installed successfully"
        show_message "yellow" "  The configuration has been optimized for better performance"
        show_message "yellow" "  If you prefer more advanced visual effects, you can edit $QTILE_CONFIG_DIR/picom.conf"
    else
        show_message "red" "✗ Error setting picom.conf permissions"
    fi
fi

# Verify wallpaper exists
if [ ! -f "./zelda.png" ]; then
    show_message "red" "✗ Error: Wallpaper file zelda.png not found"
    exit 1
fi

# Copy wallpaper
show_message "yellow" "Copying Zelda wallpaper..."
if cp ./zelda.png "$QTILE_CONFIG_DIR/wallpaper.png"; then
    show_message "green" "✓ Wallpaper copied successfully"
else
    show_message "red" "✗ Error copying wallpaper"
    exit 1
fi

# Make autostart script executable
show_message "yellow" "Making autostart script executable..."
if chmod +x "$QTILE_CONFIG_DIR/autostart.sh"; then
    show_message "green" "✓ Autostart script is now executable"
else
    show_message "red" "✗ Error making autostart script executable"
    exit 1
fi

# Install dependencies
show_message "yellow" "Installing dependencies..."

# Check if we're on Arch Linux
if command -v pacman &> /dev/null; then
    show_message "green" "✓ Detected Arch Linux, installing dependencies..."
    
    # List of packages to install
    PACKAGES=("python-pip" "python-xcffib" "python-cairocffi" "python-cffi" "imagemagick" "feh" "picom")
    
    # Check if we have sudo
    if command -v sudo &> /dev/null; then
        show_message "yellow" "Installing system packages (may ask for password)..."
        if sudo pacman -S --needed ${PACKAGES[@]}; then
            show_message "green" "✓ System packages installed successfully"
        else
            show_message "red" "✗ Error installing some system packages"
            show_message "yellow" "Continuing with installation. Some components may not work properly."
        fi
    else
        show_message "red" "✗ sudo command not found. Cannot install dependencies automatically."
        show_message "yellow" "Please manually install the following packages:"
        for pkg in "${PACKAGES[@]}"; do
            show_message "yellow" "  - $pkg"
        done
    fi
else
    show_message "red" "✗ This script is designed for Arch Linux."
    show_message "yellow" "Please manually install the following packages:"
    show_message "yellow" "  - python-pip"
    show_message "yellow" "  - python-xcffib"
    show_message "yellow" "  - python-cairocffi"
    show_message "yellow" "  - python-cffi"
    show_message "yellow" "  - imagemagick"
    show_message "yellow" "  - feh"
    show_message "yellow" "  - picom"
fi

# Install Python dependencies
show_message "yellow" "Attempting to install Python dependencies..."

# Function to install Python dependencies
install_python_deps() {
    local pip_cmd=$1
    local success=false
    
    # Try installing with --user first
    if $pip_cmd install --user psutil; then
        success=true
    else
        show_message "yellow" "Trying to install without --user..."
        if $pip_cmd install psutil; then
            success=true
        fi
    fi
    
    if [ "$success" = true ]; then
        show_message "green" "✓ Python dependencies installed successfully"
    else
        show_message "red" "✗ Error installing Python dependencies"
        show_message "yellow" "You can install them manually with: $pip_cmd install --user psutil"
        show_message "yellow" "Or install the system package: sudo pacman -S python-psutil"
    fi
}

if command -v pip &> /dev/null; then
    install_python_deps "pip"
elif command -v pip3 &> /dev/null; then
    install_python_deps "pip3"
else
    show_message "red" "✗ pip not found. Please install Python dependencies manually:"
    show_message "yellow" "  - psutil (pip install --user psutil)"
    show_message "yellow" "  - Or install the system package: sudo pacman -S python-psutil"
fi

# No Neofetch setup needed

show_message "green" "=== Installation complete! ==="
show_message "yellow" "Please log out and log back in to apply the Zelda Qtile theme."
show_message "yellow" "Alternatively, you can restart Qtile by pressing Mod+Control+r"
show_message "yellow" "If you encounter any errors, check the 'Troubleshooting Installation' section in README.md"
show_message "green" "The theme has been optimized for better performance and faster loading."
show_message "yellow" "If you experience performance issues, check the 'Performance Optimization' section in README.md"
