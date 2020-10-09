alias ovim=$(which vim)
alias vim="nvim"

function nvim() {
	if [ -u $NVIM_LISTEN_ADDRESS ]; then
		if [ $# -eq 0 ]; then
			command nvim -c 'Session!'
		else
			command nvim $@
		fi
	else
		nvr $@
	fi
}

function v() {
	if [ -n "$1" ]; then
		fasd_cd -d $@ && vim
	else
		nvim
	fi
}

function vv() {
	if [ -n "$1" ]; then
		zz $@ && vim
	else
		nvim
	fi
}

function fuzzy_open_file() {
	local editor
	editor="$1"
	shift
	if [ -e "$1" ]
	then "$editor" "$1"
	else
		local dir_glob file_glob
		if [ -n "$1" ]; then
			dir_glob="**/*$1*/**"
			file_glob="*$1*"
		fi
		file=$(rg --files --iglob "$dir_glob" --iglob "$file_glob" 2>/dev/null | fzfbat --multi -1 -0) \
			&& file=$(echo $file | tr '\n' ' ') \
			&& eval "fasd -A $file" \
			&& eval "$editor $file"
	fi
}

function fuzzy_search_open_file() {
	local editor depth
	editor="$1"
	depth="$2"
	shift ; shift

	local search="rg --hidden -l -i -F '$1'"
	if [ "$depth" -ne -1 ]; then
		search="$search --max-depth $depth"
	fi

	file=$(eval "$search" 2>/dev/null | fzf -0 -1 --preview "fuzzy_search_open_file_preview '$1' '{}'" --multi) \
		&& file=$(echo $file | tr '\n' ' ') \
		&& eval "fasd -A $file" \
		&& eval "$editor $file"
	}

function vrc() {
	local dir_glob file_glob
	if [ -n "$1" ]; then
		dir_glob="**/*$1*/**"
		file_glob="*$1*"
	fi
	file=$(rg --files "$DOTFILES" --iglob "$dir_glob" --iglob "$file_glob" 2>/dev/null | sed "s_^${HOME}_~_" | fzf -1 -0) \
		&& fasd -A "${file/\~/$HOME}" \
		&& nvim "${file/\~/$HOME}"
	}

function e() {
	if [ -e "$1" ]
	then nvim "$@"
	else
		local file
		files=$(fasd -lfR | fzfbat -m -0 -1 --query="$@") \
			&& files=$(echo $files | tr '\n' ' ') \
			&& eval "nvim $files"
	fi
}

alias ee="fuzzy_open_file nvim"
alias eee="fuzzy_search_open_file nvim -1"