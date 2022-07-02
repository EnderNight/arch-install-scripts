#!/bin/bash

# Base packages
yay -S plasma kde-applications materia-kde papirus-icon-theme code unityhub gimp inkscape chromium discord audacity lmms vlc obs-studio libreoffice-fresh ttf-gentium-basic adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts hunspell hunspell-fr hunspell-en hyphen hyphen-fr libmythes mythes-fr libreoffice-extension-languagetool jre8-openjdk libreoffice-extension-grammalecte-fr openrazer-meta polychromatic linux-lts linux-lts-headers linux-zen linux-zen-headers

# Display manager
systemctl enable sddm

# Open razer
sudo gpasswd -a ender plugdev

# Regenerating grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg

# More settings can be setup after restarting...

printf "\e[0:31mDone ! Restarting in 5 sec...\e[m"
sleep 5
reboot
