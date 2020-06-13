# Execute code in the background
{
	# Recreate zcompdump if it is older than 24 hours.
	# Recreate zcompdump if number of files changed.
	# Recompile outdated files.
	$DOTFILES/scripts/compile_zsh.zsh

	# Rehash rbenv
	rbenv rehash 2>/dev/null
} &!
