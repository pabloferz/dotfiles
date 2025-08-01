# For TTYs
if tty | grep tty; then
    export TERM=linux-16color
    printf %b '\e[40m' '\e[8]'  # set default background to color 0 'sonokai-bg0'
    printf %b '\e[37m' '\e[8]'  # set default foreground to color 7 'sonokai-fg'
    printf %b '\e]P02c2e34'     # redefine 'black'          as 'sonokai-bg0'
    printf %b '\e]P87f8490'     # redefine 'bright-black'   as 'sonokai-gray'
    printf %b '\e]P1fc5d7c'     # redefine 'red'            as 'sonokai-red'
    printf %b '\e]P9ff6077'     # redefine 'bright-red'     as 'sonokai-bg_red'
    printf %b '\e]P29ed072'     # redefine 'green'          as 'sonokai-green'
    printf %b '\e]PAa7df78'     # redefine 'bright-green'   as 'sonokai-bg_green'
    printf %b '\e]P3e7c664'     # redefine 'yellow'         as 'sonokai-yellow'
    printf %b '\e]PBedc763'     # redefine 'bright-yellow'  as 'sonokai-andromeda-yellow'
    printf %b '\e]P476cce0'     # redefine 'blue'           as 'sonokai-blue'
    printf %b '\e]PC85d3f2'     # redefine 'bright-blue'    as 'sonokai-bg_blue'
    printf %b '\e]P5b39df3'     # redefine 'magenta'        as 'sonokai-purple'
    printf %b '\e]PDab9df2'     # redefine 'bright-magenta' as 'sonokai-shusia-purple'
    printf %b '\e]P6f39660'     # redefine 'cyan'           as 'sonokai-orange'
    printf %b '\e]PEf89860'     # redefine 'bright-cyan'    as 'sonokai-andromeda-orange'
    printf %b '\e]P7e2e2e3'     # redefine 'white'          as 'sonokai-fg'
    printf %b '\e]PFffffff'     # redefine 'bright-white'   as '#ffffff'
    clear
fi

# if running bash
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
