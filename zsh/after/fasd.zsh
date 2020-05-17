alias ..='cd ..'

alias a='fasd -a'
alias s='fasd -lR | fzf'
alias sd='fasd -lRd | fzf'
alias sf='fasd -lRf | fzf'
alias d='fasd -d'
alias f='fasd -f'
alias z='fasd_cd -d'

function zz() {
	cd "$(fasd -lRd $1 \
		| sed "s_^${HOME}_~_" \
		| fzf -1 -0 --preview "exa -lhg --git --color=always \$(echo {} | sed "s_^~_${HOME}_")" \
		| sed "s_^~_${HOME}_")"
}
