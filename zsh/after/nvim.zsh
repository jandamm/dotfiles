alias ovim=$(which vim)
alias vim="nvim"
alias vimplug="vim +PlugInstall +qa"
alias vimplup="vim +PlugUpdate +only"

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
	file=$(rg --files "$DOTFILES" "$DOTFILES_PRIVATE" --iglob "$dir_glob" --iglob "$file_glob" 2>/dev/null | sed "s_^${HOME}_~_" | fzf -1 -0) \
		&& fasd -A "${file/\~/$HOME}" \
		&& nvim "${file/\~/$HOME}"
}

function v() {
	local file
	files=$(fasd -lfR | fzfbat -m -0 -1) \
		&& files=$(echo $files | tr '\n' ' ') \
		&& eval "nvim $files"
}

alias e="fuzzy_open_file nvim"
alias vv="fuzzy_open_file nvim"
alias vvv="fuzzy_search_open_file nvim -1"
