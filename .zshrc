#!/usr/bin/zsh


#General
    umask 0066                        # set default permission when a file is created
    PATH=$PATH:/home/script:.


# Variables
    export HISTFILE=~/.histfile
    export HISTSIZE=1000
    export SAVEHIST=1000
    export GREP_COLOR=31
    export EDITOR=/usr/bin/vim
    export MANPAGER="/usr/bin/less"
    export MANPAGER="/usr/bin/most"
    export LC_ALL=en_US.UTF-8
    export LANG="$LC_ALL"
    export LANGUAGE="$LC_ALL"


# Prompt
    autoload -U colors && colors
    SHORTPROMPT="%{$fg[green]%}>%{$reset_color%}"
    MEDIUMPROMPT="%{$fg[blue]%}%n%{$reset_color%}@%{$fg[red]%}%m %{$fg_no_bold[green]%}[%1~] %{$reset_color%}%"
    LONGPROMPT="%{$fg[blue]%}%n%{$reset_color%}@%{$fg[red]%}%m %{$fg_no_bold[green]%}[%~] %{$reset_color%}%"
    RPROMPTDATE="%{$fg[cyan]%}%*%{$reset_color%}"
    
    PROMPT=$MEDIUMPROMPT

    alias short='export PROMPT=$SHORTPROMPT && export RPROMPT=""'
    alias medium='export PROMPT=$MEDIUMPROMPT && export RPROMPT=""'
    alias long='export PROMPT=$LONGPROMPT && export RPROMPT=$RPROMPTDATE'
    

# Aliases
    alias ls='ls --color=auto --human-readable -p --group-directories-first'
    alias l='ls'
    alias ll='ls -lA'

    alias cp='cp --interactive'
    alias mv='mv --interactive'
    alias rm='rm --interactive --verbose'
    
    alias grep='grep --color=auto'
    alias p='pwd'
    alias h='history'
    alias sshr='ssh rsomdecosteles@ssh.enseirb-matmeca.fr'

    # because typing 'cd' is A LOT of work!!
        alias ..='cd ../'
        alias ...='cd ../../'
        alias ....='cd ../../../'
        alias .....='cd ../../../../'



# Function duing. First arg: search depth
    #function dud (){
    #if[[$# == 0]]; then
        #echo 1
    #fi
    #du -h --max-depth=$1
#}


# Options
    unsetopt beep
    unsetopt hist_beep
    unsetopt list_beep
    unsetopt list_ambiguous


# Historique
    setopt inc_append_history
    setopt hist_ignore_dups
    setopt hist_ignore_space


# Correction
    setopt correctall


# Auto-completion
    autoload -U compinit
    compinit
    zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
    zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                                 /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh_cache
    zmodload zsh/complist


# Jokers étendus
    setopt extendedglob


# Git aliases
    alias g='git'
        compdef g=git
    alias gst='git status'
        compdef _git gst=git-status
    alias gco= 'git commit -m'
        compdef _git gco=git-commit-m
    alias gd='git diff'
        compdef _git gd=git-diff
    alias gl='git pull'
        compdef _git gl=git-pull
    alias gup='git pull --rebase'
        compdef _git gup=git-fetch
    alias gp='git push'
        compdef _git gp=git-push
    alias gd='git diff'
        gdv() { git diff -w "$@" | view - }
        compdef _git gdv=git-diff
    alias gdt='git difftool'


# SVN aliases
    alias s="svn"
        compdef s=svn
    alias sl="svn log"
        compdef _svn sl=svn-log
    alias sst="svn status"
        compdef _svn sst=svn-status
    alias sc="svn commit -m"
        compdef _svn sc=svn-commit-m
    alias sup="svn update"
        compdef _svn sup=svn-update
    alias sd="svn diff"
        compdef _svn sd=svn-diff
    alias saa="svn status | grep '^?' | sed 's/^? *\(.*\)/\"\1\"/g' | xargs svn add"
        compdef _svn saa=svn-status-add
    alias sra="svn status | grep '^!' | sed 's/^! *\(.*\)/\"\1\"/g' | xargs svn rm"
        compdef _svn sra=svn-status-rm

