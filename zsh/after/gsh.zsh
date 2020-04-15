function set-gsh() {
	POWERLEVEL9K_LAMBDA_ICON=δ
	zle repl-redraw-prompt
}

function unset-gsh() {
	POWERLEVEL9K_LAMBDA_ICON=λ
	zle repl-redraw-prompt
}

function instant_repl_prefix_hook() {
	case $1 in
		git*) unset-gsh;;
	esac
	case $2 in
		git*) set-gsh;;
	esac
}

bindkey '^s' repl-set

function git() {
	if [ -z "$1" ]; then
		env git status --short --branch
	else
		env git "$@"
	fi
}
