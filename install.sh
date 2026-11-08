#!/bin/bash
set -e

# ============================================================
# Arch Linux Dotfiles Installer
# ============================================================
# Installs all dependencies and symlinks configurations
# from this repository.
# ============================================================

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ============================================================
# Pre-checks
# ============================================================

if [[ ! -f /etc/arch-release ]]; then
    error "This script only works on Arch Linux."
    exit 1
fi

if [[ $EUID -eq 0 ]]; then
    error "Do not run this script as root. sudo will be requested when needed."
    exit 1
fi

# ============================================================
# Official packages (pacman)
# ============================================================

PACMAN_PKGS=(
    # Base system
    base-devel
    git
    curl
    wget
    unzip

    # Hyprland / Wayland compositor
    hyprland
    xdg-desktop-portal-hyprland

    # Wayland essentials
    qt5-wayland
    qt6-wayland
    polkit-gnome

    # Terminal
    alacritty

    # Shell utilities
    bash-completion

    # Status bar
    waybar

    # App launcher, notifications, lock/idle
    fuzzel
    mako
    hyprlock
    hypridle

    # File manager
    thunar

    # Browser
    firefox

    # Audio (PipeWire stack)
    pipewire
    pipewire-pulse
    pipewire-alsa
    wireplumber
    pavucontrol

    # Network
    networkmanager
    nm-connection-editor

    # Editor
    neovim

    # Fonts
    ttf-jetbrains-mono-nerd

    # Dictation (SUPER+D, bin/dictar)
    whisper-cpp
    wtype
    libnotify

    # System utilities
    brightnessctl
    playerctl
    grim
    slurp

    # Containers
    docker
    docker-compose

    # Development
    pnpm
)

# ============================================================
# AUR packages
# ============================================================

AUR_PKGS=(
    hyprshot
    spotify
)

# ============================================================
# Install official packages
# ============================================================

install_pacman_packages() {
    info "Updating system..."
    sudo pacman -Syu --noconfirm

    info "Installing official packages..."
    local to_install=()
    for pkg in "${PACMAN_PKGS[@]}"; do
        if ! pacman -Qi "$pkg" &>/dev/null; then
            to_install+=("$pkg")
        fi
    done

    if [[ ${#to_install[@]} -gt 0 ]]; then
        info "Installing ${#to_install[@]} packages: ${to_install[*]}"
        sudo pacman -S --noconfirm --needed "${to_install[@]}"
        success "Official packages installed."
    else
        success "All official packages already installed."
    fi
}

# ============================================================
# Install yay (AUR helper)
# ============================================================

install_yay() {
    if command -v yay &>/dev/null; then
        success "yay is already installed."
        return
    fi

    info "Installing yay (AUR helper)..."
    local tmp_dir
    tmp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
    cd "$tmp_dir/yay"
    makepkg -si --noconfirm
    cd "$DOTFILES_DIR"
    rm -rf "$tmp_dir"
    success "yay installed."
}

# ============================================================
# Install AUR packages
# ============================================================

install_aur_packages() {
    info "Installing AUR packages..."
    local to_install=()
    for pkg in "${AUR_PKGS[@]}"; do
        if ! yay -Qi "$pkg" &>/dev/null; then
            to_install+=("$pkg")
        fi
    done

    if [[ ${#to_install[@]} -gt 0 ]]; then
        info "Installing ${#to_install[@]} AUR packages: ${to_install[*]}"
        yay -S --noconfirm --needed "${to_install[@]}"
        success "AUR packages installed."
    else
        success "All AUR packages already installed."
    fi
}

# ============================================================
# Configuration symlinks
# ============================================================

link_config() {
    local src="$1"
    local dst="$2"

    if [[ -L "$dst" ]]; then
        rm "$dst"
    elif [[ -e "$dst" ]]; then
        warn "Backup: $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    success "Linked: $dst -> $src"
}

setup_symlinks() {
    info "Creating configuration symlinks..."

    link_config "$DOTFILES_DIR/config/alacritty" "$CONFIG_DIR/alacritty"
    link_config "$DOTFILES_DIR/config/hypr" "$CONFIG_DIR/hypr"
    link_config "$DOTFILES_DIR/config/waybar" "$CONFIG_DIR/waybar"
    link_config "$DOTFILES_DIR/config/fuzzel" "$CONFIG_DIR/fuzzel"
    link_config "$DOTFILES_DIR/config/mako" "$CONFIG_DIR/mako"
    link_config "$DOTFILES_DIR/config/nvim" "$CONFIG_DIR/nvim"
    link_config "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
    link_config "$DOTFILES_DIR/bin/dictar" "$HOME/.local/bin/dictar"

    success "Symlinks created."
}

# ============================================================
# System services
# ============================================================

enable_services() {
    info "Enabling system services..."

    sudo systemctl enable --now NetworkManager 2>/dev/null || true
    sudo systemctl enable docker 2>/dev/null || true

    # Add user to docker group
    if ! groups "$USER" | grep -q docker; then
        sudo usermod -aG docker "$USER"
        warn "Added to docker group. Log out and back in for it to take effect."
    fi

    success "Services enabled."
}

# ============================================================
# Main
# ============================================================

main() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║   Arch Linux Dotfiles Installer      ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"
    echo ""

    install_pacman_packages
    install_yay
    install_aur_packages
    setup_symlinks
    enable_services

    echo ""
    echo -e "${GREEN}══════════════════════════════════════${NC}"
    echo -e "${GREEN} Installation complete!${NC}"
    echo -e "${GREEN}══════════════════════════════════════${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Reboot: sudo reboot"
    echo "  2. Log in on the TTY and run: start-hyprland"
    echo "  3. Download the dictation model (see README, \"Dictation\")"
    echo ""
}

main "$@"

