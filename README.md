# dotfiles

Arch Linux dotfiles with Hyprland (Wayland).

## Quick Install

```bash
git clone https://github.com/<your-user>/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:
1. Install all official packages via `pacman`
2. Install `yay` and AUR packages (hyprshot, spotify)
3. Symlink all configs to `~/.config/`
4. Enable required services (GDM, NetworkManager, Docker)

After installation, reboot and select **Hyprland** in GDM.

## Stack

| Component | Software |
|---|---|
| Compositor | Hyprland |
| Terminal | Alacritty |
| Bar | Waybar |
| Launcher | Fuzzel |
| Notifications | Mako |
| Lock / idle | Hyprlock + Hypridle |
| Editor | Neovim (lazy.nvim) |
| Browser | Firefox |
| File Manager | Thunar |
| Audio | PipeWire + WirePlumber |
| Wallpaper | Solid color (`misc.background_color`) |
| Display Manager | GDM |
| Theme | Dracula |
| Font | JetBrainsMono Nerd Font |

## Wallpaper

No wallpaper daemon: Hyprland paints a solid Dracula background (`misc.background_color` in `config/hypr/hyprland.lua`).

## Lock and idle

`SUPER + L` locks the screen. Hypridle dims the screen after 2.5 min, locks at 5 min, turns the screen off at 5.5 min and suspends at 15 min (`config/hypr/hypridle.conf`).

## GDM Setup

The display manager used is GDM (GNOME Display Manager). The installer enables it automatically, but if needed manually:

```bash
sudo pacman -S gdm
sudo systemctl enable gdm
sudo systemctl set-default graphical.target
```
