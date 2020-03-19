#!/bin/bash

# returns window state
# nil if no window
window_state() {
	# list windows |
	# find lines with matching name |
	# take first match
	tmux list-windows -F '#I_#{window_active}  -  #W' |\
		grep -e "^[0-9]*_[0,1]  -  $1$" |\
		head -1
	}

# returns window name with active indicator
# nil if no window
has_window_with_name() {
	# just take name with indicator
	window_state "$1" | sed -e "s/^[0-9]*_[0,1]  -  \($1\)$/\1/"
}

# returns window name with active indicator
# nil if not active
window_with_name_active() {
	# check if name has 1 indicator
	has_window_with_name "$1" | grep -e '^[0-9]*_1  -  .*'
}

# returns number of window
window_number() {
	window_state "$1" | sed -e "s/^\([0-9]*\)_[0-1]  -  .*/\1/"
}

select_window() {
	tmux select-window -t "$(window_number "$1")" >> /dev/null
}
