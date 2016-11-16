
alias ls='ls --color=auto'
alias ll='ls -la'
alias dperm="find . -type d -exec chmod 0755 '{}' \;"
alias fperm="find . -type f -exec chmod 0644 '{}' \;"
alias d="du -ms"
alias dus='for i in *; do du -ms "$i"; done | sort -n'
alias vi='vim'
alias virsh="virsh --connect qemu:///system"
alias ms='pmset sleepnow; logout'
alias cdg='cd ~/git/'
alias web="__backup web $@"
alias backup="__backup backup $@"
alias encrypt_file="__encrypt_file $@"
alias decrypt_file="__decrypt_file $@"
alias update='sudo emerge -NDuvaq world && sudo emerge --depclean -a && sudo revdep-rebuild && sudo eclean-dist -d && sudo sh -c "echo -n > /tmp/new_packages"'
alias c='tmux attach -d'
alias reload='~/dotfiles/bootstrap.sh && source ~/.bash_profile'
alias bye='exit'
alias sha1check='openssl sha1 '
alias edithosts='sudo vim /etc/hosts'
alias editethers='sudo vim /etc/ethers'
alias ipt='iptables -L -v -n'
alias va='vagrant'
alias scan_network="__scan_network $@"
alias generate_network="__generate_network $@"
alias pip-update='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'
alias sshn='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias install-vim="vim +PluginInstall +qall && cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer"

if [ "$OS" '==' "Darwin" ]; then
    alias ls='ls -GFh'
    alias vim='mvim -v'
    alias vi='mvim -v'
    alias lsmod='kextstat'
    alias yass='VBoxManage startvm yass > /dev/null 2>&1; wait_for_host.sh yass 30 && ssh yass'
    alias dnsflush='sudo killall -HUP mDNSResponder'
    # System
    alias stackhighlightyes='defaults write com.apple.dock mouse-over-hilte-stack -boolean yes ; killall Dock'
    alias stackhighlightno='defaults write com.apple.dock mouse-over-hilte-stack -boolean no ; killall Dock'
    alias showallfilesyes='defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder'
    alias showallfilesno='defaults write com.apple.finder AppleShowAllFiles FALSE ; killall Finder'
    alias autoswooshyes='defaults write com.apple.Dock workspaces-auto-swoosh -bool YES ; killall Dock'
    alias autoswooshno='defaults write com.apple.Dock workspaces-auto-swoosh -bool NO ; killall Dock'
    alias nodesktopicons='defaults write com.apple.finder CreateDesktop -bool false'
    # MD5
    alias md5sum='md5 -r'
    # Applications
    alias iosdev='open /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app'
    alias androiddev='/Applications/Android\ Studio.app/sdk/tools/emulator -avd basic'
    alias installapp='brew cask install'
    alias server='open "http://localhost:8000" && python3 -m http.server'
    alias update='brew update; brew upgrade; brew cleanup;'
    alias archie='cd $HOME/git/vagrant-boxes/archie && va ssh'
else
    alias cal='cal --monday'
fi

