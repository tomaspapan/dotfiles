
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias db="cd ~/Dropbox"
alias g="git"
alias h="history"
alias j="jobs"

alias ls='ls --color=auto'
alias ll='ls -l'
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
alias c='tmux a'
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
alias docker-init='$(docker-machine env boot2docker)'
alias docker-create='docker-machine create -d virtualbox boot2docker'
alias rtorrent='rtorrent -p 6998-6999'
alias va='vagrant'
alias scan_network="__scan_network $@"

GRC=`which grc 2>/dev/null`
if [ "$TERM" != dumb ] && [ -n "$GRC" ]
then
    alias colourify="$GRC -es --colour=auto"
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
    alias head='colourify head'
    alias tail='colourify tail'
    alias dig='colourify dig'
    alias mount='colourify mount'
    alias ps='colourify ps'
    alias mtr='colourify mtr'
    alias df='colourify df'
        # Temporary measure until grc upgrades to 1.8 in mainstream homebrew because of 
        # https://github.com/garabik/grc/issues/3 (does not affect Linux)
        if [ $OS == "Linux" ] || (grc -v |grep "Generic Colouriser 1.8" > /dev/null 2>&1); then
        alias ifconfig='colourify ifconfig'
        fi
        if [ $OS == "Linux" ] && [ -r "/usr/share/grc/conf.ifconfig" ]; then
            alias ip='colourify -c /usr/share/grc/conf.ifconfig ip'
        fi
fi

