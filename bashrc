#!/usr/bin/env bash

# Path to the bash-it configuration
export BASH_IT="$HOME/.bash_it"

# Path to the bash-it custom content
export BASH_IT_CUSTOM="$HOME/.bash_it_custom"

# Lock and Load a theme file
export BASH_IT_THEME="pabloferz"

# Dafualt terminal editor
export EDITOR="vim"

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING="git@git.domain.com"

# Change this to your console based IRC client of choice.
#export IRC_CLIENT="irssi"

# Set locale
export LANG="en_US.UTF-8"

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Don't check mail when opening terminal.
unset MAILCHECK

# Load Bash It
source $BASH_IT/bash_it.sh
