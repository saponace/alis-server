#!/usr/bin/zsh


#General
    umask 0066                        # set default permission when a file is created
    PATH=$PATH:/home/script:.


# Variables
    export ZSH=$HOME/.oh-my-zsh
    export HISTFILE=~/.histfile
    export HISTSIZE=1000
    export SAVEHIST=1000
    export GREP_COLOR=31
    export EDITOR=/usr/bin/vim
    export MANPAGER="/usr/bin/most -s"
    export LC_ALL=en_US.UTF-8
    export LANG="$LC_ALL"
    export LANGUAGE="$LC_ALL"


# Prompt
    autoload -U colors && colors
    PROMPT="%{$fg[blue]%}%n%{$reset_color%}@%{$fg[red]%}%m %{$fg_no_bold[green]%}[%1~] %{$reset_color%}%"


# Aliases
    alias grep='grep --color=auto'
    alias ls='ls --color=auto --human-readable -p --group-directories-first'
    alias l='ls'
    alias ll='ls -lA'
    alias p='pwd'
    alias cp='cp --interactive'
    alias mv='mv --interactive'
    alias rm='rm --interactive --verbose'
    alias Xrecord='ffmpeg -f x11grab -s 1280x800 -r 25 -i :0.0 -qscale 0 /tmp/out.mkv'
    alias sshr='ssh rsomdecosteles@ssh.enseirb-matmeca.fr'


# Options
    unsetopt beep
    unsetopt hist_beep
    unsetopt list_beep
    unsetopt list_ambiguous


# Historique
    setopt inc_append_history
    setopt hist_ignore_dups
    setopt hist_ignore_space
    HIST_STAMPS="dd.mm.yyyy"            # show date in history, OhMyZsh


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


# Bindkey
    case $TERM in 
        linux)
        bindkey "^[[2~" yank # Inser / Insertion
        bindkey "^[[3~" delete-char # Suppr / Retour arrière
        bindkey "^[[5~" up-line-or-history # Page Up / Page précédente
        bindkey "^[[6~" down-line-or-history # Page Down / Page suivante
        bindkey "^[[1~" beginning-of-line # Home / Début
        bindkey "^[[4~" end-of-line # End / Fin
        bindkey "^E" expand-cmd-path
        bindkey "^[[A" up-line-or-search
        bindkey "^[[B" down-line-or-search
    ;;
        *xterm*|*rxvt*)
        bindkey "^[[2~" yank # Inser / Insertion
        bindkey "^[[3~" delete-char # Suppr / Retour arrière
        bindkey "^[[5~" up-line-or-history # Page Up / Page précédente
        bindkey "^[[6~" down-line-or-history # Page Down / Page suivante
        bindkey "^[[7~" beginning-of-line # Home / Début
        bindkey "^[[8~" end-of-line # End / Fin
        bindkey "^E" expand-cmd-path
        bindkey "^[[A" up-line-or-search
        bindkey "^[[B" down-line-or-search
    ;;
    esac


#Oh my ZSH
    export ZSH=$HOME/.oh-my-zsh
    #ZSH_THEME="robbyrussel"
    source $ZSH/oh-my-zsh.sh
    plugins=(git)
