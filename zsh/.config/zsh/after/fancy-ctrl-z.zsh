function fg-fzf() {
	job="$(jobs  | sed -E '/\(pwd now: .*\)/d' | fzf -0 -1 | sed -E 's/\[(.+)\].*/\1/')" && echo '' && fg %$job
}

# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
function fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0 ]] || [ $BUFFER = $INSTANT_REPL_PREFIX ]; then
		BUFFER=" fg-fzf"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fancy-ctrl-z
