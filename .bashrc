# Tomas Papan bashrc
# 2012


if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# global variables

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

# Bash
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

        # Custom
        export C_RESET='\[\e[0m\]'
        export C_TIME=$PURPLE
        export C_USER=$BLUE
        export C_PATH=$YELLOW
        export C_GIT_CLEAN=$CYAN
        export C_GIT_DIRTY=$RED

elif [[ $PROFILE_SHELL = "zsh" ]]; then
        # Custom
        export C_RESET=$reset_color
        export C_TIME=$fg[green]
        export C_USER=$fg[blue]
        export C_PATH=$fg[yellow]
        export C_GIT_CLEAN=$fg[cyan]
        export C_GIT_DIRTY=$fg[red]
fi

# functions

function prompt {
	if [[ ${EUID} == 0 ]] ; then
        	export PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
	else
        	export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi

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
                local git_color=$C_GIT_CLEAN
        else
                local git_color=$C_GIT_DIRTY
        fi

        echo ":${git_color}${git_branch}${C_RESET}"
}


function precmd {
        local separator=':'
        local time=$(date +%H:%M:%S)
        local target=${PWD/$HOME/~}
        local user="${USER}@${HOSTNAME}"
        if [ ${USER} == "root" ]; then
                local C_USER=$RED
        fi
        if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
                local C_USER=$GREEN
        fi

        local basename=$(basename $target)
        # local pathReversed=$(echo -n $target | split '/' | sed '1!G;h;$!d' | join '\\\\')
        local title="${basename}${separator}${user}${separator}${target}$(git_prompt)"
        local prefix="${C_TIME}${time}${C_RESET}${separator}${C_USER}${user}${C_RESET}${separator}${C_PATH}${target}${C_RESET}$(git_prompt_color)"

        # Bash
        if [[ $PROFILE_SHELL = 'bash' ]]; then
                if [ ${USER} == "root" ]; then
                        export PS1="${prefix}\n# "
                else
                        export PS1="${prefix}\n\$ "
                fi
                echo -ne "\033]0;${title}\007"

        # ZSH
        else
                export PROMPT="${prefix}
$ "     # zsh
                # echo -ne "\e]1;${title}\a"
        fi
}
export PROMPT_COMMAND=precmd


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

# aliases

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
alias update='sudo emerge -NDuvaq world ; sudo emerge --depclean -a ; sudo revdep-rebuild ; sudo eclean-dist -d'
alias s='cat /etc/motd'
alias c='tmux a'
alias virsh-startall='for host in `virsh list --all | grep -i '"'shut'"' | awk '"'{print \$2}'"'`; do virsh start $host; done'
alias virsh-stopall='for host in `virsh list --all | grep -i '"'run'"' | awk '"'{print \$2}'"'`; do virsh shutdown $host; done'
alias snip='vi ~/Dropbox/snippets'
alias reload='source ~/.bashrc'
alias bye='exit'
alias sha1check='openssl sha1 '


# exports

export PATH=$PATH:~/bin:~/android/platform-tools:/usr/local/share/npm/bin/
export HISTFILESIZE=10000
export SVN_EDITOR='vim'
export GIT_EDITOR='vim'
export EDITOR='vim'

# host specific

if [ `uname -s` '==' "Darwin" ]; 
then
        export CLICOLOR=1
        export LSCOLORS=ExFxBxDxCxegedabagacad
        alias ls='ls -GFh'
        alias vim='mvim -v'
        alias vi='mvim -v'
        export GIT_EDITOR='mvim -v'
fi

if [ `hostname -s` '==' "r2d2" ];
then
        export TERM='xterm-256color'
fi

if [ -f /etc/profile.d/bash-completion.sh ]; then
        source /etc/profile.d/bash-completion.sh
fi

if [ -f ~/TODO ]; then cat ~/TODO | egrep -v "^#"; fi


