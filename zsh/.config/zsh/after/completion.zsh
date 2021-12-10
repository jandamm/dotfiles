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
