#
# ~/.bashrc
#

eval "$(starship init bash)"
eval "$(fzf --bash)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='eza -la --group-directories-first --icons=auto'
alias grep='grep --color=auto'
alias ff='nvim $(fzf -m)'
alias vim='nvim'

eval "$(zoxide init bash)"
alias cd='zd'
zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ && return
  elif [ -d "$1" ]; then
    builtin cd "$1"
  else
    z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}

export EDITOR=nvim
export PATH="$HOME/.config/emacs/bin:$PATH"
export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always {}' --layout=reverse --exact --border=bold --border=rounded --margin=3% --color=dark"

PS1='[\u@\h \W]\$ '

#eval "$(mise activate bash)"
