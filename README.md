# My Current Arch Dotfiles!

## Instructions
1. Do a clean, minimal (type) arch install. 
2. Install yay manually and git clone repository (must not be in chroot)
3. If ~/dotfiles/ is in read-only, do "sudo chown -R $USER:$USER dotfiles" to give yourself access
4. Start mpd manually, works better "systemctl --user enable --now mpd"

## Misc
- To restore homepage in Zen-Browser, go to about:config and disable "zen.urlbar.replace-newtab"
- Zen-Browser extensions used are Ublock, Leechblock NG, Unhook, and Vimium.
- For Zotero integration with Emacs, make sure to install the Better BibTeX plugin within Zotero. Also, do a library export and make sure you enable 'Keep Updated'.

## Credit
- Shader.lua in ~/.config/hypr and glsl shaders in ~/.config/hypr/shaders/ were from [Snes19xx](https://github.com/snes19xx/surface-dots).
