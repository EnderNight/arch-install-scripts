#!/bin/bash

# Base packages
yay -S --noconfirm plasma kde-applications materia-kde papirus-icon-theme code unityhub gimp inkscape chromium discord audacity lmms vlc obs-studio libreoffice-fresh ttf-gentium-basic adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts hunspell hunspell-fr hunspell-en hyphen hyphen-fr libmythes mythes-fr libreoffice-extension-languagetool jre8-openjdk libreoffice-extension-grammalecte-fr openrazer-meta polychromatic linux-lts linux-lts-headers linux-zen linux-zen-headers polymc lutris steam legendary zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-theme-powerlevel10k ttf-meslo-nerd-font-powerlevel10k cmakenodejs jdk11-openjdk npm mono

# Display manager
systemctl enable sddm

# Open razer
sudo gpasswd -a ender plugdev

# Regenerating grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git archlinux)/' ~/.zshrc

# Vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp .vimrc ~/.vimrc
vim +PluginInstall +qall
python3 ~/.vim/bundle/youcompleteme/install.py --all

# More settings can be setup after restarting...

printf "\e[0:31mDone ! Restarting in 5 sec...\e[m"
sleep 5
reboot
