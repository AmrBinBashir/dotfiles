#!/bin/bash
Cyan='\033[0;36m'
Green='\033[0;32m'
CreateConfigsSymlink () {
    printf "${Cyan} - Creating symlinks for config files...\n";
    mkdir -p $HOME/.config


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

    rm $HOME/.zshrc
    ln -sf $PWD/linux/.zshrc $HOME/.zshrc
    printf "${Green}    ✅ Zsh \n"

    rm $HOME/.config/awesome -rf
    ln -sf $PWD/linux/awesome $HOME/.config/awesome
    printf "${Green}    ✅ AwesomeWM \n"

    mkdir -p $HOME/.config/rofi
    rm $HOME/.config/rofi -rf
    ln -sf $PWD/linux/rofi $HOME/.config/rofi
    printf "${Green}    ✅ Rofi \n"

    mkdir -p $HOME/.config/paru
    rm $HOME/.config/paru/paru.conf -rf
    ln -sf $PWD/linux/paru.conf $HOME/.config/paru/paru.conf
    printf "${Green}    ✅ Paru \n"

    mkdir -p $HOME/.config/nvim
    rm $HOME/.config/nvim/init.vim -f
    ln -sf $PWD/shared/neovim.vim $HOME/.config/nvim/init.vim
    printf "${Green}    ✅ Neovim \n"

    rm $HOME/.config/starship.toml -f
    ln -sf $PWD/shared/starship.toml $HOME/.config/starship.toml
    printf "${Green}    ✅ Starship \n"

    rm $HOME/.gitconfig
    ln -sf $PWD/shared/.gitconfig $HOME/.gitconfig
    printf "${Green}    ✅ .gitconfig \n"

    mkdir -p $HOME/.config/polybar
    rm $HOME/.config/polybar -rf
    ln -sf $PWD/linux/polybar $HOME/.config/polybar
    printf "${Green}    ✅ Polybar \n"

    mkdir -p $HOME/.config/spicetify
    rm $HOME/.config/spicetify/config.ini -f
    ln -sf $PWD/linux/spicetify-cli.ini $HOME/.config/spicetify/config.ini
    printf "${Green}    ✅ Spicetify \n"

    rm $HOME/.xprofile -f
    ln -sf $PWD/linux/.xprofile $HOME/.xprofile
    printf "${Green}    ✅ .xprofile \n"

}

CreateConfigsSymlink
