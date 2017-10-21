#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git submodule init
git submodule update --init --recursive


function doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "homebrew.sh" --exclude "README.md" --exclude .gitlab-ci.yml \
        --exclude "LICENSE-MIT.txt" --exclude "test.sh" \
        --exclude ".gitmodules" --exclude ".gitignore" \
        --exclude "homebrew-cask.sh" \
        -avh --no-perms . ~

    mkdir ~/.vim/backup > /dev/null 2>&1
    mkdir ~/.vim/tmp > /dev/null 2>&1
    mkdir ~/.vim/undodir > /dev/null 2>&1
    mkdir ~/go > /dev/null 2>&1

    if [ ! -f ~/.vim/autoload/plug.vim ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    source ~/.zshrc
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
