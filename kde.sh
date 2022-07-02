#!/bin/bash

# Base packages
yay -S plasma kde-applications materia-kde papirus-icon-theme

# Display manager
systemctl enable sddm

# More settings can be setup after restarting...

printf "\e[0:31mDone ! Restarting in 5 sec...\e[m"
sleep 5
reboot
