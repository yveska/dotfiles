# Disable the greeting
set -g fish_greeting ""

# Environment Variables
set -gx EDITOR nvim
fish_add_path "$HOME/.config/emacs/bin"

# Initialization
starship init fish | source
fzf --fish | source
zoxide init fish | source

# Aliases
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='eza -la --group-directories-first --icons=auto'
alias grep='grep --color=auto'
alias ff='nvim (fzf -m)'
alias vim='nvim'

# Zoxide
function cd
    if count $argv > /dev/null
        if test -d $argv[1]
            builtin cd $argv[1]
        else
            z $argv
            printf "\U000F17A9 "
            pwd
        end
    else
        builtin cd ~
    end
end

# Yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# FZF Styling
set -gx FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always {}' --layout=reverse --exact --border=bold --border=rounded --margin=3% --color=dark"
