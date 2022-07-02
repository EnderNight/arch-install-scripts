#!/bin/bash

# This script requires the script base.sh.
# This script is made to install a basic arch linux desktop system. The prefered usage is to launch a [de].sh script after this one.



# Package management
sed -i '37s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
sed -i '94s/.//' /etc/pacman.conf

git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -sci
cd ..
rm -r yay/

yay -Suy




# Needed packages
# This packages are installed now to keep the base.sh script fast.

yay -S --noconfirm base-devel linux-headers neofetch reflector mkinitcpio-numlock xorg htop firefox cpupower cpupower-gui power-profiles-daemon pulseaudio pulseaudio-alsa firewalld bind cups cups-pdf avahi nss-mdns $(pacman -Ssq ttf | grep -v ttf-nerd-fonts-symbols-mono) p7zip rar zip





# Users and groups
useradd -m ender
passwd ender
usermod -aG wheel ender
echo "ender ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/ender




# Booting
echo "Place 'numlock' hook in the hooks section"
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
exit
else echo "waiting for keypress"
fi
done
echo "numlock" >> /etc/mkinitcpio.conf
vim /etc/mkinitcpio.conf






# Graphical user interface
# uncomment lines to install appropriate drivers

yay -S --noconfirm xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau ## AMD

#yay -S --noconfirm xf86-video-intel mesa lib32-mesa vulkan-intel intel-media-driver libvdpau-va-gl ## Intel

#yay -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings ## NVIDIA





# Power management
systemctl enable cpupower
systemctl enable power-profles-daemon





# Networking
systemctl enable named
systemctl enable firewalld





# System services
systemctl enable cups
systemctl enable avahi-daemon
echo "Place 'mdns_minimal [NOTFOUND=return] before resolve and dns in the hosts line"
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
exit
else echo "waiting for keypress"
fi
done
echo "mdns_minimal [NOTFOUND=return]" >> /etc/nsswitch.conf
vim /etc/nsswitch.conf





printf "\e[0;31mDone ! Rebooting in 5 secs...\e[m"
sleep 5
reboot
