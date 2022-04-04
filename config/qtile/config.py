# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

import subprocess
import os

from Xlib import display as xdisplay

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from libqtile.log_utils import logger

@hook.subscribe.startup_once
def autostart():
  home=os.path.expanduser('~/.config/qtile/qtile.sh')
  subprocess.run([home])

@hook.subscribe.client_new
def modify_window(client):
  for group in groups:  # follow on auto-move
    match = next((m for m in group.matches if m.compare(client)), None)
    if match:
       targetgroup = client.qtile.groups_map[group.name]  # there can be multiple instances of a group
       targetgroup.cmd_toscreen(toggle=False)
       break


#applications
dropSt="st -n dropdown -e /home/jeffery/bin/dropdown"
dropPauv="pavucontrol"
st=["st", "-e", "tmux"]


mod = "mod4"
#terminal = guess_terminal()

def latest_group(qtile):
  if (hasattr(qtile.current_screen, "previous_group")):
    qtile.current_screen.set_group(qtile.current_screen.previous_group)

keys = [
    # Switch between windows
      Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
      Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
      Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
      Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    KeyChord([mod], "w", [
      Key([], "Left", lazy.layout.left(), desc="Move focus to left"),
      Key([], "Right", lazy.layout.right(), desc="Move focus to right"),
      Key([], "Down", lazy.layout.down(), desc="Move focus down"),
      Key([], "Up", lazy.layout.up(), desc="Move focus up"),
      Key([], "h", lazy.layout.left(), desc="Move focus to left"),
      Key([], "l", lazy.layout.right(), desc="Move focus to right"),
      Key([], "j", lazy.layout.down(), desc="Move focus down"),
      Key([], "k", lazy.layout.up(), desc="Move focus up"),
      Key([], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

      # Move windows between left/right columns or move up/down in current stack.
      # Moving out of range in Columns layout will create new column.
      Key(["shift"], "Left", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
      Key(["shift"], "Right", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
      Key(["shift"], "Down", lazy.layout.shuffle_down(),
        desc="Move window down"),
      Key(["shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
      Key(["shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
      Key(["shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
      Key(["shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
      Key(["shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

      # Grow windows. If current window is on the edge of screen and direction
      # will be to screen edge - window would shrink.
      Key(["control"], "Left", lazy.layout.grow_left(),
        desc="Grow window to the left"),
      Key(["control"], "Right", lazy.layout.grow_right(),
        desc="Grow window to the right"),
      Key(["control"], "Down", lazy.layout.grow_down(),
        desc="Grow window down"),
      Key(["control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
      Key(["control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
      Key(["control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
      Key(["control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
      Key(["control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
      Key([],"n", lazy.layout.normalize(), desc="Reset all window sizes"),

      # Toggle between split and unsplit sides of stack.
      # Split = all windows displayed
      # Unsplit = 1 window displayed, like Max layout, but still with
      Key(["shift"], "Return", lazy.layout.max(),),
      # multiple stack panes
      Key(["shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack")],
      mode="windows"),

    #commands
    Key([],"XF86AudioMicMute", lazy.spawn("mic_mute t m"), desc="Mute computer"),
    Key([],"XF86AudioMute", lazy.spawn("mute_all t m"), desc="Mute computer"),
    Key(["shift"],"XF86AudioMute", lazy.spawn("mute_all t a"), desc="Mute computer"),
    Key([],"XF86AudioLowerVolume", lazy.spawn("volume d m"), desc="Lower volume"),
    Key([],"XF86AudioRaiseVolume", lazy.spawn("volume u m"), desc="Raise volume"),
    Key([],"XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 20"), desc="Raise Brightness"),
    Key([],"XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 20"), desc="Lower Brightness"),
    Key([],"XF86Display", lazy.spawn("fn-f7-emergency.sh"), desc="Just laptop monitor"),
    Key(["shift"],"XF86Display", lazy.spawn("fn-f7-work.sh"), desc="Work monitors monitor"),
    Key([mod], "Return", lazy.spawn(st), desc="Launch terminal"),
    Key([mod,"shift"], "Return", lazy.spawn("st"), desc="Launch terminal"),
    Key([mod], "r", lazy.spawn("rofi -show run"),
        desc="Spawn a command using a prompt widget"),
    Key([mod], "l", lazy.spawn("lock.sh"),
        desc="lock screen"),
    Key([mod,"shift"], "l", lazy.spawn("lock.sh -L"),
        desc="sleep lock screen"),
    Key([mod], "p", lazy.spawn("mpc_toggle")),
    Key([mod,"shift"], "p", lazy.spawn("mpc prev")),
    Key([mod, "control"], "p", lazy.spawn("picom-gray none"), desc="clear picom"),
    Key([mod,"shift"], "n", lazy.spawn("mpc next")),

    #scratchpad
    Key([mod], "m", lazy.group["scratchpad"].dropdown_toggle("Dropdown"), desc="dropSt"),
    Key([mod], "v", lazy.group["scratchpad"].dropdown_toggle("pavucontrol"), desc="dropPauv"),

    # Toggle between different layouts as defined below
    Key([mod], "b", lazy.hide_show_bar("top")),
    Key([mod], "Tab", lazy.function(latest_group), desc="Toggle between layouts"),
    Key([mod], "f", lazy.next_layout(), desc="Toggle between layouts"),
    Key( [mod, "shift"], "m", lazy.group.setlayout('max'), desc="max"),
    Key([mod,"shift"], "grave", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

groups.append(
    ScratchPad("scratchpad",
      [DropDown("Dropdown",dropSt,x=0.05, y=0.2, width=0.9, height=0.6,opacity=1.0),
       DropDown("pavucontrol",dropPauv,height=0.7,on_focus_lost_hide=True,opacity=1.0) ])
    )
groups.append(
    Group('Lock', matches=[Match(title="Lock")])
    )


theme = dict(
    base03 = '#002b36',
    base02 = '#073642',
    base01 = '#586e75',
    base00 = '#657b83',
    base0 = '#839496',
    base1 = '#93a1a1',
    base2 = '#eee8d5',
    base3 = '#fdf6e3',
    yellow = '#b58900',
    orange = '#cb4b16',
    red = '#dc322f',
    magenta = '#d33682',
    cyan='#2aa198',
    violet='#6c71c4',
    blue='#268bd2',
    green='#859900',

)

color_schemes = [
    dict(
      background=theme['base03'],
      arrow_color=theme['base02'],
      foreground=theme['base0'],
      ),
    dict(
      background=theme['base02'],
      arrow_color=theme['base03'],
      foreground=theme['base01'],
      )
    ]

layouts = [
    layout.Columns(border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
     layout.Matrix(),
     layout.MonadTall(),
     layout.MonadWide(),
     layout.RatioTile(),
    # layout.Tile(),
     layout.TreeTab(),
     layout.VerticalTile(),
     layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=10,
    padding=3,
)
#extension_defaults = widget_defaults.copy()

def add_widgets(bar):
  bar=bar+[
    widget.CurrentLayoutIcon(
      foreground=theme['red'],
      background=theme['base03']
      ),
    widget.GroupBox(
      active=theme['cyan'],
      inactive=theme['base01'],
      this_current_screen_border=theme['magenta'],
      highlight_color=theme['base02'],
      urgent_border=theme['red'],
      background=theme['base03'],
      highlight_method='block',
      ),
    widget.Prompt(),
    widget.WindowName(
      foreground=theme['base0'],
      background=theme['base03']
      ),
    widget.Chord(
      chords_colors={
        'windows': (theme['base03'], theme['red']),
        },
      name_transform=lambda name: name.upper(),
      ),
    widget.Mpd2(
      foreground=theme['base0'],
      background=theme['base03'],
      color_progress=theme['magenta']
      ),
    widget.PulseVolume(
      foreground=theme['base0'],
      background=theme['base03'],
      ),
    widget.BatteryIcon( background=theme['base03'],),
    widget.Clock(
      format='%a %H:%M',
      foreground=theme['base0'],
      background=theme['base03'],
      ),
    ]
  return bar

main_bar=add_widgets([])
main_bar=main_bar+ [
    widget.Systray(
      background=theme['base03'],
      ),
    widget.TextBox("m",
      foreground=theme['violet'],
      background=theme['base03'],
      ),
    widget.QuickExit(
      default_text="[X]",
      countdown_start=10,
      foreground=theme['base0'],
      background=theme['base03'],
      ),]

screens = [
    Screen(
        top=bar.Bar(
          main_bar,
            20,
        )
    ),
]

def get_num_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        logger.info(num_monitors)
        return num_monitors

if get_num_monitors() > 1:

  other_bar_widgets=add_widgets([])
  other_bar_widgets.append( widget.TextBox("o",
    background=theme['base03'],
    foreground=theme['violet']))

  screens.append(
      Screen(
        bottom=bar.Bar(
          other_bar_widgets,
          20,
          ),
        )
      )


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
