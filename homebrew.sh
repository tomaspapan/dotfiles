#!/bin/bash

if [ -f /usr/local/bin/brew ];
then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install \
    bash \
    bash-completion \
    coreutils \
    ctags \
    ffmpeg \
    htop-osx \
    macvim \
    mas \
    midnight-commander \
    mobile-shell \
    nmap \
    nodejs \
    packer \
    python \
    python3 \
    rsync \
    ssh-copy-id \
    tmux \
    wget \
    wireshark --with-qt5 \
    youtube-dl \
    zsh \
    zsh-completions
