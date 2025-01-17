# Added TITLEBAR for updating the tab and window titles with the pwd
if [[ $TERM = xterm* ]]; then
    TITLEBAR='\[\033]0;\w\007\]'
else
    TITLEBAR=""
fi

if [[ $(pstree -Ts $$ 2>/dev/null || pstree -s $$) = *sshd* ]]; then
    HOSTINFO="@\h"
else
    HOSTINFO=""
fi


function prompt_command() {
    PS1="${TITLEBAR}\u${HOSTINFO}: \[\033[01;34m\]\w\[\033[00m\] \$ "
}

PROMPT_COMMAND=prompt_command;
