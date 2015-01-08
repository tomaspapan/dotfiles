
alias ls='ls --color=auto'
alias ll='ls -l'
alias dperm="find . -type d -exec chmod 0755 '{}' \;"
alias fperm="find . -type f -exec chmod 0644 '{}' \;"
alias d="du -ms"
alias dus='for i in *; do du -ms "$i"; done | sort -n'
alias vi='vim'
alias myip='curl ifconfig.me'
alias virsh="virsh --connect qemu:///system"
alias sa='ssh morpheus@anakin'
alias ms='pmset sleepnow; logout'
alias sshw='ssh pntmm_ra@10.50.133.245'
alias stopmotion_fast='ffmpeg -r 12 -i clip-%d.jpg -b 40M clip.mov'
alias stopmotion_slow='ffmpeg -r 7 -i clip-%d.jpg -b 25M clip.mov'
alias cdg='cd ~/git/'
alias work="open vnc://vpn-r2d2:5901"
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
alias snip='cd ~/Google\ Drive/snippets && vi .'
alias reload='source ~/.bashrc'
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
alias docker-init='$(boot2docker shellinit)'
alias rtorrent='rtorrent -p 6998-6999'
alias va='vagrant'
