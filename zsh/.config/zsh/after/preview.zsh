function preview() {
	[ -f $1 ] && bat $1 || exa -G $1
}

alias p=preview
