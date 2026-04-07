#!/bin/bash

# --- 1. CONFIGURATION & ARRAYS ---

DOTFILES_DIR="$HOME/dotfiles"

CONFIGS=(bash doom hypr kitty dunst fastfetch waybar mpd mpv nvim rmpc starship gtk-3.0 gtk-4.0)

SERVICES=(NetworkManager bluetooth sddm syncthing)

# Native Packages

SYSTEM=(base base-devel linux linux-headers linux-lts linux-lts-headers linux-firmware intel-ucode efibootmgr sudo cronie smartmontools timeshift git stow)

HARDWARE=(nvidia-open-dkms libva-nvidia-driver bluez bluez-utils blueman pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber libpulse gst-plugin-pipewire gst-plugins-bad gst-plugins-base gst-plugins-ugly)

NETWORK=(networkmanager network-manager-applet iwd wireless_tools wpa_supplicant wget)

DESKTOP=(hyprland uwsm xdg-desktop-portal-hyprland xdg-utils hyprpolkitagent polkit-kde-agent qt5-wayland qt6-wayland qt5-graphicaleffects qt5-quickcontrols2 qt5-svg qqc2-desktop-style sddm)

TERMINAL=(kitty starship zoxide fzf fd eza bat btop fastfetch gdu tree-sitter-cli unzip)

APPS=(dolphin imv mpv qbittorrent spotify-launcher zathura zathura-cb zathura-pdf-mupdf zenity proton-vpn-gtk-app syncthing)

UTILS=(waybar dunst libnotify cliphist slurp grim hyprpicker awww)

DEV=(git npm emacs luarocks luacheck lua-jsregexp hunspell hunspell-en_us)

FONTS=(inter-font otf-atkinson-hyperlegible ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols)

# AUR Packages

AUR_PKGS=(waypaper hyprshade localsend-bin neovim-git vicinae-bin zen-browser-bin readest rmpc)

set -e
echo "󰣇 Starting Full System Deployment..."

# --- CLONE DOTFILES ---
if [ ! -d "$DOTFILES_DIR" ]; then
	echo "󰚺 Dotfiles not found. Cloning from GitHub..."
	git clone https://github.com/username/repo-name.git "$DOTFILES_DIR"
else
	echo "✔ Dotfiles directory already exists."
fi

# --- 2. NATIVE INSTALL ---
echo "Step 1: Installing Native Packages..."
ALL_NATIVE=("${SYSTEM[@]}" "${HARDWARE[@]}" "${NETWORK[@]}" "${DESKTOP[@]}" "${TERMINAL[@]}" "${APPS[@]}" "${UTILS[@]}" "${DEV[@]}" "${FONTS[@]}")
sudo pacman -Syu --needed --noconfirm "${ALL_NATIVE[@]}"

# --- 3. AUR HELPER (YAY) ---
if ! command -v yay &>/dev/null; then
	echo "Step 2: Building yay..."
	sudo rm -rf /tmp/yay
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay && makepkg -si --noconfirm && cd -
fi

# --- 4. AUR INSTALL ---
echo "Step 3: Installing AUR Packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# --- 5. DOTFILES DEPLOYMENT (STOW) ---
echo "Step 4: Symlinking Dotfiles..."
if [ -d "$DOTFILES_DIR" ]; then
	# Remove default bashrc to avoid Stow conflicts
	[ -f "$HOME/.bashrc" ] && rm "$HOME/.bashrc"

	cd "$DOTFILES_DIR"
	for config in "${CONFIGS[@]}"; do
		stow -R "$config"
		echo "  ✔ Stowed $config"
	done
else
	echo "✘ Error: $DOTFILES_DIR not found!"
fi

# --- 6. SDDM THEME SETUP ---
echo "Step 5: Configuring SDDM Theme..."
THEME_NAME="nier-automata" # Ensure this matches your folder name in dotfiles
if [ -d "$DOTFILES_DIR/sddm-theme" ]; then
	sudo mkdir -p "/usr/share/sddm/themes/$THEME_NAME"
	sudo cp -r "$DOTFILES_DIR/sddm-theme/." "/usr/share/sddm/themes/$THEME_NAME"
	sudo bash -c "cat > /etc/sddm.conf <<EOF
[Theme]
Current=$THEME_NAME
EOF"
fi

# --- 7. EDITOR INITIALIZATION ---
echo "Step 6: Initializing Doom Emacs & Neovim..."
# Doom Emacs
if [ ! -d "$HOME/.config/emacs" ]; then
	git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
	~/.config/emacs/bin/doom install --env --fonts --force
fi

# --- 8. SERVICES ---
echo "Step 7: Enabling Services..."
for s in "${SERVICES[@]}"; do
	sudo systemctl enable "$s"
done

echo -e "\n\033[1;32m󰄬 ARCH DEPLOYMENT COMPLETE.\033[0m"
echo "Check your GPU drivers and reboot."
