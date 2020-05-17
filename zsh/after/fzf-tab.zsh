FZF_TAB_COMMAND=(
	fzf
	--ansi
	--expect='$continuous_trigger'
	'--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
	--nth=2,3
	--delimiter='\x00'
	--layout=reverse
	--height='${FZF_TMUX_HEIGHT:=75%}'
	--tiebreak=begin
	--multi
	--bind=tab:down,btab:up,change:top,ctrl-s:toggle+down
	--cycle
	'--query=$query'
	'--header-lines=$#headers'
)
zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND

# Disable fzf-preview as a default
zstyle ':fzf-tab:*' extra-opts --preview=$extract''

# extract values in zstyle
# (experimental, may change in the future)
local extract="
# trim input(what you select)
in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion(some thing before or after the current word)
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
"

# give a preview of directory by exa when completing cd/z
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'

# group commands and show description
zstyle ':completion:*' format '[%d]'
zstyle ':completion:*' group-name ''

# Cache commands
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache-$ZSH_VERSION"

zstyle ':completion:*' matcher-list \
	'm:{a-zA-Z}={A-Za-z}' \
	'r:|[.,_-]=* r:|=*' \
	'r:|.=* r:|=*'
