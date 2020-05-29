# Execute code in the background
{
	# Activate extendedglob inside this function. (May be deactivated in global at some point)
	# This would break this code - probably without noticing.
	setopt extendedglob local_options
	# Recreate zcompdump if it is older than 20 hours.
	_comp_files=($HOME/.zsh/zcompdump_$ZSH_VERSION.zsh(Nm-20))
	if ! (( $#_comp_files )); then
		compdump -i -d $HOME/.zsh/zcompdump_$ZSH_VERSION.zsh
	fi
	unset _comp_files

	# Recompile outdated files in the background
	for file in $HOME/.zsh/**/*.zsh
	do
		[ ! "$file.zwc" -nt "$file" ] && zcompile "$file"
	done

	# Rehash rbenv
	rbenv rehash
} &!