#!/bin/bash

# Autostart script for Zelda Qtile Theme
# This script runs when Qtile starts

# Función para registrar mensajes
log_message() {
    echo "[Zelda Qtile Theme] $1"
}

# Verificar si existe el archivo de wallpaper
if [ ! -f "$HOME/.config/qtile/wallpaper.png" ]; then
    log_message "Error: No se encontró el archivo wallpaper.png"
    log_message "Creando un archivo de respaldo..."
    touch "$HOME/.config/qtile/wallpaper.png"
fi

# Set wallpaper
if command -v feh &> /dev/null; then
    log_message "Configurando wallpaper con feh"
    feh --bg-fill "$HOME/.config/qtile/wallpaper.png" || log_message "Error al configurar el wallpaper"
else
    log_message "feh no está instalado. No se puede configurar el wallpaper."
fi

# Start compositor for transparency effects
if command -v picom &> /dev/null; then
    log_message "Iniciando compositor picom"
    picom -b || log_message "Error al iniciar picom"
else
    log_message "picom no está instalado. Los efectos de transparencia no estarán disponibles."
fi

# Start notification daemon
if command -v dunst &> /dev/null; then
    log_message "Iniciando daemon de notificaciones dunst"
    dunst & 
else
    log_message "dunst no está instalado. Las notificaciones pueden no funcionar correctamente."
fi

# Start network manager applet
if command -v nm-applet &> /dev/null; then
    log_message "Iniciando applet de red nm-applet"
    nm-applet &
else
    log_message "nm-applet no está instalado. El indicador de red no estará disponible."
fi

# Start volume control applet
if command -v pasystray &> /dev/null; then
    log_message "Iniciando control de volumen pasystray"
    pasystray &
else
    log_message "pasystray no está instalado. El control de volumen no estará disponible."
fi

# Start battery indicator
if command -v cbatticon &> /dev/null; then
    log_message "Iniciando indicador de batería cbatticon"
    cbatticon &
else
    log_message "cbatticon no está instalado. El indicador de batería no estará disponible."
fi

log_message "Autostart completado"
