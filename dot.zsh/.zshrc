# 色をつける
autoload -Uz colors && colors

# vi キーバインド
bindkey -v

# インサートモードでバックスペースが効かなくならないようにする
bindkey '^?' backward-delete-char

# ヒストリを共有
# setopt share_history

# 履歴に重複を記録しない
setopt hist_ignore_dups

# 履歴にスペースで始まるコマンドを記録しない
setopt hist_ignore_space

# 履歴の重複を古いほうから削除
setopt hist_ignore_all_dups

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# 古いコマンドと同じものは無視
setopt hist_save_no_dups

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history

# ヒストリに時刻情報もつける
setopt EXTENDED_HISTORY

# 入力途中の履歴補完を有効化する
autoload history-search-end

# HISTORY_IGNORE のコマンドをメモリにも載せない
zshaddhistory() {
  emulate -L zsh
  [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}

# エイリアス
alias ls='exa -a -s Name --color=auto --group-directories-first'
alias ll='ls -lBg --time-style=long-iso --git'
alias tree='ls -T'
alias tmux='tmux -2'
alias @repos=ghq-fzf

# 関数の検索パス
if [ -e /opt/homebrew  ]
then
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

if [ -e $HOME/.homebrew ]
then
  fpath=($HOME/.homebrew/share/zsh/site-functions $fpath)
fi

# 補完機能を有効にして実行する
autoload -Uz compinit && compinit -u

# GnuPG
if [[ ! $GPG_TTY ]]; then
  export GPG_TTY=$(tty)
fi

# tmux
if [ $TMUX ]
then
  alias fzf=fzf-tmux

  TMUX_VER=$(tmux -V | awk -F'[ . ]' '{printf "%02d%02d", $2, $3}')
  if [ "$TMUX_VER" -ge 0302  ]
  then
    FZF_POPUP_OPTS="-p 90%,80%"
  fi
  unset TMUX_VER
fi

# fzf で履歴検索
function history-fzf() {
  BUFFER=$(history -n -r 1 | fzf $FZF_POPUP_OPTS --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N history-fzf
bindkey '^r' history-fzf

# fzf でリポジトリのディレクトリに cd
function ghq-fzf() {
  local src=$(ghq list | fzf $FZF_POPUP_OPTS --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]
  then
    cd $(ghq root)/$src
  fi
}

# starship
eval "$(starship init zsh)"
