# Zelda Qtile Theme

A Legend of Zelda themed configuration for the Qtile window manager on Arch Linux.

* Without Terminals
![Zelda Qtile Theme](screenshots/zeldaWithoutTerminals.png)
* With Terminals
![Zelda Qtile Theme](screenshots/zeldaWithTerminals.png)

## Features

- **Zelda-inspired color scheme**: Gold, green, and blue colors reminiscent of the Legend of Zelda series
- **Rounded window borders**: Terminal windows with yellow borders and 4px radius corners
- **Translucent backgrounds**: Semi-transparent terminal (85% opacity) and panel backgrounds to showcase your wallpaper
- **Zelda-themed workspace icons**: Themed workspace labels with Zelda-related emojis
- **Enhanced UI elements**: Widgets with more opaque backgrounds and rounded corners for better visibility

## Requirements

- Arch Linux
- Qtile window manager
- Python 3
- Picom (for transparency effects, rounded corners, and shadows)
- Feh (for setting wallpaper)
- python-psutil (for CPU and memory widgets)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/zelda-qtile-theme.git
   cd zelda-qtile-theme
   ```

2. Run the installation script:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. Log out and log back in to apply the Qtile configuration, or restart Qtile with `Mod+Control+r`

### Troubleshooting Installation

- **Error "externally-managed-environment"**: Si recibes este error durante la instalación, es porque Python está gestionado por el sistema operativo. Puedes solucionarlo de varias formas:

  1. Instalar las dependencias a través del gestor de paquetes del sistema:
     ```bash
     sudo pacman -S python-psutil  # Para Arch Linux
     ```

  2. Crear un entorno virtual para la instalación:
     ```bash
     python -m venv venv
     source venv/bin/activate  # En Linux
     # o
     .\venv\Scripts\activate  # En Windows
     pip install psutil
     ```

  3. Forzar la instalación con pip (no recomendado pero funciona en algunos casos):
     ```bash
     pip install --break-system-packages psutil
     ```

- **Permisos**: Asegúrate de que los scripts tienen permisos de ejecución:
  ```bash
  chmod +x install.sh
  chmod +x ~/.config/qtile/autostart.sh
  ```

- **Dependencias faltantes**: Si algunos componentes no funcionan correctamente, verifica que todas las dependencias estén instaladas:
  ```bash
  sudo pacman -S python-pip python-xcffib python-cairocffi python-cffi imagemagick feh picom
  ```

- **Wallpaper no visible**: Si el wallpaper no se muestra correctamente, verifica que feh esté instalado y que el archivo de wallpaper exista:
  ```bash
  sudo pacman -S feh
  ls -la ~/.config/qtile/wallpaper.png
  feh --bg-fill ~/.config/qtile/wallpaper.png
  ```

- **Transparencia no funciona**: Si los efectos de transparencia no funcionan, asegúrate de que picom esté instalado y funcionando:
  ```bash
  sudo pacman -S picom
  picom -b
  ```

- **Rendimiento lento**: Si experimentas lentitud al cargar o usar el tema:
  ```bash
  # Reiniciar picom con la configuración optimizada
  pkill picom
  picom --config ~/.config/qtile/picom.conf -b
  ```
  
  También puedes editar el archivo `~/.config/qtile/picom.conf` para desactivar más efectos visuales o ajustar la configuración según tus necesidades.

## Manual Installation

If you prefer to install manually:

1. Back up your existing Qtile configuration:
   ```bash
   cp -r ~/.config/qtile ~/.config/qtile.backup
   ```

2. Copy the configuration files and wallpaper:
   ```bash
   cp -r config/* ~/.config/qtile/
   cp zelda.png ~/.config/qtile/wallpaper.png
   ```



3. Make the autostart script executable:
   ```bash
   chmod +x ~/.config/qtile/autostart.sh
   ```

4. Log out and log back in, or restart Qtile with `Mod+Control+r`

## Customization

### Changing the Wallpaper

Replace the `~/.config/qtile/wallpaper.png` file with your preferred Zelda-themed wallpaper.

### Modifying Colors and Opacity

Edit the color scheme in `~/.config/qtile/config.py` by modifying the `colors` dictionary.

Adjust the opacity of UI elements by modifying these variables in `config.py`:

```python
# Definir colores con opacidad
bar_bg = "#1A1A1ACC"  # Negro con 80% de opacidad para la barra
widget_bg = "#2D2D2DDD"  # Gris oscuro con 87% de opacidad para widgets
```

You can also change the bar opacity directly:

```python
opacity=0.95,  # Barra más opaca
```

### Workspace Icons

Customize the workspace icons by editing the `groups` list in `~/.config/qtile/config.py`.

### Terminal Transparency and Rounded Corners

The theme includes a custom picom configuration that provides:

- 90% opacity for terminal windows (Alacritty, Kitty, XTerm, etc.)
- 4px rounded corners for all windows
- Performance-optimized settings for faster loading

You can adjust these settings in `picom.conf` to your preference.

### Performance Optimization

The picom configuration has been optimized for better performance:

- Animations disabled to reduce CPU usage
- Shadows disabled to improve rendering speed
- Blur effects disabled for better performance
- Backend set to xrender instead of glx for lighter resource usage
- Fading transitions optimized for speed

If you experience slow loading or performance issues, these optimizations should help. If you prefer visual effects over performance, you can re-enable these features in `picom.conf`.

## Key Bindings

- `Mod+Enter`: Launch terminal
- `Mod+w`: Close window
- `Mod+r`: Run command prompt
- `Mod+Tab`: Cycle through layouts
- `Mod+[1-9]`: Switch to workspace
- `Mod+Shift+[1-9]`: Move window to workspace
- `Mod+h/j/k/l`: Navigate windows
- `Mod+Shift+h/j/k/l`: Move windows
- `Mod+Control+h/j/k/l`: Resize windows
- `Mod+Control+r`: Restart Qtile
- `Mod+Control+q`: Quit Qtile

## File Structure

```
.
├── config/
│   ├── config.py         # Main Qtile configuration
│   └── autostart.sh      # Autostart script
├── screenshots/
│   └── preview.png      # Theme preview
├── zelda.png            # Wallpaper image
├── install.sh           # Installation script
└── README.md            # This file
```

## Methods Documentation

### config.py

#### `lazy.layout.left()`, `lazy.layout.right()`, `lazy.layout.up()`, `lazy.layout.down()`
Navigate between windows in the specified direction.

#### `lazy.layout.shuffle_left()`, `lazy.layout.shuffle_right()`, `lazy.layout.shuffle_up()`, `lazy.layout.shuffle_down()`
Move the current window in the specified direction.

#### `lazy.layout.grow_left()`, `lazy.layout.grow_right()`, `lazy.layout.grow_up()`, `lazy.layout.grow_down()`
Resize the current window in the specified direction.

#### `lazy.layout.normalize()`
Reset all window sizes to their default values.

#### `lazy.next_layout()`
Cycle to the next available layout.

#### `lazy.window.kill()`
Close the focused window.

#### `lazy.restart()`
Restart the Qtile window manager without logging out.

#### `lazy.shutdown()`
Quit Qtile and return to the login manager.

#### `lazy.spawncmd()`
Show a command prompt to run a command.

#### `lazy.spawn(cmd)`
Run the specified command.

#### `lazy.window.togroup(group_name, switch_group=True)`
Move the current window to the specified group and optionally switch to that group.

#### `autostart()`
Hook function that runs once when Qtile starts. It executes the autostart.sh script.

### autostart.sh

#### Setting wallpaper with feh
Uses feh to set the desktop wallpaper.

#### Starting picom
Launches the picom compositor for transparency effects.

#### Starting system tray applications
Launches various system tray applications like network manager, volume control, etc.

### install.sh

#### Backup creation
Creates a backup of the existing Qtile configuration.

#### File copying
Copies the theme files to the appropriate locations.

#### Dependency installation
Installs required dependencies using pacman on Arch Linux.

## License

MIT

## Credits

- The Legend of Zelda is a trademark of Nintendo
- Qtile window manager: https://qtile.org
