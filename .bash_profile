source ~/.bashrc

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
