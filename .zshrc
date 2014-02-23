# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gnzh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git cp common-aliases colored-man debian gem gpg-agent ssh-agent urltools vi-mode web-search z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# ssh agent forwarding support
zstyle :omz:plugins:ssh-agent agent-forwarding on
# zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa2 id_github

function mkcd() {
    mkdir -p "$1" && cd "$1"
}

function lcd() {
	cd "$1" && l
}

function sprunge() {
cat $1 | curl -F 'sprunge=<-' http://sprunge.us
}

function ipsort() {
	sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4
}

ex(){
if [ -f $1 ] ; then
case $1 in
*.tar.bz2) tar xjf $1 ;;
*.tar.gz) tar xzf $1 ;;
*.bz2) bunzip2 $1 ;;
*.rar) rar x $1 ;;
*.gz) gunzip $1 ;;
*.tar) tar xf $1 ;;
*.tbz2) tar xjf $1 ;;
*.tgz) tar xzf $1 ;;
*.zip) unzip $1 ;;
*.Z) uncompress $1 ;;
*.7z) 7z x $1 ;;
*) echo "'$1' cannot be extracted via extract()" ;;
esac
else
    echo "'$1' is not a valid file"
fi
}

alias grpe='grep'
alias cont='sudo pkill -SIGCONT'
alias nautilus='nautlius --no-desktop'
alias x='exit'
alias shr='shred -vzfun 8'
alias c='clear'
alias ash='adb shell'
alias ack='ack-grep'
alias ccat='pygmentize -g'
alias findn='find . -name'
alias findi='find . -iname'

function vf () {
    if [ -n $1 ] ; then
        $EDITOR $(find . -name $1)
    else
        echo 'missing search string'
    fi
}

function vaf () {
    if [ -n $1 ] ; then
        $EDITOR $(find . $@)
    else
        echo 'missing search args'
    fi
}

export LESSOPEN="|/usr/bin/lesspipe %s"
export ip="([0-9]{1,3}\.){3}[0-9]{1,3}"
export EDITOR="/usr/bin/vim"
export XDG_CONFIG_HOME="$HOME/.config"
export TERM=xterm-256color
# speed up android builds
export USE_CCACHE=1

# vim keybindings in bash!
set -o vi

# fix reverse tabbing
bindkey '^[[Z' reverse-menu-complete


# set PATH so it includes user's private bin if it exists
export NDK="$HOME/bin/android-ndk"
export ANDROID_HOME="$HOME/bin/adt-bundle-linux-x86_64/sdk"
export ANDROID_SDK=$ANDROID_HOME
export CLASSPATH="/usr/lib/jvm/java-7-openjdk-amd64/lib/tools.jar:/usr/share/java:."

source $HOME/.pvtrc
