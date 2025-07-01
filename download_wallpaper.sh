#!/bin/bash

# Script to download a Zelda-themed wallpaper
# This script will download a Legend of Zelda wallpaper for the Qtile theme

echo "Downloading Zelda wallpaper..."

# Create directory if it doesn't exist
mkdir -p ~/.config/qtile

# Download a Zelda-themed wallpaper
wget -O ~/.config/qtile/wallpaper.jpg https://wallpaperaccess.com/full/1101947.jpg

echo "Wallpaper downloaded to ~/.config/qtile/wallpaper.jpg"
echo "If the download fails, please manually download a Zelda wallpaper and save it to that location."