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
    if [[ $(pstree -Ts $$ 2>/dev/null || pstree -s $$) = *sshd* ]]; then
        host="@\h"
    else
        host=""
    fi
    PS1="${TITLEBAR}\u${host}: \[\033[01;34m\]\w\[\033[00m\] \$ "
}

PROMPT_COMMAND=prompt_command;
