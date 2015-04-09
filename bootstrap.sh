#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git submodule init
git submodule update

#git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" -avh --no-perms . ~;

    mkdir ~/.vim/backup > /dev/null 2>&1
    mkdir ~/.vim/tmp > /dev/null 2>&1
    mkdir ~/.vim/undodir > /dev/null 2>&1

	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
