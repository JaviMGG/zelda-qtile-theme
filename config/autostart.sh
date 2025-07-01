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

# Start compositor for transparency effects with custom settings (optimizado)
if command -v picom &> /dev/null; then
    log_message "Iniciando compositor picom con configuración optimizada"
    # Usar el archivo de configuración personalizado para picom
    if [ -f "$HOME/.config/qtile/picom.conf" ]; then
        # Matar cualquier instancia previa de picom
        pkill picom 2>/dev/null
        # Iniciar con configuración optimizada
        picom --config "$HOME/.config/qtile/picom.conf" -b || log_message "Error al iniciar picom con configuración personalizada"
    else
        log_message "No se encontró el archivo de configuración de picom, usando configuración básica optimizada"
        # Matar cualquier instancia previa de picom
        pkill picom 2>/dev/null
        # Configuración optimizada para mejor rendimiento
        picom -b --backend xrender --corner-radius 4 --round-borders 1 \
              --no-fading-openclose \
              --unredir-if-possible \
              --opacity-rule "90:class_g = 'Alacritty'" \
              --opacity-rule "90:class_g = 'kitty'" \
              --opacity-rule "90:class_g = 'XTerm'" \
              --use-damage \
              --glx-no-stencil \
              --glx-no-rebind-pixmap \
              || log_message "Error al iniciar picom con configuración optimizada"
    fi
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
