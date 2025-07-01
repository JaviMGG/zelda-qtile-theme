# Zelda Qtile Theme

A Legend of Zelda themed configuration for the Qtile window manager on Arch Linux.

![Zelda Qtile Theme](screenshots/preview.png)

## Features

- **Zelda-inspired color scheme**: Gold, green, and blue colors reminiscent of the Legend of Zelda series
- **Rounded window borders**: Terminal windows with yellow borders and 4px radius
- **Translucent backgrounds**: Semi-transparent terminal and panel backgrounds to showcase your wallpaper
- **Triforce Neofetch**: Custom Triforce ASCII art for Neofetch
- **Zelda-themed workspace icons**: Themed workspace labels with Zelda-related emojis

## Requirements

- Arch Linux
- Qtile window manager
- Python 3
- Neofetch
- Picom (for transparency effects)
- Feh (for setting wallpaper)

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

## Manual Installation

If you prefer to install manually:

1. Back up your existing Qtile configuration:
   ```bash
   cp -r ~/.config/qtile ~/.config/qtile.backup
   ```

2. Copy the configuration files:
   ```bash
   cp -r config/* ~/.config/qtile/
   ```

3. Set up Neofetch with the Triforce logo:
   ```bash
   mkdir -p ~/.config/neofetch
   cp neofetch/config.conf ~/.config/neofetch/
   cp neofetch/triforce.txt ~/.config/neofetch/
   ```

4. Make the autostart script executable:
   ```bash
   chmod +x ~/.config/qtile/autostart.sh
   ```

5. Log out and log back in, or restart Qtile with `Mod+Control+r`

## Customization

### Changing the Wallpaper

Replace the `~/.config/qtile/wallpaper.jpg` file with your preferred Zelda-themed wallpaper.

### Modifying Colors

Edit the color scheme in `~/.config/qtile/config.py` by modifying the `colors` dictionary.

### Workspace Icons

Customize the workspace icons by editing the `groups` list in `~/.config/qtile/config.py`.

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
├── neofetch/
│   ├── config.conf      # Neofetch configuration
│   └── triforce.txt     # Triforce ASCII art
├── screenshots/
│   └── preview.png      # Theme preview
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
- Neofetch: https://github.com/dylanaraps/neofetch