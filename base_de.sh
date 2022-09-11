#!/bin/bash

# This script requires the script base.sh.
# This script is made to install a basic arch linux desktop system. The prefered usage is to launch a [de].sh script after this one.

# Package management
sudo sed -i '37s/.//' /etc/pacman.conf
sudo sed -i '93s/.//' /etc/pacman.conf
sudo sed -i '94s/.//' /etc/pacman.conf
sudo pacman -Suy

git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -sci
cd ..
rm -r yay/

yay -Suy

# Bug with dkms



# Needed packages
# This packages are installed now to keep the base.sh script fast.

yay -S mkinitcpio-numlock xorg htop firefox pulseaudio firewalld bind cups cups-pdf avahi nss-mdns $(pacman -Ssq ttf | grep -v ttf-nerd-fonts-symbols-mono) p7zip rar zip ranger linux-zen linux-zen-headers openssh duf btop ttf-ms-win10-auto beets easytag lollypop mpv


# Booting
echo "Place 'numlock' hook in the hooks section"
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
break
else echo "waiting for keypress"
fi
done
sudo vim /etc/mkinitcpio.conf
sudo mkinitcpio -P


# Graphical user interface
# uncomment lines to install appropriate drivers

#yay -S xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau ## AMD

#yay -S xf86-video-intel mesa lib32-mesa vulkan-intel intel-media-driver libvdpau-va-gl ## Intel

#yay -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings ## NVIDIA

# Optimus
#yay -S optimus-manager optimus-manager-qt


# Power management
sudo systemctl enable power-profles-daemon
# Laptop
#yay -S laptop-mode-tools
#systemctl enable laptop-mode.service


# Networking
sudo systemctl enable named
sudo systemctl enable firewalld


# System services
sudo systemctl enable cups
sudo systemctl enable avahi-daemon
echo "Place 'mdns_minimal [NOTFOUND=return] before resolve and dns in the hosts line"
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
break
else echo "waiting for keypress"
fi
done
sudo vim /etc/nsswitch.conf

# Regenerating grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Swap
# Only btrfs filesystems are supported
#export fs_uuid=$(findmnt / -o UUID -n) && echo ${fs_uuid}
#sudo mount -m -U $fs_uuid /mnt/system-${fs_uuid}
#sudo btrfs subvolume create /mnt/system-${fs_uuid}/@swap
#sudo umount /mnt/system-${fs_uuid}
#sudo mount -m -U ${fs_uuid} -o subvol=@swap,nodatacow /swap
#sudo touch /swap/swapfile
#sudo chattr +C /swap/swapfile
#export swp_size=$(echo "$(grep "MemTotal" /proc/meminfo | tr -d "[:blank:],[:alpha:],:") * 1.6 / 1000" | bc ) && echo $swp_size
#sudo dd if=/dev/zero of=/swap/swapfile bs=1M count=$swp_size status=progress
#sudo chmod 0600 /swap/swapfile
#sudo mkswap /swap/swapfile
#sudo umount /swap
#echo -e "UUID=$fs_uuid\t/swap\tbtrfs\tsubvol=@swap,nodatacow,noatime,nospace_cache\t0\t0" | sudo tee -a /etc/fstab
#echo -e "/swap/swapfile\tnone\tswap\tdefaults\t0\t0" | sudo tee -a /etc/fstab
#sudo systemctl daemon-reload
#sudo mount /swap
#sudo swapon -a
#swapon -s
#
## Hibernation
#export swp_uuid=$(findmnt -no UUID -T /swap/swapfile) && echo $swp_uuid
#curl -s "https://raw.githubusercontent.com/osandov/osandov-linux/master/scripts/btrfs_map_physical.c" > bmp.c
#gcc -O2 -o bmp bmp.c
#swp_offset=$(echo "$(sudo ./bmp /swap/swapfile | egrep "^0\s+" | cut -f9) / $(getconf PAGESIZE)" | bc) && echo $swp_offset
#echo -e "GRUB_CMDLINE_LINUX_DEFAULT+=\" resume=UUID=$swp_uuid resume_offset=$swp_offset \"" | sudo tee -a /etc/default/grub
#echo "Place 'resume' hook at the end of the line"
#while [ true ] ; do
#read -t 3 -n 1
#if [ $? = 0 ] ; then
#break
#else echo "waiting for keypress"
#fi
#done
#sudo vim /etc/mkinitcpio.conf
#sudo mkdir -pv /etc/systemd/system/{systemd-logind.service.d,systemd-hibernate.service.d}
#echo -e "[Service]\nEnvironment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1" | sudo tee /etc/systemd/system/systemd-logind.service.d/override.conf
#echo -e "[Service]\nEnvironment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1" | sudo tee /etc/systemd/system/systemd-hibernate.service.d/override.conf
#sudo mkinitcpio -P && sudo grub-mkconfig -o /boot/grub/grub.cfg


printf "\e[0;31mDone ! Rebooting in 5 secs...\e[m"
sleep 5
sudo reboot
