alias ..='cd ..'

alias a='fasd -a'
alias s='fasd -s | sort --version-sort -r | sed "s_^[0-9\. ]*__" | fzf'
alias sd='fasd -sd | sort --version-sort -r | sed "s_^[0-9\. ]*__" | fzf'
alias sf='fasd -sf | sort --version-sort -r | sed "s_^[0-9\. ]*__" | fzf'
alias d='fasd -d'
alias f='fasd -f'
alias z='fasd_cd -d'

function zz() {
	cd "$(fasd -sd $1 \
		| sed '/^common/d' \
		| sort --version-sort -r \
		| sed 's_^[0-9\. ]*__' \
		| sed "s_^${HOME}_~_" \
		| fzf -1 -0 --preview "exa -lhg --git --color=always \$(echo {} | sed "s_^~_${HOME}_")" \
		| sed "s_^~_${HOME}_")"
}
