#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git pull -r origin master

git submodule init
git submodule update


function doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "homebrew.sh" --exclude "README.md" --exclude "LICENSE-MIT.txt" \
        -avh --no-perms . ~

    mkdir ~/.vim/backup > /dev/null 2>&1
    mkdir ~/.vim/tmp > /dev/null 2>&1
    mkdir ~/.vim/undodir > /dev/null 2>&1
    mkdir ~/go > /dev/null 2>&1

    if [ $(basename $SHELL) = "bash" ]; then  source ~/.bash_profile; fi

    vim +PluginInstall +qall
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
fi
unset doIt
