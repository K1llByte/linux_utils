# ~/.bashrc

# $$\                           $$\                           
# $$ |                          $$ |                          
# $$$$$$$\   $$$$$$\   $$$$$$$\ $$$$$$$\   $$$$$$\   $$$$$$$\ 
# $$  __$$\  \____$$\ $$  _____|$$  __$$\ $$  __$$\ $$  _____|
# $$ |  $$ | $$$$$$$ |\$$$$$$\  $$ |  $$ |$$ |  \__|$$ /      
# $$ |  $$ |$$  __$$ | \____$$\ $$ |  $$ |$$ |      $$ |      
# $$$$$$$  |\$$$$$$$ |$$$$$$$  |$$ |  $$ |$$ |      \$$$$$$$\ 
# \_______/  \_______|\_______/ \__|  \__|\__|       \_______|

##############################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

################################### VARS #####################################

#COLORS
RED='\033[0;31m'
CYAN='\e[38;5;36m'
WHITE='\e[38;5;7m'
YELLOW='\e[38;5;220m'

#ATRIBUTES
BOLD='\033[1m'
DIM='\e[2m'
UNDERLINE='\e[4m'
BLINK='\e[5m'
INVERTED='\e[7m'
HIDDEN='\e[8m'
RESET='\e[0m'
OFF=$RESET

# COMPOUND
BOLD_YELLOW="\033[1;38;5;220m"

# Some terminal emulators execute this argument 
PROMPT_COMMAND='' # ='printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

#PS1="${BOLD}${YELLOW}\u${RESET}${BOLD} \W${YELLOW} >${RESET} "
PS1="$(__c "$BOLD_YELLOW" "\u") $(__c "$BOLD" "\W") $(__c "$BOLD_YELLOW" ">") "

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

#TERM=rxvt-unicode-256color

export PATH=$PATH:$HOME/.local/bin
export EDITOR=code
export BROWSER=chromium

source $HOME/.config/aliases.sh

# Escute scripts in respective folder
[ -d "$HOME/.scripts" ] && for s in $HOME/.scripts/*; do [ ! -d $s ] && source $s ; done
