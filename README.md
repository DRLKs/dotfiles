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
| Launcher | Wofi |
| Editor | Neovim (lazy.nvim) |
| Browser | Firefox |
| File Manager | Thunar |
| Audio | PipeWire + WirePlumber |
| Wallpaper | Hyprpaper |
| Display Manager | GDM |
| Theme | Dracula |
| Font | JetBrainsMono Nerd Font |

## Wallpaper

Place your wallpaper at `~/Pictures/wallpapers/arch/lone.jpg` or edit `config/hypr/hyprpaper.conf`.

## GDM Setup

The display manager used is GDM (GNOME Display Manager). The installer enables it automatically, but if needed manually:

```bash
sudo pacman -S gdm
sudo systemctl enable gdm
sudo systemctl set-default graphical.target
```
