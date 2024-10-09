#!/bin/bash

# Function to prompt user for input
confirm() {
    while true; do
        read -p "$1 [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# System update and install yay
if confirm "Would you like to update the system and install yay?"; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
else
    echo "Skipping system update and yay installation."
fi

# Base system components
if confirm "Install base system components (Hyprland, Waybar, Pipewire, etc.)?"; then
    yay -Sy --noconfirm hyprland hyprlock hypridle xdg-desktop-portal-hyprland hyprpicker \
      swww waybar waybar-updates rofi-wayland swaync wl-clipboard cliphist swayosd-git \
      brightnessctl udiskie devify polkit-gnome playerctl pyprland grim slurp
else
    echo "Skipping base system component installation."
fi

# CLI/TUI tools
if confirm "Install CLI/TUI tools?"; then
    yay -Sy --noconfirm fastfetch fzf jq eza fd vivid fish starship ripgrep bat yazi \
      zoxide atuin lazygit lazynpm lazydocker pacseek cava btop nvtop fastfetch onefetch keyb \
      navi tldr
else
    echo "Skipping CLI/TUI tools installation."
fi

# GUI apps
if confirm "Install GUI applications (Neovim, Nemo, MPV, etc.)?"; then
    yay -Sy --noconfirm pavucontrol satty nemo zathura zathura-pdf-mupdf qimgv-light mpv \
      obs-studio spotify spicetify vscodium zen-browser thunderbird obsidian \
      easyeffects krita virt-manager libreoffice vesktop
else
    echo "Skipping GUI applications installation."
fi

# Fonts
if confirm "Install fonts (JetBrains Mono, Nerd Fonts, etc.)?"; then
    yay -Sy --noconfirm ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono \
      ttf-nerd-fonts-symbols-common ttf-font-awesome noto-fonts-cjk ttf-ms-win11-auto
    fc-cache -fv
else
    echo "Skipping fonts installation."
fi

# Color theme
if confirm "Install GTK/QT color themes (Catppuccin)?"; then
    yay -Sy --noconfirm catppuccin-gtk-theme-macchiato catppuccin-cursors-macchiato \
      qt5ct qt5-wayland qt6-wayland kvantum kvantum-qt5 nwg-look
else
    echo "Skipping color theme installation."
fi

# Icon theme
if confirm "Install Catppuccin-SE icon theme?"; then
    curl -LJO https://github.com/ljmill/catppuccin-icons/releases/download/v0.2.0/Catppuccin-SE.tar.bz2
    tar -xf Catppuccin-SE.tar.bz2
    mv Catppuccin-SE ~/.local/share/icons/
else
    echo "Skipping icon theme installation."
fi

# AMD drivers
if confirm "Install AMD drivers (Open Source)?"; then
    yay -Sy --noconfirm xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon vulkan-tools \
      opencl-clover-mesa lib32-opencl-clover-mesa libva-mesa-driver lib32-libva-mesa-driver \
      mesa lib32-mesa mesa-vdpau lib32-mesa-vdpau vdpauinfo clinfo
else
    echo "Skipping AMD drivers installation."
fi

# Yadm and dotfiles
if confirm "Set up dotfile management with yadm?"; then
    yay -Sy --noconfirm yadm
    yadm clone https://github.com/Matt-FTW/dotfiles.git
else
    echo "Skipping yadm and dotfiles setup."
fi

# Final message
echo "Setup complete. Please log out and select Hyprland as your session, or run 'Hyprland' from the terminal."
