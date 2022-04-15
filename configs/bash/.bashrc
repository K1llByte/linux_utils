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

################################### VARS #####################################

# TODO: make this a file
#COLORS
RED='\[\e[0;31m\]'
CYAN='\[\e[0;36m\]'
# CYAN='\e[38;5;36m'
WHITE='\[\e[38;5;7m\]'
YELLOW='\[\e[38;5;220m\]'

#ATRIBUTES
BOLD='\[\e[1m\]'
DIM='\[\e[2m\]'
UNDERLINE='\[\e[4m\]'
BLINK='\[\e[5m\]'
INVERTED='\[\e[7m\]'
HIDDEN='\[\e[8m\]'
RESET='\[\e[0m\]'

# COMPOUND
BOLD_CYAN="\[\e[1;36m\]"

MAIN_COLOR=$BOLD_CYAN

# Some terminal emulators execute this argument 
PROMPT_COMMAND='' # ='printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

#PS1="${BOLD}${YELLOW}\u${RESET}${BOLD} \W${YELLOW} >${RESET} "

# Set PS1
PS1="$MAIN_COLOR\u$RESET $BOLD\W$RESET $MAIN_COLOR>$RESET "

# Load bash completion
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

#TERM=rxvt-unicode-256color

# Export variables
# TODO: This shouldn't be here, get a
# better way to automate this later
# export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/opt/cuda/bin
export EDITOR='code'
export TERMINAL='alacritty'
export BROWSER='firefox-developer-edition'
export PYTHONSTARTUP=~/.config/python/pythonrc

export LC_ALL=C
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Source aliases if available
[ -f $HOME/.config/aliases.sh ] && source $HOME/.config/aliases.sh

# Source all scripts in respective folder
[ -d "$HOME/.scripts" ] && for s in $HOME/.scripts/*; do [ ! -d $s ] && source $s ; done