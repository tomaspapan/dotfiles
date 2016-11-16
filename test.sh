#!/bin/bash

function check_for_file()
{
    if [ -f "$1" ]; then
        echo File found "$1".
    else
        echo File NOT found "$1".
        exit -1
    fi
}

check_for_file "$HOME/.bash_profile"
check_for_file "$HOME/.bash_prompt"
check_for_file "$HOME/.vim/bundle/Vundle.vim/changelog.md"
check_for_file "$HOME/.vim/bundle/nerdtree/CHANGELOG"

