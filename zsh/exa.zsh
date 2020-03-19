if hash exa 2>/dev/null; then
	alias l='exa -laahH --git'
	alias la='exa -lahgH --git'
	alias ll='exa -lhg --git'
	alias ls='exa -G'
	alias lsa='exa -laahgH --git'

	alias lt='exa -aT'
	alias lst='exa -T'

	alias rls='/bin/ls -G'
else
	echo "[WARN] exa is not installed"
fi
