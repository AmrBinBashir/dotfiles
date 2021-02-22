#!/bin/bash
Cyan='\033[0;36m'
Green='\033[0;32m'
CreateConfigsSymlink () {
    printf "${Cyan} - Creating symlinks for config files...\n";

    mkdir -p $HOME/.config/kitty
    rm $HOME/.config/kitty/kitty.conf -f
    ln -sf $PWD/linux/kitty.conf $HOME/.config/kitty/kitty.conf
    printf "${Green}    ✅ Kitty \n"

    mkdir -p $HOME/.config/sxhkd
    rm $HOME/.config/sxhkd/sxhkdrc -f
    ln -sf $PWD/linux/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
    printf "${Green}    ✅ sxhkd \n"

    mkdir -p $HOME/.config/picom
    rm $HOME/.config/picom/picom.conf -f
    ln -sf $PWD/linux/picom.conf $HOME/.config/picom/picom.conf
    printf "${Green}    ✅ Picom \n"

    mkdir -p $HOME/.config/qtile
    rm $HOME/.config/qtile/config.py -f
    ln -sf $PWD/linux/qtile.py $HOME/.config/qtile/config.py
    printf "${Green}    ✅ Qtile \n"

    rm $HOME/.zshrc
    ln -sf $PWD/linux/.zshrc $HOME/.zshrc
    printf "${Green}    ✅ Zsh \n"

    mkdir -p $HOME/.config/rofi
    rm $HOME/.config/rofi -rf
    ln -sf $PWD/linux/rofi $HOME/.config/rofi
    printf "${Green}    ✅ Rofi \n"

    sudo rm /etc/paru.conf -f
    sudo ln -sf $PWD/linux/paru.conf /etc/paru.conf
    printf "${Green}    ✅ Paru \n"

    mkdir -p $HOME/.config/nvim
    rm $HOME/.config/nvim/init.vim -f
    ln -sf $PWD/shared/neovim.vim $HOME/.config/nvim/init.vim
    printf "${Green}    ✅ Neovim \n"

    mkdir -p $HOME/.config
    rm $HOME/.config/starship.toml -f
    ln -sf $PWD/shared/starship.toml $HOME/.config/starship.toml
    printf "${Green}    ✅ Starship \n"

    rm $HOME/.gitconfig
    ln -sf $PWD/shared/.gitconfig $HOME/.gitconfig
    printf "${Green}    ✅ .gitconfig \n"

}

CreateConfigsSymlink