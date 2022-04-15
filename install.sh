#!/bin/bash

############## Options ###############

# Install bash utils for root user
# ROOT_BASH_UTILS=1

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

########### Config Installs ##########

# Install other requirements
other_requirements() {
    # Install
    # Fonts
    [[ -z $(yay -Qi nerd-fonts-roboto-mono) ]] && \
        yay -S --noconfirm nerd-fonts-roboto-mono
    [[ -z $(yay -Qi ttf-nerd-fonts-symbols) ]] && \
        yay -S --noconfirm ttf-nerd-fonts-symbols
    [[ -z $(yay -Qi noto-fonts-emoji) ]] && \
        yay -S --noconfirm noto-fonts-emoji
    [[ -z $(yay -Qi ttf-fantasque-sans-mono) ]] && \
        yay -S --noconfirm ttf-fantasque-sans-mono
    print_colored "Installed fonts"

    # Other
    # Customize GTK GUI
    [[ -z $(yay -Qi lxappearance) ]] && \
        yay -S --noconfirm lxappearance
    # Bash completions
    [[ -z $(yay -Qi bash-completion) ]] && \
        yay -S --noconfirm bash-completion
    
    
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

# Install and configure gtk (for thunar)
gtk() {
    # Install
    [[ -z $(yay -Qi gruvbox-material-gtk-theme-git) ]] && \
        yay -S --noconfirm gruvbox-material-gtk-theme-git
    # Configs
    cpcp configs/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
    cpcp configs/gtk/settings.ini ~/.config/gtk-3.0
    print_colored "Installed gtk"
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
    [[ -z $(yay -Qi ultra-flat-icons-orange) ]] && \
        yay -S --noconfirm ultra-flat-icons-orange
    [[ -z $(yay -Qi gruvbox-material-gtk-theme-git) ]] && \
        yay -S --noconfirm gruvbox-material-gtk-theme-git
    # Configs
    cpcp configs/Thunar/accels.scm ~/.config/Thunar/
    gtk
    print_colored "Installed thunar"
}

# Install and configure arandr and autorandr
randr() {
    # Install
    [[ -z $(yay -Qi arandr) ]] && \
        yay -S --noconfirm arandr
    [[ -z $(yay -Qi autorandr) ]] && \
        yay -S --noconfirm autorandr
    print_colored "Installed arandr"
}

# Install and configure picom
picom() {
    # Install
    [[ -z $(yay -Qi picom) ]] && \
        yay -S --noconfirm picom
    # Configs
    cpcp configs/picom/picom.conf ~/.config/
    print_colored "Installed picom"
}

# Install and configure flameshot
flameshot() {
    # Install
    [[ -z $(yay -Qi flameshot) ]] && \
        yay -S --noconfirm flameshot
    # Configs
    cpcp configs/flameshot/flameshot.ini ~/.config/flameshot/
    print_colored "Installed flameshot"
}

# Install and configure firefox
firefox() {
    # Install
    [[ -z $(yay -Qi firefox-developer-edition) ]] && \
        yay -S --noconfirm firefox-developer-edition
    # Configs
    # local dest=$(echo ~/.mozilla/firefox/*dev-edition-default | awk '{print $2}')
    # cpcp configs/firefox/userChrome.css $dest/chrome
    # cpcp configs/firefox/userContent.css $dest/chrome
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
    [[ -z $(yay -Qi zathura) ]] && \
        yay -S --noconfirm zathura
    # Configs
    cpcpr configs/zathura/ ~/.config/
    print_colored "Installed zathura"
}

############ All Installs ############

other_requirements
i3gaps
polybar
vscode
bash_utils
alacritty
rofi
dunst
thunar
randr
picom
flameshot
firefox
python
zathura