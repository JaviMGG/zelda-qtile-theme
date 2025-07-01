#!/bin/bash

# Zelda Qtile Theme Installer
# This script installs a Zelda-themed configuration for Qtile window manager

# Función para mostrar mensajes con colores
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

show_message "green" "=== Instalando Zelda Qtile Theme ==="

# Create backup of original config
BACKUP_DATE=$(date +"%Y%m%d%H%M%S")
QTILE_CONFIG_DIR="$HOME/.config/qtile"

if [ -d "$QTILE_CONFIG_DIR" ]; then
    show_message "yellow" "Creando copia de seguridad de la configuración existente de Qtile..."
    if cp -r "$QTILE_CONFIG_DIR" "${QTILE_CONFIG_DIR}_backup_${BACKUP_DATE}"; then
        show_message "green" "✓ Copia de seguridad creada en ${QTILE_CONFIG_DIR}_backup_${BACKUP_DATE}"
    else
        show_message "red" "✗ Error al crear la copia de seguridad. Continuando de todos modos..."
    fi
fi

# Create Qtile config directory if it doesn't exist
show_message "yellow" "Verificando directorio de configuración de Qtile..."
if mkdir -p "$QTILE_CONFIG_DIR"; then
    show_message "green" "✓ Directorio de configuración listo"
else
    show_message "red" "✗ Error al crear el directorio de configuración"
    exit 1
fi

# Verify config directory exists
if [ ! -d "./config" ]; then
    show_message "red" "✗ Error: No se encontró el directorio de configuración ./config"
    exit 1
fi

# Copy configuration files
show_message "yellow" "Copiando archivos de configuración del tema Zelda..."
if cp -r ./config/* "$QTILE_CONFIG_DIR/"; then
    show_message "green" "✓ Archivos de configuración copiados correctamente"
else
    show_message "red" "✗ Error al copiar los archivos de configuración"
    exit 1
fi

# Ensure picom.conf has the right permissions and inform about optimizations
show_message "yellow" "Configurando picom.conf optimizado para mejor rendimiento..."
if [ -f "$QTILE_CONFIG_DIR/picom.conf" ]; then
    if chmod 644 "$QTILE_CONFIG_DIR/picom.conf"; then
        show_message "green" "✓ Configuración de picom optimizada instalada correctamente"
        show_message "yellow" "  La configuración ha sido optimizada para mejorar el rendimiento"
        show_message "yellow" "  Si prefieres efectos visuales más avanzados, puedes editar $QTILE_CONFIG_DIR/picom.conf"
    else
        show_message "red" "✗ Error al configurar permisos de picom.conf"
    fi
fi

# Verify wallpaper exists
if [ ! -f "./zelda.png" ]; then
    show_message "red" "✗ Error: No se encontró el archivo de wallpaper zelda.png"
    exit 1
fi

# Copy wallpaper
show_message "yellow" "Copiando wallpaper de Zelda..."
if cp ./zelda.png "$QTILE_CONFIG_DIR/wallpaper.png"; then
    show_message "green" "✓ Wallpaper copiado correctamente"
else
    show_message "red" "✗ Error al copiar el wallpaper"
    exit 1
fi

# Make autostart script executable
show_message "yellow" "Haciendo ejecutable el script de autostart..."
if chmod +x "$QTILE_CONFIG_DIR/autostart.sh"; then
    show_message "green" "✓ Script de autostart ahora es ejecutable"
else
    show_message "red" "✗ Error al hacer ejecutable el script de autostart"
    exit 1
fi

# Install dependencies
show_message "yellow" "Instalando dependencias..."

# Check if we're on Arch Linux
if command -v pacman &> /dev/null; then
    show_message "green" "✓ Detectado Arch Linux, instalando dependencias..."
    
    # Lista de paquetes a instalar
    PACKAGES=("python-pip" "python-xcffib" "python-cairocffi" "python-cffi" "imagemagick" "feh" "picom")
    
    # Verificar si tenemos sudo
    if command -v sudo &> /dev/null; then
        show_message "yellow" "Instalando paquetes del sistema (puede solicitar contraseña)..."
        if sudo pacman -S --needed ${PACKAGES[@]}; then
            show_message "green" "✓ Paquetes del sistema instalados correctamente"
        else
            show_message "red" "✗ Error al instalar algunos paquetes del sistema"
            show_message "yellow" "Continuando con la instalación. Algunos componentes pueden no funcionar correctamente."
        fi
    else
        show_message "red" "✗ No se encontró el comando sudo. No se pueden instalar dependencias automáticamente."
        show_message "yellow" "Por favor, instala manualmente los siguientes paquetes:"
        for pkg in "${PACKAGES[@]}"; do
            show_message "yellow" "  - $pkg"
        done
    fi
else
    show_message "red" "✗ Este script está diseñado para Arch Linux."
    show_message "yellow" "Por favor, instala manualmente los siguientes paquetes:"
    show_message "yellow" "  - python-pip"
    show_message "yellow" "  - python-xcffib"
    show_message "yellow" "  - python-cairocffi"
    show_message "yellow" "  - python-cffi"
    show_message "yellow" "  - imagemagick"
    show_message "yellow" "  - feh"
    show_message "yellow" "  - picom"
fi

# Install Python dependencies
show_message "yellow" "Intentando instalar dependencias de Python..."

# Función para instalar dependencias de Python
install_python_deps() {
    local pip_cmd=$1
    local success=false
    
    # Intentar instalar con --user primero
    if $pip_cmd install --user psutil; then
        success=true
    else
        show_message "yellow" "Intentando instalar sin --user..."
        if $pip_cmd install psutil; then
            success=true
        fi
    fi
    
    if [ "$success" = true ]; then
        show_message "green" "✓ Dependencias de Python instaladas correctamente"
    else
        show_message "red" "✗ Error al instalar dependencias de Python"
        show_message "yellow" "Puedes instalarlas manualmente con: $pip_cmd install --user psutil"
        show_message "yellow" "O instalar el paquete del sistema: sudo pacman -S python-psutil"
    fi
}

if command -v pip &> /dev/null; then
    install_python_deps "pip"
elif command -v pip3 &> /dev/null; then
    install_python_deps "pip3"
else
    show_message "red" "✗ No se encontró pip. Por favor, instala las dependencias de Python manualmente:"
    show_message "yellow" "  - psutil (pip install --user psutil)"
    show_message "yellow" "  - O instala el paquete del sistema: sudo pacman -S python-psutil"
fi

# No Neofetch setup needed

show_message "green" "=== ¡Instalación completada! ==="
show_message "yellow" "Por favor, cierra sesión y vuelve a iniciar sesión para aplicar el tema Zelda Qtile."
show_message "yellow" "Alternativamente, puedes reiniciar Qtile presionando Mod+Control+r"
show_message "yellow" "Si encuentras algún error, consulta la sección 'Troubleshooting Installation' en el README.md"
show_message "green" "El tema ha sido optimizado para un mejor rendimiento y carga más rápida."
show_message "yellow" "Si experimentas problemas de rendimiento, consulta la sección 'Performance Optimization' en el README.md"
