#!/bin/bash

# Base packages
yay -S plasma kde-applications materia-kde papirus-icon-theme code unityhub gimp inkscape chromium discord audacity lmms vlc obs-studio libreoffice-fresh ttf-gentium-basic adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts hunspell hunspell-fr hunspell-en_us hyphen hyphen-fr libmythes mythes-fr libreoffice-extension-languagetool jdk8-openjdk libreoffice-extension-grammalecte-fr openrazer-meta polychromatic polymc lutris steam legendary zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-theme-powerlevel10k ttf-meslo-nerd-font-powerlevel10k cmake nodejs npm mono grapejuice wget nordic-wallpapers materia-gtk-theme kvantum-theme-materia

# Display manager
systemctl enable sddm

# Open razer
sudo gpasswd -a ender plugdev

# Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git archlinux)/' ~/.zshrc

# Vim
curl -sLf https://spacevim.org/install.sh | bash
vim

# MMcK Launcher
wget https://github.com/SnoutBug/mmcklauncher/releases/download/0.6/com.github.SnoutBug.mmckLauncher.tar.gz
plasmapkg2 --install com.github.SnoutBug.mmckLauncher.tar.gz
rm com.github.SnoutBug.mmckLauncher.tar.gz

# More settings can be setup after restarting...

printf "\e[0:31mDone ! Restarting in 5 sec...\e[m"
sleep 5
reboot
