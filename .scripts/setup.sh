#!/usr/bin/bash

# pacman -S --needed git base-devel
#
# if [ ! command -v yay &>/dev/null ]; then
# 	current=$PWD
# 	git clone https://aur.archlinux.org/yay.git ~/yay
# 	cd ~/yay && makepkg -si
# 	cd $current
# fi
#
# yay -S --needed - < "$PWD/pacman.txt"
#
# source "$PWD/ssh_setup"
# source "$PWD/dotnet_install_script"
# source "$PWD/install_git_repos"
#
# echo "Setting fish as the default shell"
# chsh -s /usr/bin/fish


echo "setting vconsole colors needed by mkinitcpio-colors"

echo "
COLOR_0=1d1f21
COLOR_1=282a2e 
COLOR_2=373b41 
COLOR_3=969896
COLOR_4=b4b7b4
COLOR_5=c5c8c6
COLOR_6=e0e0e0
COLOR_7=ffffff
COLOR_8=cc6666
COLOR_9=de935f
COLOR_10=f0c674
COLOR_11=b5bd68
COLOR_12=8abeb7
COLOR_13=81a2be
COLOR_14=b294bb
COLOR_15=a3685a" | sudo tee -a /etc/vconsole.conf


# cd .. && stow . 
