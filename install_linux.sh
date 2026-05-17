#!/bin/bash

# --- 1. CONFIGURATION & ARRAYS ---

DOTFILES_DIR="$HOME/dotfiles"

CONFIGS=(dunst hypr kitty nvim sioyek starship waybar)

SERVICES=(NetworkManager bluetooth sddm)

# Native Packages

SYSTEM=(base base-devel linux linux-headers linux-firmware intel-ucode efibootmgr sudo cronie smartmontools timeshift git stow)

HARDWARE=(nvidia-open-dkms libva-nvidia-driver bluez bluez-utils blueman pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber libpulse gst-plugin-pipewire gst-plugins-bad gst-plugins-base gst-plugins-ugly)

NETWORK=(networkmanager wget)

DESKTOP=(hyprland uwsm xdg-desktop-portal-hyprland xdg-utils hyprpolkitagent qt5-wayland qt6-wayland qt5-graphicaleffects qt5-quickcontrols2 qt5-svg qt6-5compat qt6-multimedia qt6-multimedia-ffmpeg qqc2-desktop-style sddm)

TERMINAL=(kitty zoxide starship fzf fd eza bat btop gdu tree-sitter-cli unzip)

APPS=(obsidian dolphin gvfs ntfs-3g tumbler imv mpv qbittorrent proton-vpn-gtk-app syncthing)

UTILS=(waybar pavucontrol dunst libnotify cliphist nwg-look slurp grim awww)

DEV=(git npm luarocks luacheck lua-jsregexp)

FONTS=(inter-font otf-atkinson-hyperlegible ttf-jetbrains-mono-nerd)

# AUR Packages

AUR_PKGS=(zotero-bin sioyek-dev localsend-bin vicinae-bin zen-browser-bin)

set -e
echo "󰣇 Starting Full System Deployment..."

# --- 2. NATIVE INSTALL ---
echo "Step 1: Installing Native Packages..."
ALL_NATIVE=("${SYSTEM[@]}" "${HARDWARE[@]}" "${NETWORK[@]}" "${DESKTOP[@]}" "${TERMINAL[@]}" "${APPS[@]}" "${UTILS[@]}" "${DEV[@]}" "${FONTS[@]}")
sudo pacman -Syu --needed --noconfirm "${ALL_NATIVE[@]}"

# --- 3. AUR INSTALL ---
echo "Step 2: Installing AUR Packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# --- 3.5 FONT INSTALL ---
echo "Step 3.5: Installing IoskeleyMonoTerm Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts/ioskeley"
if [ ! -d "$FONT_DIR" ]; then
	mkdir -p "$FONT_DIR"
	curl -L -o /tmp/ioskeley.zip https://github.com/ahatem/IoskeleyMono/releases/download/v2.0.0/IoskeleyMono-Term-NerdFont.zip
	unzip -o /tmp/ioskeley.zip -d "$FONT_DIR"
	rm /tmp/ioskeley.zip
	fc-cache -f
	echo "  ✔ IoskeleyMono installed."
else
	echo "  󰄬 IoskeleyMono already present, skipping."
fi

# --- 4. DOTFILES DEPLOYMENT (STOW) ---
echo "Step 3: Symlinking Dotfiles..."
if [ -d "$DOTFILES_DIR" ]; then
	[ -f "$HOME/.bashrc" ] && rm "$HOME/.bashrc"

	cd "$DOTFILES_DIR"
	for config in "${CONFIGS[@]}"; do
		stow -R "$config"
		echo "  ✔ Stowed $config"
	done
else
	echo "✘ Error: $DOTFILES_DIR not found!"
fi

chmod +x "$HOME"
chmod +x "$DOTFILES_DIR"

# --- 5. SDDM THEME SETUP ---
echo "Step 4: Symlinking SDDM Theme with Stow..."
THEME_NAME="orbital"

if [ -d "$DOTFILES_DIR/sddm-theme" ]; then
	# 1. Create the system directory if it doesn't exist
	sudo mkdir -p /usr/share/sddm/themes

	# 2. Use Stow with the --target (-t) flag.
	# This tells Stow to link INTO /usr/share/sddm/themes instead of $HOME.
	sudo stow -d "$DOTFILES_DIR" -t /usr/share/sddm/themes sddm-theme

	# 3. Apply the config
	sudo bash -c "cat > /etc/sddm.conf <<EOF
[Theme]
Current=$THEME_NAME
EOF"
	echo "  ✔ SDDM theme stowed to system."
fi

# --- 7. SERVICES ---
echo "Step 6: Enabling Services..."
for s in "${SERVICES[@]}"; do
	sudo systemctl enable "$s"
done

echo -e "\n\033[1;32m󰄬 ARCH DEPLOYMENT COMPLETE.\033[0m"
echo "Check your GPU drivers and reboot."
