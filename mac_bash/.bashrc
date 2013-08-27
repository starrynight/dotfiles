export EDITOR=/usr/local/bin/vim
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
alias ls='ls -G'
function parse_git_branch {

git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \(\1\)/'

}

 
function bash_prompt {
# Bash Prompt
# http://vansicklehq.com/post/2584550761/dark-theme-for-mac-terminal-with-cool-prompt

# export PS1="\[\033[1;30m\]\[[\033[\033[1;30m\]\033[1;33m\] \u@\H\[\033[1;32m\]\w\[\033[0m\] \[\033[1;30m\]\[]\]\n\[[\[ \[\033[1;31m\]\T\[\033[0m\]\[\033[1;30m\] \[]\] \[$\] \[\033[37m\]"

# Customise Prompt
# http://www.thegeekstuff.com/2008/09/bash-shell-ps1-10-examples-to-make-your-linux-prompt-like-angelina-jolie/
# Line Wrapper Issue
# insert \[ and \] around the ANSI escapes]
# http://hintsforums.macworld.com/archive/index.php/t-17068.html


local NONE="\[\033[0m\]"    # unsets color to term's fg color

# regular colors
local K="\[\033[0;30m\]"    # black
local R="\[\033[0;31m\]"    # red
local G="\[\033[0;32m\]"    # green
local Y="\[\033[0;33m\]"    # yellow
local B="\[\033[0;34m\]"    # blue
local M="\[\033[0;35m\]"    # magenta
local C="\[\033[0;36m\]"    # cyan
local W="\[\033[0;37m\]"    # white

# empahsized (bolded) colors
local EMK="\[\033[1;30m\]"
local EMR="\[\033[1;31m\]"
local EMG="\[\033[1;32m\]"
local EMY="\[\033[1;33m\]"
local EMB="\[\033[1;34m\]"
local EMM="\[\033[1;35m\]"
local EMC="\[\033[1;36m\]"
local EMW="\[\033[1;37m\]"

# background colors
local BGK="\[\033[40m\]"
local BGR="\[\033[41m\]"
local BGG="\[\033[42m\]"
local BGY="\[\033[43m\]"
local BGB="\[\033[44m\]"
local BGM="\[\033[45m\]"
local BGC="\[\033[46m\]"
local BGW="\[\033[47m\]"

local USER_COLOR=$EMY                 # user's color
local PROMPT_SIGN="$"
[ $UID -eq "0" ] && USER_COLOR=$R   # root's color
[ $UID -eq "0" ] && PROMPT_SIGN="#"

local HOST_COLOR=$USER_COLOR
if [ $HOSTNAME =  "other computer" ]; then 
  HOST_COLOR=$B
fi

local GREY=$EMK
local TIME_COLOR=$EMR
local PATH_COLOR=$EMG
local GIT_COLOR=$C
local COUNTER_COLOR=$M
local END_COLOR='\[\e[0m\]'



# In ` ` command, the ; in color code must be escaped. Therefore, cannot use code directly
export PS1="$GREY[$TIME_COLOR\t$GREY] $USER_COLOR\u$HOST_COLOR@\H: $PATH_COLOR\w$END_COLOR $GIT_COLOR$(parse_git_branch)\n$GREY[$COUNTER_COLOR\!$GREY]\`if [ \$? = 0 ];then echo \[\033[0\;37m\]; else echo \[\033[0\;31m\]; fi\` $PROMPT_SIGN $END_COLOR"


}


bash_prompt
unset bash_prompt
export LSCOLORS=ExFxCxDxBxegedabagacad

#Default
#export PROMPT_COMMAND='echo -ne "\033];${PWD/#$HOME/~}\007"'


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


#local version alias 
alias python2.6='/usr/local/bin/python'


#To fix the TAB key binding issue while manually compiling python 64-bit
export PYTHONSTARTUP=$HOME/.pystartup


