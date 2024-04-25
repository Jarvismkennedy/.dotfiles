#!/usr/bin/bash

pacman -S --needed git base-devel

if [ ! -d "~/yay" ]; then
	git clone https://aur.archlinux.org/yay.git ~/yay
fi
cd ~/yay && makepkg -si

yay -S --needed - < "$PWD/pacman.txt"
stow .


source "$PWD/ssh_setup"
source "$PWD/dotnet_install_script"
source "$PWD/install_git_repos"

echo "Setting fish as the default shell"
chsh -s $(which fish)


