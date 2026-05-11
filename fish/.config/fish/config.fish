# Disable the greeting
set -g fish_greeting ""

# Environment Variables
set -gx EDITOR nvim
set -gx BROWSER zen-browser
set -Ux XDG_CONFIG_HOME $HOME/.config
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

# Colorscheme
set -g fish_color_command ffffff --bold
set -g fish_color_keyword d1d1d1        
set -g fish_color_quote 8a8a8a           
set -g fish_color_redirection a0a0a0      
set -g fish_color_end 707070               

# Parameters, paths, and variables
set -g fish_color_param c0c0c0              
set -g fish_color_valid_path --underline     
set -g fish_color_option 9a9a9a               

# System states and feedback
set -g fish_color_error d75f5f --bold  
set -g fish_color_comment 585858 --italics   
set -g fish_color_selection --background=2a2a2a 
set -g fish_color_operator cfcfcf          
set -g fish_color_escape 8a8a8a             

set -g fish_color_autosuggestion 4e4e4e      
