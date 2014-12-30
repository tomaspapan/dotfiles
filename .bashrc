
# Tomas Papan's bashrc

if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

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

export PATH=$PATH:~/bin:~/android/sdk/platform-tools:~/android/sdk/tools:usr/local/share/npm/bin
export HISTFILESIZE=10000
export SVN_EDITOR='vim'
export GIT_EDITOR='vim'
export EDITOR='vim'

. $HOME/Library/shell/functions.sh
. $HOME/Library/shell/prompt.sh
. $HOME/Library/shell/aliases.sh
. $HOME/Library/shell/host_specific.sh


if [ -f /etc/profile.d/bash-completion.sh ]; then
        source /etc/profile.d/bash-completion.sh
fi

