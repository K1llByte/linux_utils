#!/bin/bash

########### Function Utils ###########

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

########### Config Installs ###########

# Install other requirements
other_requirements() {
    # Install
    [[ -z $(yay -Qi nerd-fonts-roboto-mono) ]] && \
        yay -S --noconfirm nerd-fonts-roboto-mono
    [[ -z $(yay -Qi ttf-nerd-fonts-symbols) ]] && \
        yay -S --noconfirm ttf-nerd-fonts-symbols
    [[ -z $(yay -Qi noto-fonts-emoji) ]] && \
        yay -S --noconfirm noto-fonts-emoji
    [[ -z $(yay -Qi ttf-fantasque-sans-mono) ]] && \
        yay -S --noconfirm ttf-fantasque-sans-mono
    print_colored "Installed fonts"
}

# TODO: xorg (xinitrc)

# Install and configure i3-gaps
i3gaps() {
    # Install
    [[ -z $(yay -Qi i3-gaps) ]] && \
        yay -S --noconfirm i3-gaps
    # Configs
    cpcpr configs/i3/ ~/.config/
    print_colored "Installed i3-gaps"
}

# Install and configure polybar
polybar() {
    # Install
    [[ -z $(yay -Qi polybar) ]] && \
        yay -S --noconfirm polybar
    # Configs
    cpcpr configs/polybar/ ~/.config/
    print_colored "Installed polybar"
}

# Install and configure vscode
vscode() {
    # Install
    [[ -z $(yay -Qi code) ]] && \
        yay -S --noconfirm code
    # Configs
    cpcp configs/vscode/User/keybindings.json "$HOME/.config/Code - OSS/User/"
    cpcp configs/vscode/User/settings.json "$HOME/.config/Code - OSS/User/"
    print_colored "Installed vscode"
}

# Install and configure polybar
alacritty() {
    # Install
    [[ -z $(yay -Qi alacritty) ]] && \
        yay -S --noconfirm alacritty
    # Configs
    cpcpr configs/alacritty/ ~/.config/
    print_colored "Installed alacritty"
}

bash_utils() {
    # Configs
    cpcp configs/bash/.bashrc ~/
    cpcp configs/bash/.bash_profile ~/
    cpcp configs/bash/aliases.sh ~/.config/
    # Scripts
    cpcp scripts/auto_alias.sh ~/.scripts/
    cpcp scripts/homes.sh ~/.scripts/
    cpcp scripts/utils.sh ~/.scripts/
    print_colored "Installed bash utilities"
}

rofi() {
    # Install
    [[ -z $(yay -Qi rofi) ]] && \
        yay -S --noconfirm rofi
    [[ -z $(yay -Qi rofi-emoji) ]] && \
        yay -S --noconfirm rofi-emoji
    # Configs
    cpcpr configs/rofi/ ~/.config/
    print_colored "Installed rofi"
}

# Install and configure dunst
dunst() {
    # Install
    [[ -z $(yay -Qi dunst) ]] && \
        yay -S --noconfirm dunst
    # Configs
    cpcpr configs/dunst/ ~/.config/
    # TODO: i3 config initializes dunst
    # but to use it on install it must be
    # nitialized here too without being
    # bound to the terminal
    print_colored "Installed dunst"
}

# Install and configure thunar
thunar() {
    # Install
    [[ -z $(yay -Qi thunar) ]] && \
        yay -S --noconfirm thunar
    [[ -z $(yay -Qi thunar-archive-plugin) ]] && \
        yay -S --noconfirm thunar-archive-plugin
    [[ -z $(yay -Qi tumbler) ]] && \
        yay -S --noconfirm tumbler
    # Configs
    cpcp configs/Thunar/accels.scm ~/.config/Thunar/
    # TODO: Missing gtk theme config
    print_colored "Installed thunar"
}

randr() {
    # Install
    [[ -z $(yay -Qi arandr) ]] && \
        yay -S --noconfirm arandr
    [[ -z $(yay -Qi autorandr) ]] && \
        yay -S --noconfirm autorandr
}

# TODO: firefox
# TODO: picom

########### All Installs ###########

# other_requirements
# i3gaps
# polybar
# vscode
# bash_utils
# alacritty
# rofi
# dunst
thunar