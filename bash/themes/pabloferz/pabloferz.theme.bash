#added TITLEBAR for updating the tab and window titles with the pwd
case $TERM in
	xterm*)
	TITLEBAR='\[\033]0;\w\007\]'
	;;
	*)
	TITLEBAR=""
	;;
esac

function prompt_command() {
    PS1="${TITLEBAR}\u: \[\033[01;34m\]\w\[\033[00m\] \$ "
}

PROMPT_COMMAND=prompt_command;
