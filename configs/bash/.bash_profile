# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Vars
#export PATH="$PATH:$HOME/.scripts"

# If there is no greeter, may the tty login screen automaticly luanch startx frontend
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx

export TERMINAL='alacritty'
export BROWSER='firefox'
export EDITOR='code'
export VISUAL='code'
export RTV_EDITOR='code'

# Export locale vars (May not be needed)
export LC_ALL=C
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8