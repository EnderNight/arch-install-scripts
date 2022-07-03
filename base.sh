#!/bin/bash

# Base installation
# packages needed : base linux linux-firmware git vim *-ucode (+ fs packages)

pacman -S --noconfirm networkmanager man-db man-pages texinfo grub efibootmgr base-devel linux-headers neofetch reflector

# Time zone
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
timedatectl set-ntp true
hwclock --systohc

# Localization
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
sed -i 's/#fr_FR.UTF-8/fr_FR.UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Network configuration
echo "Arch" >> /etc/hostname
systemctl enable NetworkManager

# Initramfs
vim /etc/mkinitcpio.conf
mkinitcpio -P

# Root password
passwd

# Boot loader
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Users and groups
useradd -m ender
passwd ender
usermod -aG wheel ender
echo "ender ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/ender
mv /arch-install-scripts/ /home/ender/
chown -R ender:ender /home/ender/arch-install-scripts/

# Package management
systemctl enable reflector.timer

# Poweroff
printf "\e[0;31mDone ! Exiting in 5 sec...\n\e[m"
sleep 5
exit
