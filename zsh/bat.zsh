if hash bat 2>/dev/null; then
	export BAT_THEME='base16-onedark'
	alias rcat="$(which cat)"
	alias cat="bat"
	alias ccat="bat --plain --paging=never"
	alias vcat="bat --paging=always"
else
	alias bat="cat"
	echo "[WARN] bat is not installed"
fi
