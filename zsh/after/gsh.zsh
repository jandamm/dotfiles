function set-gsh() {
	GSH=true
	zle repl-redraw-prompt
}

function unset-gsh() {
	unset GSH
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

function git() {
	if [ -z "$1" ]; then
		env git status --short --branch
	else
		env git "$@"
	fi
}

function is_gsh() {
	[ -n "$GSH" ]
}

function is_not_gsh() {
	[ -z "$GSH" ]
}
