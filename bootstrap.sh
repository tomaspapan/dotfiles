#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git submodule init
git submodule update --init --recursive

function doIt() {

    shopt -s dotglob

    cd ./profiles/basic
    for i in *; do
        ln -sf "$PWD/$i" $HOME/
    done

    if [ ! -f ~/.vim/autoload/plug.vim ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
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
