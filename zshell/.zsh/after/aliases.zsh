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

function colors() {
	for i in {0..255}
	do
		print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
	done
}
