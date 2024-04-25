#!/usr/bin/bash
sudo pacman -S --needed - < "$PWD/.scripts/pacman.txt"
stow .


source "$PWD/ssh_setup"
source "$PWD/dotnet_install_script"
source "$PWD/install_git_repos"

echo "Setting fish as the default shell"
chsh -s $(which fish)


