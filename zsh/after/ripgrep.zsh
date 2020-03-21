export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

if hash rg 2>/dev/null; then
	alias alse="alias | rg -i"
	alias 'alias?'="alias | rg -i"
	alias rip="rg -i"
	alias '??'='rip'
	function rgfd() {
		rg --files --glob "**/*$1*/**" --glob "**$1**"
	}
else echo '[WARN] ripgrep is not installed'
fi
