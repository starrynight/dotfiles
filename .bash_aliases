export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS -G'
alias ll='ls $LS_OPTIONS -al'
alias l='ls $LS_OPTIONS -lA'

#Some more alias to avoid making mistakes:
#alias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


alias ..='cd ..'
alias ...='cd ..;cd ..'

