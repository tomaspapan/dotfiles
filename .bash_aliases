
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias g="git"
alias h="history"
alias j="jobs"

alias cal='cal --monday'
alias ls='ls --color=auto'
alias ll='ls -la'
alias dperm="find . -type d -exec chmod 0755 '{}' \;"
alias fperm="find . -type f -exec chmod 0644 '{}' \;"
alias d="du -ms"
alias dus='for i in *; do du -ms "$i"; done | sort -n'
alias vi='vim'
alias virsh="virsh --connect qemu:///system"
alias sa='ssh morpheus@anakin'
alias ms='pmset sleepnow; logout'
alias stopmotion_fast='ffmpeg -r 12 -i clip-%d.jpg -b 40M clip.mov'
alias stopmotion_slow='ffmpeg -r 7 -i clip-%d.jpg -b 25M clip.mov'
alias cdg='cd ~/git/'
alias anakin="open vnc://anakin:5901"
alias vnc="vncserver -geometry 1600x1050"
alias web="__backup web $@"
alias backup="__backup backup $@"
alias encrypt_file="__encrypt_file $@"
alias decrypt_file="__decrypt_file $@"
alias update='sudo emerge -NDuvaq world && sudo emerge --depclean -a && sudo revdep-rebuild && sudo eclean-dist -d && sudo sh -c "echo -n > /tmp/new_packages"'
alias s='cat /etc/motd'
alias c='tmux attach -d'
alias virsh-startall='for host in `virsh list --all | grep -i '"'shut'"' | awk '"'{print \$2}'"'`; do virsh start $host; done'
alias virsh-stopall='for host in `virsh list --all | grep -i '"'run'"' | awk '"'{print \$2}'"'`; do virsh shutdown $host; done'
alias reload='~/dotfiles/bootstrap.sh && source ~/.bashrc'
alias bye='exit'
alias sha1check='openssl sha1 '
alias docpad-run='node_modules/docpad/bin/docpad run'
alias docpad-static='node_modules/docpad/bin/docpad generate --env static'
alias docpad-gen='OK=0; until [ $OK -ne 0 ]; do node_modules/docpad/bin/docpad generate --env static | grep thumb | grep queue; OK=$?; done'
alias edithosts='sudo vim /etc/hosts'
alias editethers='sudo vim /etc/ethers'
alias ipt='iptables -L -v -n'
alias docker-cleanall='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'
alias docker-cleancontainers='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias docker-shell=__docker-shell
alias docker-init='eval "$(docker-machine env dev)"'
alias docker-create='docker-machine create -d virtualbox --virtualbox-memory="8192" dev'
alias rtorrent='rtorrent -p 6998-6999'
alias va='vagrant'
alias scan_network="__scan_network $@"
alias generate_network="__generate_network $@"
alias pip-update='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'


if [ "$OS" '==' "Darwin" ]; then
    alias ls='ls -GFh'
    alias vim='mvim -v'
    alias vi='mvim -v'
    alias lsmod='kextstat'
    alias yass='VBoxManage startvm yass > /dev/null 2>&1; wait_for_host.sh yass 30 && ssh yass'
    alias dnsflush='sudo discoveryutil udnsflushcaches'
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
    alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update'
fi

