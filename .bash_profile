
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

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;


