#!/usr/bin/env zsh

function compile() {
	for file in $HOME/.zsh/**/*
	do
		if [ ! -f $file ] || [[ $file = *.zwc ]]
		then continue
		elif [[ $file = *.zsh ]]
		then :
		else
			read -r firstline < $file
			if [[ ! $firstline = *zsh* ]]
			then
				continue
			fi
		fi

		[ ! $file.zwc -nt $file ] && zcompile $file
	done
}

# Recreate zcompdump if it is older than 24 hours.
# Recreate zcompdump if compinit detects changed files (number of files).
function dump() {
	# dump if completion files where added.
	# This will get new completions for the next new shell.
	autoload -Uz compinit && compinit -i -d $COMPDUMPNAME

	setopt extendedglob local_options
	_comp_files=($COMPDUMPNAME(Nm-24))
	if ! (( $#_comp_files )); then
		autoload -Uz compdump && compdump -i -d $COMPDUMPNAME
	fi
}

dump
compile
