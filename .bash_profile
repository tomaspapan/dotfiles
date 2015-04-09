
# Tomas Papan's bashrc

if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

export OS="$(uname -s)"

case $TERM in
    xterm*)
        TITLEBAR="\[\033]0;\w\007\]"
        ;;
    *)
        TITLEBAR=""
        ;;
esac

export PATH=$PATH:~/bin:~/android/sdk/platform-tools:~/android/sdk/tools:usr/local/share/npm/bin
export HISTFILESIZE=10000
export SVN_EDITOR='vim'
export GIT_EDITOR='vim'
export EDITOR='vim'

. $HOME/.bash_functions
. $HOME/.bash_prompt
. $HOME/.bash_aliases
. $HOME/.bash_os_specific


if [ -f /etc/profile.d/bash-completion.sh ]; then
        source /etc/profile.d/bash-completion.sh
fi

