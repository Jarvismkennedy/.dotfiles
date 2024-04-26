#!/usr/bin/bash

pacman -S --needed git base-devel

if [ ! command -v yay &>/dev/null ]; then
	current=$PWD
	git clone https://aur.archlinux.org/yay.git ~/yay
	cd ~/yay && makepkg -si
	cd $current
fi

yay -S --needed - < "$PWD/pacman.txt"

source "$PWD/ssh_setup"
source "$PWD/dotnet_install_script"
source "$PWD/install_git_repos"

echo "Setting fish as the default shell"
chsh -s /usr/bin/fish


cd .. && stow . 
