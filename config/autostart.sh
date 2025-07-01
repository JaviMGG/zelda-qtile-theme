#!/bin/bash

# Autostart script for Zelda Qtile Theme
# This script runs when Qtile starts

# Function to log messages
log_message() {
    echo "[Zelda Qtile Theme] $1"
}

# Check if wallpaper file exists
if [ ! -f "$HOME/.config/qtile/wallpaper.png" ]; then
    log_message "Error: Wallpaper file wallpaper.png not found"
    log_message "Creating a backup file..."
    touch "$HOME/.config/qtile/wallpaper.png"
fi

# Set wallpaper
if command -v feh &> /dev/null; then
    log_message "Setting wallpaper with feh"
    feh --bg-fill "$HOME/.config/qtile/wallpaper.png" || log_message "Error setting wallpaper"
else
    log_message "feh is not installed. Cannot set wallpaper."
fi

# Start compositor for transparency effects with custom settings
if command -v picom &> /dev/null; then
    log_message "Starting picom compositor with custom configuration"
    # Use custom configuration file for picom
    if [ -f "$HOME/.config/qtile/picom.conf" ]; then
        picom --config "$HOME/.config/qtile/picom.conf" -b || log_message "Error starting picom with custom configuration"
    else
        log_message "Picom configuration file not found, using basic configuration"
        # Configuration for more transparent terminals and rounded borders
        picom -b --backend glx --corner-radius 4 --round-borders 1 --opacity-rule "85:class_g = 'Alacritty'" --opacity-rule "85:class_g = 'kitty'" --opacity-rule "85:class_g = 'URxvt'" --opacity-rule "85:class_g = 'XTerm'" --opacity-rule "85:class_g = 'st-256color'" --opacity-rule "85:class_g = 'gnome-terminal'" || log_message "Error starting picom with custom configuration"
    fi
else
    log_message "picom is not installed. Transparency effects will not be available."
fi

# Start notification daemon
if command -v dunst &> /dev/null; then
    log_message "Starting dunst notification daemon"
    dunst & 
else
    log_message "dunst is not installed. Notifications may not work correctly."
fi

# Start network manager applet
if command -v nm-applet &> /dev/null; then
    log_message "Starting nm-applet network applet"
    nm-applet &
else
    log_message "nm-applet is not installed. Network indicator will not be available."
fi

# Start volume control applet
if command -v pasystray &> /dev/null; then
    log_message "Starting pasystray volume control"
    pasystray &
else
    log_message "pasystray is not installed. Volume control will not be available."
fi

# Start battery indicator
if command -v cbatticon &> /dev/null; then
    log_message "Starting cbatticon battery indicator"
    cbatticon &
else
    log_message "cbatticon is not installed. Battery indicator will not be available."
fi

log_message "Autostart completed"
