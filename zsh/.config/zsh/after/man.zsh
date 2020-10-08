function man() {
	if [ $# -eq 0 ]
	then
		command man
	else
		nvim "+Man $@" '+wincmd o'
	fi
}
