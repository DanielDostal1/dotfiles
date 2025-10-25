#
# ~/.bashrc
#

eval "$(starship init bash)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -lah --color=auto'
alias gs='git status'
alias grep='grep --color=auto'

alias warm='pkill wlsunset; wlsunset -t 4000 -T 4500 -d 0'
alias cool='pkill wlsunset; wlsunset -t 6500 -T 6500 -d 0'
alias ultra_warm='pkill wlsunset; wlsunset -t 3600 -T 3700 -d 0'

PS1='[\u@\h \W]\$ '
# PS1=`\[\e[1;32m\]\u@\h \[\e[1;34m\]\w \$\[\e[0m\] '
export LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32"
export CLICOLOR=1
set -o vi

source /usr/share/nvm/init-nvm.sh

[ -f "/home/daniel/.ghcup/env" ] && . "/home/daniel/.ghcup/env" # ghcup-env


export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
