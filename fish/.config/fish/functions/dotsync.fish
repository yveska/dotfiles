function dotsync
    cd ~/dotfiles
    git add .
    git commit -m "update: "(date +%Y-%m-%d_%H:%M)
    git push
    cd -
end
