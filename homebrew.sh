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
    iproute2mac \
    macvim \
    mas \
    midnight-commander \
    mobile-shell \
    msmtp \
    nmap \
    nodejs \
    python \
    python3 \
    rsync \
    ssh-copy-id \
    the_silver_searcher \
    tmux \
    wget \
    wireshark --with-qt5 \
    youtube-dl \
    zsh \
    zsh-completions
