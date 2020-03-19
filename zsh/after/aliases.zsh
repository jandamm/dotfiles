alias rmlogs="rm -rf /private/var/log/asl/*.asl"

alias rezsh="source ~/.zshrc"

alias bell="tput bel"

alias :q="exit"

alias ..='cd ..'

function z() {
	cd "$(zz -l $1 \
		| sed '/^common/d' \
		| sort --version-sort -r \
		| sed 's_^[0-9 ]*__' \
		| sed "s_^${HOME}_~_" \
		| fzf -1 -0 --preview "exa -lhg --git --color=always \$(echo {} | sed "s_^~_${HOME}_")" \
		| sed "s_^~_${HOME}_")"
}
# z when fasd has enough paths
# function z() {
# 	cd "$(fasd -d $1 \
# 		| sed '/^common/d' \
# 		| sort --version-sort -r \
# 		| sed 's_^[0-9\. ]*__' \
# 		| sed "s_^${HOME}_~_" \
# 		| fzf -1 -0 --preview "exa -lhg --git --color=always \$(echo {} | sed "s_^~_${HOME}_")" \
# 		| sed "s_^~_${HOME}_")"
# }

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
