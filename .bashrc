
# Tomas Papan's bashrc

if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# global variables -------------------------------------------------------------

OS="$(uname -s)"

# Shell
if test -n "$ZSH_VERSION"; then
    export PROFILE_SHELL='zsh'
    local HOSTNAME='%m'
elif test -n "$BASH_VERSION"; then
    export PROFILE_SHELL='bash'
elif test -n "$KSH_VERSION"; then
    export PROFILE_SHELL='ksh'
elif test -n "$FCEDIT"; then
    export PROFILE_SHELL='ksh'
elif test -n "$PS3"; then
    export PROFILE_SHELL='unknown'
else
    export PROFILE_SHELL='sh'
fi

case $TERM in
    xterm*)
        TITLEBAR="\[\033]0;\w\007\]"
        ;;
    *)
        TITLEBAR=""
        ;;
esac

PS3=">> "

# Bash -------------------------------------------------------------------------
if [[ $PROFILE_SHELL = "bash" ]]; then
    # Standard
    export RED="\[\033[0;31m\]"
    export RED_BOLD="\[\033[01;31m\]"
    export BLUE="\[\033[0;34m\]"
    export CYAN='\[\e[0;36m\]'
    export PURPLE='\[\e[0;35m\]'
    export GREEN="\[\033[0;32m\]"
    export YELLOW="\[\033[0;33m\]"
    export BLACK="\[\033[0;38m\]"
    export NO_COLOUR="\[\033[0m\]"

    export C_RESET='\[\e[0m\]'
fi
# functions --------------------------------------------------------------------

function __encrypt_file {
    IN="$1"
    OUT="$2"
    gpg2 -ca --cipher-algo aes256 -o "$OUT" "$IN"
}

function __decrypt_file {
    IN="$1"
    OUT="$2"
    gpg2 -da -o "$OUT" "$IN"
}

function __backup {
    case "$1" in 
        "backup")
            URL='/home/morpheus/backup/'
            ;;
        "web")
            URL='/home/pub/Papan.sk/'
            ;;
        *)
            echo "Unknown Error. Ask Microsoft"
    esac
    case "$2" in
        "pull")
            scp -P 7777 -r "morpheus@papan.sk:$URL/\"$3\"" .
            ;;

        "push")
            scp -P 7777 -r "$3" morpheus@papan.sk:$URL 
            if [ "$1" == "web" ] 
            then 
                echo "http://papan.sk/share/$3" 
            fi
            ;;
        "list")
            ssh -p 7777 morpheus@papan.sk "cd $URL && du -ms *" 
            if [ $? -ne 0 ]; then
                echo "There is nothing!"
            fi
            ;;
        "rm")
            ssh -p 7777 morpheus@papan.sk "cd $URL && rm -rf \"$3\""
            ;;
        *)
            echo "Wrong option"
            echo "commands"
            echo "pull <remote target> <destination>"
            echo "push <target> <remote destination>"
            echo "list"
            echo "rm <remote target>"
            ;;
    esac
}

function flac_to_alac()
{
    mkdir alac;
    for f in *.flac
    do
            ffmpeg -i "$f" -acodec alac "alac/${f%.flac}.m4a"
    done
}

function flac_to_mp3()
{
    mkdir mp3;
    for f in *.flac
    do
            ffmpeg -i "$f" -ab 196k -ac 2 -ar 48000 "mp3/${f%.flac}.mp3"
    done
}

function flac_to_320_mp3()
{
    mkdir mp3_320;
    for f in *.flac
    do
            ffmpeg -i "$f" -ab 320k -ac 2 "mp3_320/${f%.flac}.mp3"
    done
}

function genpasswd() 
{
    local l=$1
    [ "$l" == "" ] && l=20
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

function timer()
{
    notify="/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier"
    sleep $1 && $notify -title 'Terminal Notifier' -message $2
}

function kernel-compile()
{
    cd /kernel/linux
    mv .config ../
    make mrproper
    mv ../.config .
    make oldconfig
    make menuconfig
    make -j9

    echo -e "\nKernel is compiled. Please install it (and modules too)"
    echo -e "\n# make install"
    echo -e "\n# make modules_install"
}

function notify()
{
    TIME=$1
    MSG=$2

    sleep $TIME

    /Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier -message $MSG -title 'terminal'
}

function resize()
{
    RESIZE=$1
    mkdir resize
    for pic in *
    do
            convert -resize $RESIZE "$pic" "resize/$pic"
    done
}

function brewremovewithdep()
{
    keg=$1
    brew rm $keg
    brew rm $(join <(brew leaves) <(brew deps $keg))
}

# prompt -----------------------------------------------------------------------

function get_hostname {
	HOSTNAME=""
	env | grep SSH_CLIENT > /dev/null 2>&1
	if  [ $? -eq 0 ]; then HOSTNAME="[${CYAN}$(hostname -s)${C_RESET}]"
	else
		 if [ ${USER} == "root" ]; then
		 	HOSTNAME="[${RED}$(hostname -s)${C_RESET}]"
		 fi
	fi
	echo $HOSTNAME
}

function git_prompt {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    fi
    echo ":$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')"
}

function git_prompt_color {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    fi
    local git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
    if git diff --quiet 2>/dev/null >&2; then
        echo "[$git_branch ${GREEN}✓${C_RESET}]"
    else
        echo "[$git_branch ${RED}✗${C_RESET}]"
    fi
}

function precmd {
    local target="[${CYAN}${PWD/#$HOME/\~}${C_RESET}]"
    local prefix="${TITLEBAR}┌─$(get_hostname)$(git_prompt_color)${target}"
    if [ ${USER} == "root" ]; then
        export PS1="${prefix}\n└─${RED}▪ ${C_RESET}"
    else
        export PS1="${prefix}\n└─${CYAN}▪ ${C_RESET}"
    fi
    export PS2="└─▪ "
}

export PROMPT_COMMAND=precmd

# aliases ----------------------------------------------------------------------

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
alias docker-clean='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'
function __docker-shell() {
    docker exec -ti $1 bash
}
alias docker-shell=__docker-shell

# exports ----------------------------------------------------------------------

export PATH=$PATH:~/bin:~/android/sdk/platform-tools:~/android/sdk/tools:usr/local/share/npm/bin
export HISTFILESIZE=10000
export SVN_EDITOR='vim'
export GIT_EDITOR='vim'
export EDITOR='vim'

# host specific ----------------------------------------------------------------

if [ "$OS" '==' "Darwin" ]; then
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    export GIT_EDITOR='mvim -v'
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
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
    alias va='vagrant'
    alias server='open "http://localhost:8000" && python3 -m http.server'
    export LC_CTYPE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi

if [ `hostname -s` '==' "r2d2" ];
then
        export TERM='xterm-256color'
fi

if [ `hostname -s` '==' "ul001174" ];
then
        export TERM='xterm-256color'
fi

if [ -f /etc/profile.d/bash-completion.sh ]; then
        source /etc/profile.d/bash-completion.sh
fi

if [ -f ~/TODO ]; then cat ~/TODO | egrep -v "^#"; fi


