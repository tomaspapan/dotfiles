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

# fzf
if [ -e ~/.fzf ]; then
	_append_to_path ~/.fzf/bin
	source ~/.fzf/shell/key-bindings.zsh
	source ~/.fzf/shell/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi
