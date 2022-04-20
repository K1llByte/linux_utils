#!/bin/bash

# Some changes might need reboot to be applied

############## Options ###############

# Install bash utils for root user
# ROOT_BASH_UTILS=1
CONFIG_PACMAN=1

########### Function Utils ###########

check_install() {
    [[ -z $(yay -Qi $1) ]] && \
        yay -S --noconfirm $1
}

print_colored() {
    echo -e "\e[1;38;5;36m$1\e[0m"
}

# Create path to dest and copy
cpcpr() {
    # mkdir -p $(dirname $2)
    mkdir -p "$2"
    cp -r $1 $2
}

cpcp() {
    mkdir -p "$2"
    cp $1 "$2"
}

########### Config Installs ##########

# Install other requirements
other_requirements() {
    # Install
    # Fonts
    check_install nerd-fonts-roboto-mono
    check_install ttf-nerd-fonts-symbols
    check_install noto-fonts-emoji
    check_install ttf-fantasque-sans-mono
    print_colored "Installed fonts"

    # Other
    # Customize GTK GUI
    check_install lxappearance
    # Bash completions
    check_install bash-completion
    # Mouse hidder
    check_install unclutter
    # Media player
    check_install mpv
    # Wallpaper setter
    check_install feh
    # Brightness controller
    check_install brightnessctl
    # Arquive zipper 
    check_install zip
    check_install unzip

    if [[ ! -z $CONFIG_PACMAN ]]; then
        # Enable pacman multilib
        LINE_NUM=$(sudo grep -n "^#\[multilib\]$" /etc/pacman.conf | awk -v FS=":" '{print $1}')
        if [ ! -z $LINE_NUM ]; then
            sudo sed -i \
                -e "${LINE_NUM}s/#\[multilib\]/\[multilib\]/g" \
                -e "$((LINE_NUM+1))s/#Include = \/etc\/pacman\.d\/mirrorlist/Include = \/etc\/pacman\.d\/mirrorlist/g" \
                /etc/pacman.conf
        fi
        # Enable pacman colors
        sudo sed -i \
            -e 's/#Color/Color/g' \
            /etc/pacman.conf
    fi

    print_colored "Installed Others"
}

# Configure i3-gaps
xorg() {
    # Configs
    cpcp configs/xorg/.xinitrc ~/
    print_colored "Configured xorg"
}

# Install and configure i3-gaps
i3gaps() {
    # Install
    check_install i3-gaps
    # Configs
    cpcpr configs/i3/ ~/.config/
    xorg
    print_colored "Installed i3-gaps"
}

# Install and configure polybar
polybar() {
    # Install
    check_install polybar
    # Configs
    cpcpr configs/polybar/ ~/.config/
    print_colored "Installed polybar"
}

# Install and configure vscode
vscode() {
    # Install
    check_install code
    check_install code-marketplace
    # Configs
    cpcp configs/vscode/User/keybindings.json "$HOME/.config/Code - OSS/User/"
    cpcp configs/vscode/User/settings.json "$HOME/.config/Code - OSS/User/"
    print_colored "Installed vscode"
}

# Install and configure polybar
alacritty() {
    # Install
    check_install alacritty
    # Configs
    cpcpr configs/alacritty/ ~/.config/
    print_colored "Installed alacritty"
}

# Install and configure bash utilities
bash_utils() {
    # Configs
    cpcp configs/bash/.bashrc ~/
    cpcp configs/bash/.bash_profile ~/
    cpcp configs/bash/aliases.sh ~/.config/
    if [[ ! -z $ROOT_BASH_UTILS ]]; then
        sudo cp configs/bash/root_bashrc /root/.bashrc
    fi
    # Scripts
    cpcp scripts/auto_alias.sh ~/.scripts/
    cpcp scripts/homes.sh ~/.scripts/
    cpcp scripts/utils.sh ~/.scripts/
    print_colored "Installed bash utilities"
}

# Install and configure rofi
rofi() {
    # Install
    check_install rofi
    check_install rofi-emoji
    # Configs
    cpcpr configs/rofi/ ~/.config/
    print_colored "Installed rofi"
}

# Install and configure dunst
dunst() {
    # Install
    check_install dunst
    # Configs
    cpcpr configs/dunst/ ~/.config/
    print_colored "Installed dunst"
}

# Install and configure gtk (for thunar)
gtk() {
    # Install
    check_install gruvbox-material-gtk-theme-git
    # Configs
    cpcp configs/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
    cpcp configs/gtk/settings.ini ~/.config/gtk-3.0
    print_colored "Installed gtk"
}

# Install and configure thunar
thunar() {
    # Install
    check_install thunar
    check_install thunar-archive-plugin
    check_install tumbler
    check_install ultra-flat-icons-orange
    # Configs
    cpcp configs/Thunar/accels.scm ~/.config/Thunar/
    gtk
    print_colored "Installed thunar"
}

sxiv() {
    # Install
    check_install sxiv
    # Configs
    cpcp configs/sxiv/.Xresources ~/
    print_colored "Installed sxiv"
}

# Install and configure arandr and autorandr
randr() {
    # Install
    check_install arandr
    check_install autorandr
    print_colored "Installed arandr"
}

# Install and configure picom
picom() {
    # Install
    check_install picom
    # Configs
    cpcp configs/picom/picom.conf ~/.config/
    print_colored "Installed picom"
}

# Install and configure flameshot
flameshot() {
    # Install
    check_install flameshot
    # Configs
    cpcp configs/flameshot/flameshot.ini ~/.config/flameshot/
    print_colored "Installed flameshot"
}

# Install and configure firefox
firefox() {
    # Install
    check_install firefox-developer-edition
    # Configs
    local dest=$(echo ~/.mozilla/firefox/*dev-edition-default | awk '{print $NF}')
    cpcp configs/firefox/userChrome.css $dest/chrome
    cpcp configs/firefox/userContent.css $dest/chrome
    print_colored "Installed firefox"
}

# Configure python
python() {
    # Configs
    cpcp configs/python/pythonrc ~/.config/python
    print_colored "Installed python"
}

# Install and configure zathura
zathura() {
    # Install
    check_install zathura
    # Configs
    cpcpr configs/zathura/ ~/.config/
    print_colored "Installed zathura"
}

setup_default_apps() {
    # NOTE: xdg-utils will already be installed
    cpcp configs/mimeapps.list ~/.config/
    xrdb ~/.Xresources
    print_colored "Configured default apps"
}

################ Usage ###############

usage() {
    echo "Usage: $0 [TAG]..."
}

############### Install ##############

# If no alguments are received everything will be installed
if [ $# == 0 ]; then
    other_requirements
    i3gaps
    polybar
    vscode
    bash_utils
    alacritty
    rofi
    dunst
    thunar
    sxiv
    randr
    picom
    flameshot
    firefox
    python
    zathura
    setup_default_apps
    exit 0
fi

# Otherwise the arguments will correspond to the functions to be called
# to install and configure the corresponding programs
while [ $# -ge 1 ]; do
    case $1 in
        "--help")
            usage
            exit 1
        ;;

        *)
            # Check if argument exists as a function
            FUNCTION_EXISTS=$(type $1 2>/dev/null | grep "function")
            if [ -z "$FUNCTION_EXISTS" ]; then
                >&2 echo -e "\e[1;31merror:\e[0m invalid argument"
                exit 1
            else
                $1
            fi
        ;;
    esac
    shift
done