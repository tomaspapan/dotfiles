#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

FORCE=0
EXECUTE=1
PROFILE="basic git"

function parseInput() {

    while [[ $# -gt 0 ]]; do
        positional=()
        key=$1
        case $key in
            -f|--force)
                FORCE=1
                shift
                ;;
            -p|--profile)
                PROFILE="$2"
                shift
                shift
                ;;
            -l|--list)
                listProfiles
                EXECUTE=0
                shift
                ;;
            *)
                positional+=("$1")
                shift
                ;;
        esac
    done
}

function listProfiles() {
    echo "*basic *git openbox"
    echo 
    echo " * - the default profile"
    echo "Profiles can be definied as -p"
    echo 'example: ./boostrap -p "basic git ssh"'
}

function doIt() {

    shopt -s dotglob

    cd ./profiles
    
    echo $PROFILE

    for profile in $PROFILE; do
        echo -n "Applying profile=$profile..."
        cd ./$profile
        for file in *; do
            ln -sf "$PWD/$file" $HOME/
        done
        echo "done"
        cd ..
    done

    if [ ! -f ~/.vim/autoload/plug.vim ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}

function main() {
    git submodule init
    git submodule update --init --recursive

    parseInput "$@"

    if [ $EXECUTE -eq 1 ]; then
        if [ $FORCE -eq 1 ]; then
            doIt
        else
            read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
            echo ""
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                doIt
            fi
        fi
    fi
}

# main

main "$@"

