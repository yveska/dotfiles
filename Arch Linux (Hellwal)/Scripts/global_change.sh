#! /sbin/bash

# Set wallpaper directory
Wallpapers_Folder=/home/yuki/Sync/Wallpapers/

# Generate colors from random wallpaper in folder
hellwal -i $Wallpapers_Folder -r --neon-mode

# Import variables from wallpaper
source ~/.cache/hellwal/variables.sh

# Set Wallpapers
swww img $wallpaper --transition-type wipe --transition-duration 0.8

# Update Rofi
cp ~/.cache/hellwal/rofi.rasi ~/.config/rofi/config.rasi

# Pywalfox
cp ~/.cache/hellwal/colors.json ~/.cache/wal/colors.json
pywalfox update

# Spotify (Spicetify)
#cp -r $HOME/.cache/hellwal/colors-spicetify.ini $HOME/.config/spicetify/Themes/Pywal
#cd $HOME/.config/spicetify/Themes/Pywal
#mv colors-spicetify.ini color.ini

# Reload waybar
pkill waybar && exec waybar
