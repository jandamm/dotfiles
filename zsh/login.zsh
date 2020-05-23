# Execute code in the background
{
	# Recompile outdated files in the background
	for file in $HOME/.zsh/**/*.zsh
	do
		[ ! "$file.zwc" -nt "$file" ] && zcompile "$file"
	done
} &!
