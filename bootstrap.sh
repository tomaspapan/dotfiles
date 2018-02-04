#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

source ./.functions.sh

DOTFILES_DIR=~/dotfiles
DOTFILES_BACKUP=/tmp/dotfiles_old.$$

declare -a FILES_TO_SYMLINK=(
    'shell/curlrc'
    'shell/editorconfig'
    'shell/shell_aliases'
    'shell/shell_exports'
    'shell/shell_functions'
    'shell/tmux.conf'
    'shell/zlogin'
    'shell/zlogout'
    'shell/zprezto'
    'shell/zpreztorc'
    'shell/zprofile'
    'shell/zshenv'
    'shell/zshrc'

    'git/gitconfig'

    'vim/vim'
    'vim/vimrc'
)

function backup() {
    echo -n "Creating $DOTFILES_BACKUP for backup of any existing dotfiles in ~..."
    mkdir -p $DOTFILES_BACKUP
    echo "done"
    echo -n "Moving old dotfiles to $DOTFILES_BACKUP..."
    for i in ${FILES_TO_SYMLINK[@]}; do
  		mv ~/.${i##*/} $DOTFILES_BACKUP > /dev/null 2>&1
	done
    echo "done"
}

function doIt() {

	local i=''
  	local sourceFile=''
  	local targetFile=''

	for i in ${FILES_TO_SYMLINK[@]}; do
		sourceFile="$(pwd)/$i"
		targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
		if [ ! -e "$targetFile" ]; then
			execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
		elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
			print_success "$targetFile → $sourceFile"
		else
			ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
			if answer_is_yes; then
				rm -rf "$targetFile"
				execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
			else
				print_error "$targetFile → $sourceFile"
			fi
		fi
  	done

    if [ ! -f ~/.vim/autoload/plug.vim ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}

function main() {
    git submodule init > /dev/null 2>&1
    git submodule update --init --recursive > /dev/null 2>&1

    backup
    doIt
}

# main

main "$@"

