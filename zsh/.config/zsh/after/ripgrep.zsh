export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

alias alse="alias | rg -i"
alias 'alias?'="alias | rg -i"
alias rip="rg -i"
alias '??'='rip'
function rgfd() {
	rg --files --glob "**/*$1*/**" --glob "**$1**"
}
