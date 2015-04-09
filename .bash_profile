
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

. $HOME/.bash_exports
. $HOME/.bash_functions
. $HOME/.bash_prompt
. $HOME/.bash_aliases
. $HOME/.bash_os_specific


if [ -f /etc/profile.d/bash-completion.sh ]; then
        source /etc/profile.d/bash-completion.sh
fi

