export EDITOR=vim
export GREP_OPTIONS='--color=auto'
export HISTORY_IGNORE="(jobs|fg|cd|pwd|l[sla])"
export HISTSIZE=100000
export LANG=ja_JP.UTF-8
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export SAVEHIST=100000

if [ -e /opt/homebrew/bin/brew ]
then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

if [ -e $HOME/.homebrew/bin/brew ]
then
  eval $($HOME/.homebrew/bin/brew shellenv)
fi

if [ -e $HOME/.go ]
then
  export GOPATH=$HOME/.go
  export PATH=$GOPATH/bin:$PATH
fi

if [ -e "$HOME/.cargo/env" ]
then
  source "$HOME/.cargo/env"
fi
