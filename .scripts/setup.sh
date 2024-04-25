#!/usr/bin/bash
sudo pacman -S --needed - < "./pacman.txt"
stow .


source "./ssh_setup"
source "./dotnet_install_script"
source "./install_git_repos"

echo "Setting fish as the default shell"
chsh -s $(which fish)


