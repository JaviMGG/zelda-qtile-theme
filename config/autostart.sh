#!/bin/bash

# Autostart script for Zelda Qtile Theme
# This script runs when Qtile starts

# Set wallpaper
if command -v feh &> /dev/null; then
    feh --bg-fill ~/.config/qtile/wallpaper.png
fi

# Start compositor for transparency effects
if command -v picom &> /dev/null; then
    picom -b
fi

# Start notification daemon
if command -v dunst &> /dev/null; then
    dunst &
fi

# Start network manager applet
if command -v nm-applet &> /dev/null; then
    nm-applet &
fi

# Start volume control applet
if command -v pasystray &> /dev/null; then
    pasystray &
fi

# Start battery indicator
if command -v cbatticon &> /dev/null; then
    cbatticon &
fi
