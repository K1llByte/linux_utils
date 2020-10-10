# Arch Install

## Base Instructions

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

pacman -S networkmanager git
```