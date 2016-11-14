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
    htop-osx \
    macvim \
    midnight-commander \
    mobile-shell \
    nmap \
    packer \
    python \
    python3 \
    ssh-copy-id \
    tmux \
    wget \
    wireshark --with-qt5 \
    youtube-dl

