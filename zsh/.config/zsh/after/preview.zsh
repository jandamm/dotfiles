function preview() {
	[ -f $1 ] && bat $1 || eza -G $1
}

alias p=preview
