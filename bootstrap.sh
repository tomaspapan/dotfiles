#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

source ./shell/functions.sh

DOTFILES_DIR=~/dotfiles
DOTFILES_BACKUP=/tmp/dotfiles_old.$$

declare -A FILES_TO_SYMLINK=(
    # zsh + shell
    ["shell/shell_aliases"]=".shell_aliases"
    ["shell/shell_exports"]=".shell_exports"
    ["shell/shell_functions"]=".shell_functions"
    ["shell/zlogin"]=".zlogin"
    ["shell/zlogout"]=".zlogout"
    ["shell/zprezto"]=".zprezto"
    ["shell/zpreztorc"]=".zpreztorc"
    ["shell/zprofile"]=".zprofile"
    ["shell/zshenv"]=".zshenv"
    ["shell/zshrc"]=".zshrc"
    # vim
    ["vim/vim"]=".vim"
    ["vim/vimrc"]=".vimrc"
    # curl
    ["shell/curlrc"]=".curlrc"
    # editroconfig
    ["shell/editorconfig"]=".editorconfig"
    # tmux
    ["shell/tmux.conf"]=".tmux.conf"
    # git
    ["git/gitconfig"]=".gitconfig"
    # htop
    ["htop/htoprc"]=".config/htop/htoprc"
    # openbox
    ["openbox/compton.conf"]=".config/compton.conf"
    ["openbox/gtk-3.0/gtk.css"]=".config/gtk-3.0/gtk.css"
    ["openbox/gtk-3.0/settings.ini"]=".config/gtk-3.0/settings.ini"
    ["openbox/gtkrc"]=".config/gtkrc"
    ["openbox/gtkrc-2.0"]=".config/gtkrc-2.0"
    ["openbox/obmenu-generator/config.pl"]=".config/obmenu-generator/config.pl"
    ["openbox/obmenu-generator/schema.pl"]=".config/obmenu-generator/schema.pl"
    ["openbox/openbox/autostart.example"]=".config/openbox/autostart.example"
    ["openbox/openbox/rc.xml"]=".config/openbox/rc.xml"
    ["openbox/openbox/wallpaper.jpg"]=".config/openbox/wallpaper.jpg"
    ["openbox/tint2/tint2rc"]=".config/tint2/tint2rc"
    ["openbox/Xresources"]=".Xresources"

)

function backup() {
    echo -n "Creating $DOTFILES_BACKUP for backup of any existing dotfiles in ~ ... "
    mkdir -p $DOTFILES_BACKUP
    echo "done"
    echo -n "Moving old dotfiles to $DOTFILES_BACKUP ... "
    for i in "${!FILES_TO_SYMLINK[@]}"; do
  		mv "$HOME/${FILES_TO_SYMLINK[$i]}" $DOTFILES_BACKUP/ > /dev/null 2>&1
	done
    echo "done"
}

function doIt() {
    echo "Creating symlinks ... "
	local i=''
  	local sourceFile=''
  	local targetFile=''

	for i in "${!FILES_TO_SYMLINK[@]}"; do
		sourceFile="$(pwd)/$i"
		targetFile="$HOME/${FILES_TO_SYMLINK[$i]}"
        create_symlink "$sourceFile" "$targetFile"
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

