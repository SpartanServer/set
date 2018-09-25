[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx 
source ~/.zplug/init.zsh

# (1) プラグインを定義する
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zaw'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# Vanilla shell
zplug "yous/vanilli.sh"

# Additional completion definitions for Zsh
zplug "zsh-users/zsh-completions"

# Load the theme.
#zplug "yous/lime"

# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search", defer:2

# Tracks your most used directories, based on 'frecency'.
zplug "rupa/z", use:"*.sh"

# A next-generation cd command with an interactive filter
#zplug "b4b4r07/enhancd", use:init.sh

# This plugin adds many useful aliases and functions.
zplug "plugins/git",   from:oh-my-zsh


# (2) インストールする
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose


### 色付けで色の名前が使えたりとか
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -U colors && colors

# enhancd config
#export ENHANCD_COMMAND=ed
#export ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco

### history 設定
HISTFILE=~/.zsh_historyx
HISTSIZE=10000
SAVEHIST=10000

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

### 補完
autoload -U compinit; compinit -C

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2
### 補完候補に色を付ける。
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
### 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both

### 補完候補
### _oldlist 前回の補完結果を再利用する。
### _complete: 補完する。
### _match: globを展開しないで候補の一覧から補完する。
### _history: ヒストリのコマンドも補完候補とする。
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
#zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix
zstyle ':completion:*' completer _complete _ignored

## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
## 詳細な情報を使わない
zstyle ':completion:*' verbose no


setopt no_beep  # 補完候補がないときなどにビープ音を鳴らさない。
setopt no_nomatch # git show HEAD^とかrake foo[bar]とか使いたい
setopt prompt_subst  # PROMPT内で変数展開・コマンド置換・算術演算を実行
setopt transient_rprompt  # コマンド実行後は右プロンプトを消す
setopt hist_ignore_dups   # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_all_dups  # 重複したヒストリは追加しない
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_verify
setopt share_history  # シェルのプロセスごとに履歴を共有
setopt extended_history  # 履歴ファイルに時刻を記録
#setopt hist_expand  # 補完時にヒストリを自動的に展開する。
setopt append_history  # 複数の zsh を同時に使う時など history ファイルに上書きせず追加
#setopt auto_cd  # ディレクトリ名だけで移動
setopt auto_pushd  # cd したら pushd
setopt auto_list  # 補完候補が複数ある時に、一覧表示
setopt auto_menu  # 補完候補が複数あるときに自動的に一覧表示する
#setopt auto_param_slash
setopt list_packed
setopt list_types
setopt no_flow_control
setopt print_eight_bit
setopt pushd_ignore_dups
setopt rec_exact
setopt autoremoveslash
unsetopt list_beep
setopt complete_in_word  # カーソル位置で補完する。
setopt glob
setopt glob_complete  # globを展開しないで候補の一覧から補完する。
setopt extended_glob  # 拡張globを有効にする。
setopt mark_dirs   # globでパスを生成したときに、パスがディレクトリだったら最後に「/」をつける。
setopt numeric_glob_sort  # 辞書順ではなく数字順に並べる。
setopt magic_equal_subst  # コマンドライン引数の --prefix=/usr とか=以降でも補完
setopt always_last_prompt  # 無駄なスクロールを避ける


#cdpath=(.. ~ ~/prog)
function chpwd() { ls -AF --color }


#PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }

# プロンプト（左）
PROMPT=$'\e[1m%{%F{033}%}[%n@%m]%{${reset_color}%} \e[m%F{226}[%~]%{${reset_color}%} ${vcs_info_msg_0_}
'
PROMPT=$PROMPT'%F{154}>>>>%{${reset_color}%} '
PROMPT2='%F{154}>>%{${reset_color}%}' 

# プロンプト（右）
#RPROMPT='%{${fg[yellow]}%}[%~]%{${reset_color}%}'

#export LSCOLORS=exfxcxdxbxegedabagacad
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


#java
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/jre
#export PATH=$JAVA_HOME/bin:$PATH

#export PATH=$HOME/.gem/ruby/2.4.0/bin:$PATH

export http_proxy=http://proxy1.eng.u-hyogo.ac.jp:8080
export https_proxy=http://proxy1.eng.u-hyogo.ac.jp:8080
export ftp_proxy=ftp://proxy1.eng.u-hyogo.ac.jp:8080
export TERM=xterm-256color

export PATH="$PATH:$HOME/bin"

alias sudo="sudo -E"
#alias vim="nvim"

alias ls='ls --color -F'
alias relogin='exec $SHELL -l'
alias office='libreoffice'
alias cd..='cd ..'
alias sl='sl -aF'
alias mm='cmatrix -C cyan -b -u 1 -a '
alias pdf='evince'

function google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
#export PATH="$PYENV_ROOT/versions/anaconda3-5.1.0/bin:$PATH"
#export PATH="$PYENV_ROOT/versions/miniconda3-4.3.30/bin:$PATH"

# added by Anaconda3 installer
#export PATH="/home/kishi/anaconda3/bin:$PATH"
