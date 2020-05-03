INSTANT_REPL_HOOK_FILTER=equal_command

function __set_gsh() {
	GSH=true
	alias g='git logf'
}

function __unset_gsh() {
	unset GSH
	unalias g
}

function instant_repl_prefix_hook() {
	case $1 in
		git*) __unset_gsh; zle repl-redraw-prompt;;
	esac
	case $2 in
		git*) __set_gsh; zle repl-redraw-prompt;;
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
