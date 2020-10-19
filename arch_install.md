# Arch Install

## Index

- [Settings](#settings)
- [Base Install](#base-install)
- [Aftermath](#aftermath)
- [Config Files](#config-files)

___

## Settings

### Software

- i3-gaps - Windows Manager
- rofi - App Launcher
- urxvt - Terminal Emulator
- i3lock - Lockscreen
- feh - Image viewer
- chromium - Browser
- htop - Resources Manager (CPU etc ...)
- picom/compton - Compositor
- Xarchiver - Unified archives zipper and unzipper
- maim - Screenshot tool
- notify-send - Notification applet

### Extensions

- Thunar: tumbler - Extension for file thumbnails preview
- Thunar: thunar-archive-plugin - Extension for extract and compress
- Thunar: gvfs - Extension for trash support, mounting removable media, and remote filesystems

___

## Base Install

```bash
# Load PT keyboard layout
loadkeys pt-latin1

# Connect to wifi using 'iwctl'
# 'device' usually wifi adaptor wlan0
# 'SSID' wifi network name
iwctl --passphrase wifi_password station device connect SSID

# Update the system clock
timedatectl set-ntp true

# List disks devices
fdisk -l

# Format target disk (apply options in fdisk shell)
fdisk /dev/target_disk

# Make Linux filesystem
mkfs.ext4 /dev/root_partition

# Make swap partition
mkswap /dev/swap_partition

# Mount the root volume to /mnt
mount /dev/root_partition /mnt

# Enable swap volume
swapon /dev/swap_partition

# Install base system
pacstrap /mnt base linux linux-firmware

# Generate filesystem table
genfstab -U /mnt >> /mnt/etc/fstab

# Login as root in the newlly mounted arch install
arch-chroot /mnt

# Set timezone
ln -sf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime

# Set hardware clock (generates /etc/adjtime)
hwclock --systohc

# Generate locale.gen
locale-gen # Perhaps optional

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=pt-latin1" > /etc/vconsole.conf
echo "myhostname" > /etc/hostname

echo -e "127.0.0.1 localhost\n::1 localhost\n127.0.1.1 myhostname.localdomain	myhostname" > /etc/hosts

passwd

############ Finished Arch base install ############

# User creation and group assignment
useradd -m kb
passwd kb
usermod -aG wheel,audio,video,optical,storage kb

pacman -S sudo

visudo

pacman -S networkmanager

systemctl enable NetworkManager
```

## Aftermath
```bash
# Find graphics card
lspci -k | grep -A 2 -E "(VGA|3D)"

# Install Graphics drivers and some Display server
# 'nvidia'               Graphics drivers
# 'xorg' && 'xorg-xinit' Display server
# 'nitrogen'             X11 wallpaper setter
# 'picom'                Compositor
# 'chromium'             Browser
# 'git'                  Version Control System
# 'base-devel'           (Needed for package buildinng)
# 'rxvt-unicode'         Terminal Emulator
sudo pacman -S nvidia xorg xorg-xinit nitrogen urxvt chromium git base-devel rxvt-unicode

# Install AUR
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd ..
yes | rm -r yay-git

# Install Window Manager
yay -S i3-gaps

# Copy default xinit config to home 
cp /etc/X11/xinit/xinitrc /home/kb/.xinitrc
# Edit .xinitrc to start i3 instead of X11 default WM twm and xterm

startx

# Install Audio drivers
yay -S alsa-utils

alsamixer
```

___

## Config files


### i3
`~/.config/i3/config`

### i3blocks
`~/.config/i3blocks/config`

### urxvt
`~/.Xresources`

### rofi
`~/.config/rofi/`

### picom
`/etc/xdg/picom.conf`

### neofetch
`~/.config/neofetch/`

### vscode
`~/.config/Code\ -\ OSS/User/keybindings.json`

### GTK
`~/.gtkrc-2.0`
`~/.gtkrc-2.0.mine`

### Thunar
`~/.config/Thunar/accels.scm`