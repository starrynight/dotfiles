source ~/.bashrc


#if [ "$TERM_PROGRAM" = 'Apple_Terminal' ] ;then
#export PROMPT_COMMAND="/usr/local/bin/SmartTitle -s -d 0"
#fi


 
#export PS1="\u@\h:\w $"


export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
#export PATH=$PATH:"/Library/Frameworks/Python.framework/Versions/2.6/bin"


# remove duplicates in PATH, but keep the order
# e.g. in ~/.bash_login at the very end
PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"
# cf. http://chunchung.blogspot.com/2007/11/remove-duplicate-paths-from-path-in.html
#PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}')"
PATH="${PATH%:}"    # remove trailing colon
export PATH
# See also https://sites.google.com/site/jdisnard/path-dupes
