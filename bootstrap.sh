#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git pull -r origin master

git submodule init
git submodule update


function doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "homebrew.sh" --exclude "README.md" --exclude .gitlab-ci.yml \
        --exclude "LICENSE-MIT.txt" --exclude "test.sh" \
        -avh --no-perms . ~

    mkdir ~/.vim/backup > /dev/null 2>&1
    mkdir ~/.vim/tmp > /dev/null 2>&1
    mkdir ~/.vim/undodir > /dev/null 2>&1
    mkdir ~/go > /dev/null 2>&1

    source ~/.bash_profile

    vim +PluginInstall +qall
    cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
    cd ~
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
