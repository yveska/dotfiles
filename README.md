# My Current Arch Dotfiles!

On clean install, ensure you install yay manually and run the script outside of chroot. 

Once install is finished, ~/dotfiles/ will be in read-only. Run "sudo chown -R $USER:$USER dotfiles" to give yourself access

It is better to start mpd as a service manually (systemctl --user enable --now mpd)
