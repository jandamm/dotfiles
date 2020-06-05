# Execute code in the background
{
	# Activate extendedglob inside this function. (May be deactivated in global at some point)
	# This would break this code - probably without noticing.
	setopt extendedglob local_options
	# Recreate zcompdump if it is older than 20 hours.
	_comp_files=($HOME/.zsh/zcompdump_$ZSH_VERSION(Nm-24))
	if ! (( $#_comp_files )); then
		compdump -i -d $HOME/.zsh/zcompdump_$ZSH_VERSION
	else
		# dump if completion files where added.
		# This will get new completions for the next new shell.
		compinit -i -d $HOME/.zsh/zcompdump_$ZSH_VERSION
	fi
	unset _comp_files

	# Recompile outdated files in the background
	for file in $HOME/.zsh/**/*
	do
		[ -f $file ] && [ ! "$file.zwc" -nt "$file" ] && [ $file = ${file%zwc} ] && zcompile "$file"
	done

	# Rehash rbenv
	rbenv rehash
} &!
