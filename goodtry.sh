#!/bin/bash

# Function to check if a package is installed
is_installed() {
    pacman -Qi "$1" &> /dev/null
    return $?
}

# System update and install yay without prompts
if ! is_installed "yay"; then
    echo "Installing yay..."
    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
else
    echo "yay is already installed. Skipping yay installation."
fi

# Install base system components with Ly instead of greetd/tuigreet
BASE_COMPONENTS=("hyprland" "hyprlock" "hypridle" "xdg-desktop-portal-hyprland" "hyprpicker" 
"swww" "waybar" "waybar-updates" "rofi-wayland" "swaync" "wl-clipboard" "cliphist" "swayosd-git" 
"brightnessctl" "udiskie" "devify" "polkit-gnome" "playerctl" "pyprland" "grim" "slurp" "ly")
for package in "${BASE_COMPONENTS[@]}"; do
    if ! is_installed "$package"; then
        yay -Sy --noconfirm --needed --overwrite '*' "$package"
    else
        echo "$package is already installed. Skipping."
    fi
done

# Install CLI/TUI tools without prompts
CLI_TOOLS=("fastfetch" "fzf" "jq" "eza" "fd" "vivid" "fish" "starship" "ripgrep" "bat" "yazi" 
"zoxide" "atuin" "lazygit" "lazynpm" "lazydocker" "pacseek" "cava" "btop" "nvtop" "fastfetch" "onefetch" "keyb" 
"navi" "tldr")
for package in "${CLI_TOOLS[@]}"; do
    if ! is_installed "$package"; then
        yay -Sy --noconfirm --needed --overwrite '*' "$package"
    else
        echo "$package is already installed. Skipping."
    fi
done

# Install GUI apps without prompts
GUI_APPS=("pavucontrol" "satty" "nemo" "zathura" "zathura-pdf-mupdf" "qimgv-light" "mpv" 
"obs-studio" "spotify" "spicetify" "vscodium" "zen-browser" "thunderbird" "obsidian" 
"easyeffects" "krita" "virt-manager" "libreoffice" "vesktop")
for package in "${GUI_APPS[@]}"; do
    if ! is_installed "$package"; then
        yay -Sy --noconfirm --needed --overwrite '*' "$package"
    else
        echo "$package is already installed. Skipping."
    fi
done

# Install Fonts without prompts
FONTS=("ttf-jetbrains-mono-nerd" "ttf-nerd-fonts-symbols" "ttf-nerd-fonts-symbols-mono" 
"ttf-nerd-fonts-symbols-common" "ttf-font-awesome" "noto-fonts-cjk" "ttf-ms-win11-auto")
for package in "${FONTS[@]}"; do
    if ! is_installed "$package"; then
        yay -Sy --noconfirm --needed --overwrite '*' "$package"
    else
        echo "$package is already installed. Skipping."
    fi
done

# Refresh fonts
echo "Refreshing fonts..."
fc-cache -fv

# Install color theme for GTK/QT apps without prompts
THEMES=("catppuccin-gtk-theme-macchiato" "catppuccin-cursors-macchiato" 
"qt5ct" "qt5-wayland" "qt6-wayland" "kvantum" "kvantum-qt5" "nwg-look")
for package in "${THEMES[@]}"; do
    if ! is_installed "$package"; then
        yay -Sy --noconfirm --needed --overwrite '*' "$package"
    else
        echo "$package is already installed. Skipping."
    fi
done

# Install Icon Theme (Catppuccin-SE) without prompts if not already present
ICON_PATH="$HOME/.local/share/icons/Catppuccin-SE"
if [ ! -d "$ICON_PATH" ]; then
    echo "Installing Catppuccin-SE icon theme..."
    curl -LJO https://github.com/ljmill/catppuccin-icons/releases/download/v0.2.0/Catppuccin-SE.tar.bz2
    tar -xf Catppuccin-SE.tar.bz2
    mkdir -p ~/.local/share/icons/
    mv Catppuccin-SE ~/.local/share/icons/
else
    echo "Catppuccin-SE icon theme is already installed. Skipping."
fi

# AMD Drivers (Open Source) without prompts
AMD_DRIVERS=("xf86-video-amdgpu" "vulkan-radeon" "lib32-vulkan-radeon" "vulkan-tools" 
"opencl-clover-mesa" "lib32-opencl-clover-mesa" "libva-mesa-driver" "lib32-libva-mesa-driver" 
"mesa" "lib32-mesa" "mesa-vdpau" "lib32-mesa-vdpau" "vdpauinfo" "clinfo")
for package in "${AMD_DRIVERS[@]}"; do
    if ! is_installed "$package"; then
        yay -Sy --noconfirm --needed --overwrite '*' "$package"
    else
        echo "$package is already installed. Skipping."
    fi
done

# Set up yadm for dotfile management without prompts
if ! is_installed "yadm"; then
    yay -Sy --noconfirm --needed --overwrite '*' yadm
    yadm clone https://github.com/Matt-FTW/dotfiles.git
else
    echo "yadm is already installed. Skipping yadm setup."
fi

# Final message
echo "Setup complete. Please log out and select Hyprland as your session, or run 'Hyprland' from the terminal."
