#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

. $HOME/.sh_exports
. $HOME/.sh_functions
. $HOME/.sh_aliases

if [ -f $HOME/.sh_extra ]; then
    . $HOME/.sh_extra
fi
