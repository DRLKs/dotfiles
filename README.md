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
3. Symlink all configs to `~/.config/` and `bin/dictar` to `~/.local/bin/`
4. Enable required services (NetworkManager, Docker)

After installation, reboot, log in on the TTY and run `start-hyprland`.

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
| Display Manager | None (TTY + `start-hyprland`) |
| Dictation | whisper.cpp + wtype (`bin/dictar`) |
| Theme | Dracula |
| Font | JetBrainsMono Nerd Font |

## Wallpaper

No wallpaper daemon: Hyprland paints a solid Dracula background (`misc.background_color` in `config/hypr/hyprland.lua`).

## Lock and idle

`SUPER + L` locks the screen. Hypridle dims the screen after 2.5 min, locks at 5 min, turns the screen off at 5.5 min and suspends at 15 min (`config/hypr/hypridle.conf`).

## Dictation

`SUPER + D` starts recording, press it again to stop: `bin/dictar` transcribes the audio with whisper.cpp and types the text with `wtype`. Status is shown with mako notifications (green: recording, orange: transcribing, red: error).

The model is not included. Download it once:

```bash
mkdir -p ~/.local/share/whisper
curl -L -o ~/.local/share/whisper/ggml-base.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin
```

Use another model with `DICTAR_MODEL=/path/to/model.bin`.

## Starting Hyprland

There is no display manager, to keep the system light. Log in on the TTY and run:

```bash
start-hyprland
```
