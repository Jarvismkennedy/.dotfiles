#!/usr/bin/bash

sudo pacman -S --needed - < "$PWD/pacman.txt"

eval "$PWD/ssh_setup"
eval "$PWD/dotnet_install_script"
eval "$PWD/install_git_repos"

echo "Setting fish as the default shell"
chsh -s $(which fish)


