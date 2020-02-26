#!/usr/bin/env bash

function get_config_file() {
	filename="$1"
	dir="$(pwd)/${2%/*}"
	CONFIG="$dir/$filename"

	while [ ! -f "$CONFIG" ] && [ -n "$dir" ]
	do
		dir="${dir%/*}"
		CONFIG="$dir/$filename"
		if [ "$dir" == "$HOME" ]
		then break
		fi
	done

	echo "$CONFIG"
}
