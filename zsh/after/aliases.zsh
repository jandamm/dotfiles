alias rmlogs="rm -rf /private/var/log/asl/*.asl"

alias rezsh="source ~/.zshrc"

alias bell="tput bel"

alias :q="exit"

function p() {
	[ -f $1 ] && bat $1 || exa -G $1
}

function meas() {
	for _ in $(seq 1 10)
	do /usr/bin/time "$SHELL" -i -c exit
	done
}

if hash pbcopy 2>/dev/null; then
	function copy {
		bat --plain --paging=never "$1" | pbcopy
	}
fi
