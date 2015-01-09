
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
    git_remote=$(basename -s .git $(git remote -v | grep fetch | awk '{print $2}') 2>/dev/null)
    if [ $? -ne 0 ]; then git_remote='local '; else git_remote="$git_remote "; fi
    if [ $git_remote == "dotfiles" ]; then git_remote=''; fi
    if git diff --quiet 2>/dev/null >&2; then
        echo "[${CYAN}$git_remote${C_RESET}$git_branch ${GREEN}✓${C_RESET}]"
    else
        echo "[${CYAN}$git_remote${C_RESET}$git_branch ${RED}✗${C_RESET}]"
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

