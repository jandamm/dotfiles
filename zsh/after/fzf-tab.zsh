FZF_TAB_COMMAND=(
	fzf
	--ansi
	--expect='$continuous_trigger'
	'--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
	--nth=2,3 --delimiter='\x00'
	--layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
	--tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-s:toggle --cycle
	'--query=$query'
	'--header-lines=$#headers'
)
zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND

# Disable fzf-preview as a default
zstyle ':fzf-tab:*' extra-opts --preview=$extract''

# give a preview of directory by exa when completing cd
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'

# group commands and show description
zstyle ':completion:*' format '---- %d'
