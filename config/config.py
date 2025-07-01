# -*- coding: utf-8 -*-
#
# Zelda-themed Qtile Configuration
# A Qtile configuration with Legend of Zelda theme

import os
import subprocess
from typing import List

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# Key bindings
mod = "mod4"  # Super key
terminal = guess_terminal()

# Zelda color scheme
colors = {
    "triforce_gold": "#FFD700",  # Triforce gold
    "hyrule_green": "#1E8449",  # Hyrule green
    "link_tunic": "#3C9F40",    # Link's tunic
    "zelda_blue": "#1A5276",    # Zelda blue
    "ganon_purple": "#6C3483",  # Ganondorf purple
    "master_sword": "#5DADE2",  # Master sword blue
    "black": "#000000",
    "white": "#FFFFFF",
    "transparent": "#00000000",
}

# Keybindings
keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between layouts
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    # Qtile management
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Launch applications
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "e", lazy.spawn("thunar"), desc="Launch file manager"),
]

# Workspaces (Groups)
groups = [
    Group("1", label="⚔️"),  # Weapons
    Group("2", label="🛡️"),  # Shield
    Group("3", label="🧪"),  # Potions
    Group("4", label="📜"),  # Maps
    Group("5", label="💎"),  # Treasures
    Group("6", label="🏰"),  # Dungeons
    Group("7", label="🧝"),  # Characters
    Group("8", label="🎵"),  # Music
    Group("9", label="🔮"),  # Magic
]

# Add group keybindings
for i in groups:
    keys.extend([
        # mod1 + group number = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + group number = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
    ])

# Layouts
layout_theme = {
    "border_width": 4,
    "margin": 8,
    "border_focus": colors["triforce_gold"],
    "border_normal": colors["zelda_blue"],
    "border_radius": 4,  # Rounded corners as requested
}

layouts = [
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Floating(**layout_theme),
]

# Widgets
widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
    background=colors["transparent"],  # Transparent background as requested
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(foreground=colors["triforce_gold"]),
                widget.GroupBox(
                    active=colors["triforce_gold"],
                    inactive=colors["zelda_blue"],
                    highlight_method="line",
                    highlight_color=[colors["hyrule_green"], colors["link_tunic"]],
                    this_current_screen_border=colors["triforce_gold"],
                ),
                widget.Prompt(foreground=colors["triforce_gold"]),
                widget.WindowName(foreground=colors["triforce_gold"]),
                widget.Chord(
                    chords_colors={
                        "launch": (colors["ganon_purple"], colors["white"]),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p", foreground=colors["triforce_gold"]),
                widget.QuickExit(foreground=colors["triforce_gold"], default_text="[Exit]"),
            ],
            24,
            opacity=0.8,  # Translucent bar
            background=colors["transparent"],  # Transparent background
        ),
    ),
]

# Mouse bindings
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# Other settings
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    **layout_theme
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# Autostart
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])