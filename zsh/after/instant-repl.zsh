INSTANT_REPL_HOOK_FILTER=equal_command

function instant_repl_prefix_hook() {
	case $1 in
		git*|'g ') __unset_gsh; zle repl-redraw-prompt;;
		sudo*) INSTANT_REPL_HOOK_FILTER=equal_command;;
	esac
	case $2 in
		git*|'g ') __set_gsh; zle repl-redraw-prompt;;
		sudo*) INSTANT_REPL_HOOK_FILTER=matching;;
	esac
}
