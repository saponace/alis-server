
export LANG=en_US.UTF-8
export LANGUAGE=${LANG}
export LC_ALL=${LANG}


zmodload zsh/{datetime,stat,zpty,system,clone,zprof,zselect}
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &> /dev/null
autoload -Uz zargs zcalc



#----- Aliases
## ls
    alias ls='ls --color=auto --human-readable -p --group-directories-first'
    alias l='ls'
    alias ll='ls -lArt'

## mkdir
    alias md=mkdir
    alias mdc=mkdirc

## interactive cp/mv/rm
    alias rd=rmdir
    alias cp='cp --interactive'
    alias mv='mv --interactive'
    alias rm='rm --interactive --verbose'

## because typing 'cd' is A LOT of work!!
    alias ..='cd ../'
    alias ...='cd ../../'
    alias ....='cd ../../../'
    alias .....='cd ../../../../'

# Git and svn aliases at the end becauses need to set completion before 

## Misc
[[ -n ${commands[python2]} ]] && alias py=python2
[[ -n ${commands[bzip2]} ]] && alias bz=bzip2
[[ -n ${commands[gzip]} ]] && alias gz=gzip
alias _=sudo





## Miscellaneous options
    setopt no_beep auto_cd


## try to avoid the 'zsh: no matches found...'
    setopt no_nomatch


## correction
    setopt correct

    

#----- Signals stuff
## do not send the HUP signal to running jobs when the shell exits
setopt no_hup
## display PID when suspending processes
setopt long_list_jobs
## stopped jobs that are removed from the job table with the disown builtin command are automatically sent a SIGCONT to make them running
setopt auto_continue




## Command prompt settings
## enable parameter expansion, command substitution and arithmetic expansion in prompts
setopt prompt_subst
## remove any right prompt from display when accepting a command line. This may be useful with terminals with other cut/paste methods
setopt transient_rprompt
## this is needed by a lot of function in this zshrc
autoload -Uz colors && colors





#----- Prompts
## Long prompt
[[ ${EUID} -ne 0 ]] && EUIDCOLOR=${fg_bold[blue]} || EUIDCOLOR=${fg[red]}
if [[ ${terminfo[colors]} == 256 ]];then
    FRAMECOLOR='%F{247}'
    FRAMECOLOR2='%f'
    EUIDCOLOR='%F{99}'
    if [[ ${EUID} -eq 0 ]];then
        HOSTNAMECOLOR='%B%F{black}'
        HOSTNAMECOLOR2='%F{white}'
    else
        HOSTNAMECOLOR='%F{82}'
        HOSTNAMECOLOR2='%F{247}'
    fi
    HOSTNAMECOLOR3='%F{red}' HOSTNAMECOLOR4='%f%b'
    TIMEDATECOLOR='%F{99}'
    TIMEDATECOLOR2='%f'
    PWDCOLOR=' %F{250}'
    PWDCOLOR2='%f'
else
    FRAMECOLOR='%B%F{blue}'
    FRAMECOLOR2='%f%b'
    if [[ ${EUID} -eq 0 ]];then
        HOSTNAMECOLOR='%B%F{black}'
        HOSTNAMECOLOR2='%F{red}'
    else
        HOSTNAMECOLOR='%B%F{green}'
        HOSTNAMECOLOR2='%F{black}'
    fi
    HOSTNAMECOLOR3='%F{cyan}'
    HOSTNAMECOLOR4=''
    TIMEDATECOLOR='%b%F{magenta}'
    TIMEDATECOLOR2='%f'
    PWDCOLOR=' '
    PWDCOLOR2=''
fi

[[ ${LANG} =~ UTF-8 ]] && LONGPROMPT=$'\n'"${FRAMECOLOR}┌[${FRAMECOLOR2}%f%b${HOSTNAMECOLOR}%n${HOSTNAMECOLOR2}@${HOSTNAMECOLOR3}%m${HOSTNAMECOLOR4}${FRAMECOLOR}]─[${FRAMECOLOR2}${TIMEDATECOLOR}%D{%F %T}${TIMEDATECOLOR2}${FRAMECOLOR}]${FRAMECOLOR2}%(?..${FRAMECOLOR}─[%B%F{red}%?%f%b${FRAMECOLOR}]${FRAMECOLOR2})${PWDCOLOR}%~${PWDCOLOR2}\$(_-git_ps1)"$'\n'"${FRAMECOLOR}└─>${FRAMECOLOR2}%{${EUIDCOLOR}%} %#%f%b "

PS2='%F{blue}> %f'
RPS2='%F{red}\%f'
unset EUIDCOLOR FRAMECOLOR FRAMECOLOR2 HOSTNAMECOLOR HOSTNAMECOLOR2 HOSTNAMECOLOR3 HOSTNAMECOLOR4 TIMEDATECOLOR TIMEDATECOLOR2 PWDCOLOR PWDCOLOR2

## Git PS1
_-git_ps1() {
    if [[ -n ${commands[git]} ]];then
        if [[ ${terminfo[colors]} == 256 ]];then
            ZSH_THEME_GIT_PROMPT_PREFIX=' %F{32}[%F{111}'
            ZSH_THEME_GIT_PROMPT_DIRTY='%F{214}*'
            ZSH_THEME_GIT_PROMPT_STASHED='%F{180}+'
            ZSH_THEME_GIT_PROMPT_SUFFIX='%F{32}]%f'
            ZSH_THEME_GIT_PROMPT_SUBPREFIX='%F{32}─[%f'
        else
            ZSH_THEME_GIT_PROMPT_PREFIX=' %F{blue}%B[%b%F{green}'
            ZSH_THEME_GIT_PROMPT_DIRTY='%F{yellow}%B*'
            ZSH_THEME_GIT_PROMPT_STASHED='%F{yellow}+'
            ZSH_THEME_GIT_PROMPT_SUFFIX='%F{blue}%B]%b%f'
            ZSH_THEME_GIT_PROMPT_SUBPREFIX='%F{blue}%B─[%b%f'
        fi
        _git_if_dirty() {
            [[ -n $(command git status -s --ignore-submodules=dirty 2> /dev/null | tail -n1) ]] && print ${ZSH_THEME_GIT_PROMPT_DIRTY}
        }
        _git_if_stashed() {
            { command git rev-parse --verify refs/stash &> /dev/null } && {
                print ${ZSH_THEME_GIT_PROMPT_SUBPREFIX}${ZSH_THEME_GIT_PROMPT_STASHED}${ZSH_THEME_GIT_PROMPT_SUFFIX}
            }
        }
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || ref=$(command git rev-parse --short HEAD 2> /dev/null) && echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref#refs/heads/}$(_git_if_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}$(_git_if_stashed)"
    fi
}

## Short Prompt
SHORTPROMPT="%{$fg[green]%}>%{$reset_color%}"


## Aliasing prompt changes
alias short='export PROMPT=$SHORTPROMPT && export RPROMPT=""'
alias long='export PROMPT=$LONGPROMPT'



## Long prompt as default prompt
PS1=$LONGPROMPT






#----- Resources limit
unlimit
limit coredumpsize 0
limit -s


#-----  History
## save each command's beginning timestamp and the duration to the history file
setopt extended_history
## remove command lines from the history list when the first character on the line is a space
setopt hist_ignore_space
## if a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt hist_ignore_all_dups
## whenever the user enters a line with history expansion, don’t execute the line directly; instead, perform history expansion and reload the line into the editing buffer
setopt hist_verify
## append the history to history file as soon as they are entered rather than waiting until the shell exits
setopt inc_append_history
## import new commands from the history file also in other zsh-session
setopt share_history
## remove superfluous blanks from each command line being added to the history list
setopt hist_reduce_blanks
## the file to save the history
HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory
## the maximum number of events stored in the internal history list
HISTSIZE=65535
## the maximum number of history events to save in the history file
SAVEHIST=${HISTSIZE}
## Directory history settings
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
## number of directory cached in history
zstyle ':chpwd:*' recent-dirs-max 10
## file to save the directory history
zstyle ':chpwd:*' recent-dirs-file ${ZDOTDIR:-$HOME}/.zdirs





#----- Completion
## Completion settings
setopt complete_in_word auto_name_dirs
## if a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word
setopt always_to_end
## try to make the completion list smaller (occupying less lines) by printing the matches in columns with different widths
setopt listpacked
## enable sorted/grouped completion
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format $'%{\e[0;32m%}completing %B%d%b%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
## sort man-pages by section
zstyle ':completion:*:manuals' separate-sections 1
zstyle ':completion:*:manuals.*' insert-sections 1
## enable colored filename completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## if there are more than three options allow selecting from a menu
zstyle ':completion:*' menu select=3
## case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
## try to complete file at the end, maybe useful if a completion function is broken
#zstyle ':completion:*' completer _complete _match _approximate _expand_alias _ignored _files
## function name that start with a underline should NOT be included in the completion list
zstyle ':completion:*:*:*:functions' ignored-patterns '_*'
## ignore current directory when ../ ; see also http://www.zsh.org/mla/workers/2014/msg00246.html
zstyle ':completion:*:*:*' ignore-parents parent pwd
## order of the tilde completion, only make sense when enable sorted/grouped completion
zstyle ':completion:*:-tilde-:*' group-order named-directories directory-stack local-directories users
## TODO: sent a mail to zsh-users about that
zstyle ':completion:*:-tilde-::named-directories' ignored-patterns '_*'
## ignore the users that uninterested except really expected
zstyle ':completion:*:*:*:users' ignored-patterns adm amanda amule apache at avahi avahi-autoipd beaglidx bin cacti canna colord clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm git gkrellmd gopher hacluster haldaemon halt http hsqldb ident incron junkbust kdm ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios named nbd netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn operator pcap pdnsd polkitd postfix postgres privoxy pulse pvm quagga radvd rpc rpcuser rpm rtkit sagemath scard shutdown squid sshd statd svn sync tftp tor usbmux uucp uuidd vcsa wwwrun xfs '_*' 'systemd-*' ${USERNAME}
zstyle ':completion:*' single-ignored show
autoload -Uz compinit
compinit
for i in i386 x86_64 linux32 linux64 pty ptypg stdoutisatty unbuffer me proxychains grc rlwrap;do
    compdef ${i}=command
done





## Print the complete command and check correctness
_-accept-line() {
	local -a WORDS
	WORDS=( ${(z)BUFFER} )
	local -r FIRSTWORD=${WORDS[1]}
	local -r GREEN=$'\e[32m' RESET_COLORS=$'\e[0m'
	[[ "$(whence -w $FIRSTWORD 2>/dev/null)" == "${FIRSTWORD}: alias" ]] &&
	echo -n $'\n'"${GREEN}Executing: $(whence $FIRSTWORD)${RESET_COLORS}"
	zle .accept-line
}
	zle -N accept-line _-accept-line





## grep: exclude these special directories for a better matching speed
[[ -n ${commands[grep]} ]] && {
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32';for PATTERN in .{cvs,git,hg,svn};do GREP_OPTIONS+=" --exclude-dir=${PATTERN}" done
}




# less as default pager/viewer
[[ -n ${commands[less]} ]] && {
export PAGER=less
export MANPAGER=${PAGER}
export VISUAL=${PAGER}
}
[[ -n ${commands[vim]} ]] && export EDITOR=vim
export TAR_OPTIONS='--delay-directory-restore'
[[ -n ${commands[journalctl]} ]] && export SYSTEMD_LESS=FRXM
[[ -n ${commands[less]} ]] && export LESS=RM
[[ -n ${commands[urxvtd]} ]] && export RXVT_SOCKET=/tmp/rxvt-unicode-${EUID}-${HOST}





## for colored man page
[[ -n ${commands[less]} ]] && export LESS_TERMCAP_mb=$'\E[1;31m' \
    LESS_TERMCAP_md=$'\E[1;36m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[01;44;33m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[1;32m'





## create a dir and cd in it
mkdirc() {
    if [[ $# -ne 1 || "${1}" == '--help' ]];then
        _-automatic-colored
        print "${bldblu}Usage:${rst} ${bldgrn}mkdirc${rst} [${bldcyn}DIRECTORY${rst}]
        ${bldgrn}mkdirc${rst} create a directory and then change the current working directory to the created directory.

        ${bldcyn}--help${rst}     help information(this screen)
        ${bldcyn}--version${rst}  print the version"
        [[ $# -ne 1 ]] && return 1
    elif [[ "${1}" == '--version' ]];then
        local VERSION=0.0
        echo "mkdirc v${VERSION}"
    elif [[ ! -d "${1}" ]];then
        _-automatic-colored
        echo -n "${grn}";mkdir -pv "${1}" && cd "${1}";echo -n "${rst}"
    else
        _-automatic-colored
        echo "${cyn}mkdirc: \`${1}\' already exists${rst}"
        cd "${1}"
    fi
}





## create a random named tmp file and cd in it
cdtmp() {
    if [[ "${1}" == '--help' || "${1}" == '-h' || $# -gt 1 ]];then
        _-automatic-colored
        echo "${bldblu}Usage:${rst} ${bldgrn}cdtmp${rst} [${bldcyn}OPTION${rst}]
        create a temporary directory and then change the current working directory to the created directory.
        ${bldcyn}-h${rst}, ${bldcyn}--help${rst}    help information(this screen)"
    else
        local dir=$(mktemp -d)
        _-automatic-colored
        echo "${grn}Executing: cd ${dir}${rst}"
        cd ${dir}
    fi
}





## print current tty
tty() {
    if [[ $# -eq 0 ]];then
        print ${TTY}
    else
        command tty $@
    fi
}





## dowload a webpage
fetch() {
    if [[ $# -ge 1 && ${1} != '--help' && ${1} != '-h' ]];then
        for i in $@;do
            curl -fL --retry 3 --retry-delay 3 --connect-timeout 7 -o ${i##*/} ${i}
        done
    else
        print 'Usage: fetch [URL]...\n\nA wrapper function for curl'
    fi
}





## List installed packages
[[ -n ${commands[package-query]} && -n ${commands[less]} ]] && pacls() {
local _if_pager
[[ -t 1 ]] && _if_pager=ptypg || _if_pager=pty
if [[ -z "${1}" || "${1}" == '-1' ]];then
    ${_if_pager} package-query -Qe --sort date
elif [[ "${1}" == '-s' ]];then
    ${_if_pager} package-query -Qe --sort size
elif [[ "${1}" == '-n' ]];then
    ${_if_pager} package-query -Qe
else
    print 'Usage: pacls [OPTION]
    pacls print the explicitly installed package list

    -1,   sort by date(default)
    -n,   sort by alphabet
    -s,   sort by package size'
fi
}





## Display help
help() {
    local HELPDIR=${HELPDIR:-/usr/share/zsh/${ZSH_VERSION}/help}
    [[ ${1} == '.' ]] && 1=dot
    [[ ${1} == ':' ]] && 1=colon
    if [[ $# -eq 0 || ${1} == '-l' || ${1} == '--help' || ${1} == '-h' ]];then
        _-automatic-colored
        [[ $# -eq 0 || ${1} == '--help' || ${1} == '-h' ]] && echo "${bldblu}Usage:${rst} ${bldcyn}help${rst} [${bldgrn}zsh-builtin-command${rst}]\n"
        ls ${HELPDIR}
        if [[ $# -eq 0 || ${1} == '--help' || ${1} == '-h' ]];then
            for n ({1..${COLUMNS}}) ; do printf '%s' -;done;echo
                echo "* ${bld}RTFM${rst}(Read the fine/f*cking manual): ${bldgrn}man what-manual-page-you-want${rst}, this is the 1st thing you should do before asking.
                * ${bld}GIYF${rst}(Google is your Friend), so please google before asking questions: ${bldgrn}elinks ${bldcyn}google.com${rst}
                * ${bld}RTFW${rst}(Read the fine wiki): The community-maintained ${bldcyn}ArchWiki${rst} is the primary resource that should be consulted if issues arise: ${bldgrn}elinks ${bldcyn}wiki.archlinux.org${rst}
                * The IRC Channel(${bldcyn}irc://irc.freenode.net/#archlinux${rst}) and the forums(${bldcyn}https://bbs.archlinux.org${rst}) are also good places for asking if an answer cannot be found elsewhere."
                [[ -t 1 ]] && echo
            fi
            return 0
        elif [[ -n ${HELPDIR:-} && -r ${HELPDIR}/${1} && ${1} != compctl ]];then
            if [[ -n ${commands[${PAGER:-less}]} ]];then
                ${PAGER:-less} ${HELPDIR}/${1}
            else
                cat ${HELPDIR}/${1}
            fi
            return $?
        else
            man $@
        fi
}





## Create backup file
~() {
_-intro() {
    _-automatic-colored
    echo "${bldblu}Usage:${rst} ${bldgrn}~${rst} [${bldcyn}FILE${rst}]
    backup a file or directory using cp(1)

    The target file name is the original name plus a time stamp attached.(%Y%m%d%H%M%S)"
}
if [[ $# -eq 0 && ${PWD} != ${HOME} ]];then
    cd ${HOME}
elif [[ $# -eq 1 ]];then
    _-automatic-colored
    if [[ ! -e ${1} ]];then
        echo "${bldred}==> ${bld}Aborted: File ${1} doesn't exist${rst}\n"
        _-intro
        return 1
    elif [[ ! -f ${1} ]];then
        echo "${bldred}==> ${bld}Aborted: ${1} is not a regular file${rst}"
        return 1
    elif [[ ! -r ${1} ]];then
        echo "${bldred}==> ${bld}Aborted: File is unaccessible${rst}"
        return 1
    elif [[ ! -s ${1} ]];then
        echo "${bldblu}==> ${bld}Cancelled: This is a zero-byte file, just why do you want to backup it?${rst}"
        return 2
    else
        local DESTNATIONFILENAME="${1}~`strftime '%Y%m%d%H%M%S' ${EPOCHSECONDS}`"
        cp -b "${1}" "${DESTNATIONFILENAME}" && echo "${bldgrn}==> ${bld}Finish writing backup: ${DESTNATIONFILENAME}${rst}"
    fi
else
    _-intro
fi
unset -f _-intro
}





## Sudo su insted of su, plus warning
su() {
    if [[ ${EUID} -ne 0 && -n ${commands[sudo]} ]];then
        print "\e[1;32m==> \e[1;37mNote: Never run \e[1;31msu\e[1;37m directly except the \e[1;32msudo\e[1;37m is unusable.\e[0m (use \e[1;32munset -f su\e[0m to disable this automatic notification)"
        print "\e[1;34m==> \e[0;32mExecuting: sudo su\e[0m"
        sudo -- su $@
    else
        command su $@
    fi
}





## Print availible disk space
df() {
    if [[ $# -eq 0 ]];then
        command df -h
    else
        command df $@
    fi
}





## Print files size
[[ -n ${commands[${PAGER:-less}]} ]] && du() {
if [[ $# -eq 0 && -t 0 ]];then
    command du -h | ${PAGER:-less}
else
    command du $@
fi
}





## Show who is logged on and what they are doing
[[ -n ${commands[w]} ]] && w() {
if [[ $# -eq 0 ]];then
    command w -f
else
    command w $@
fi
}





## Show who is logged on
[[ -n ${commands[who]} ]] && who() {
if [[ $# -eq 0 ]];then
    command who -HprtTud
else
    command who $@
fi
}

## History
[[ -n ${commands[${PAGER:-less}]} ]] && hist() {
if [[ $# -eq 0 && -t 0 ]];then
    fc -il 1 | ${PAGER:-less}
else
    builtin history $@
fi
}





## Print terminal display infos
rsz() {
    if [[ -t 0 && $# -eq 0 ]];then
        local IFS='[;' escape geometry x y
        print -n '\e7\e[r\e[999;999H\e[6n\e8'
        read -sd R escape geometry
        x=${geometry##*;} y=${geometry%%;*}
        if [[ ${COLUMNS} -eq ${x} && ${LINES} -eq ${y} ]];then
            print "${TERM} ${x}x${y}"
        else
            print "${COLUMNS}x${LINES} -> ${x}x${y}"
            stty cols ${x} rows ${y}
        fi
    else
        [[ -n ${commands[repo-elephant]} ]] && repo-elephant || print 'Usage: rsz'
    fi
}





_-automatic-colored() {
    if [[ ${1} == unset || ! -t 1 ]];then
        unset rst bld bldwht bldblk bldred bldgrn bldylw bldblu bldcyn blk red grn ylw blu cyn gry
    elif [[ -t 1 ]];then
        rst="${reset_color}"
        bld="${fg_bold[default]}"
        bldwht="${fg_bold[white]}"
        bldblk="$fg_bold[black]"
        bldred="$fg_bold[red]"
        bldgrn="$fg_bold[green]"
        bldylw="$fg_bold[yellow]"
        bldblu="$fg_bold[blue]"
        bldmgt="${fg_bold[magenta]}"
        bldcyn="$fg_bold[cyan]"
        gry="${fg[white]}"
        blk="$fg[black]"
        red="$fg[red]"
        grn="$fg[green]"
        ylw="$fg[yellow]"
        blu="$fg[blue]"
        mgt="${fg[magenta]}"
        cyn="$fg[cyan]"
    fi
}





## Terminal emulator title settings ##
case ${TERM} in
    xterm*|rxvt*|ansi)
        _default_terminal_title() {
            print -n '\e]0;'${(%):-'%n@%m'}'\a'
        }
        _command_terminal_title() {
            setopt local_options extended_glob
            print -n '\e]0;'${1[(wr)^(*=*|command|sudo|ssh|rake|i386|x86_64|linux32|linux64|pty|ptypg|stdoutisatty|unbuffer|me|proxychains|grc|rlwrap|-*)]:gs/%/%%}${(%):-' - %n@%m'}'\a'
        }
        add-zsh-hook precmd _default_terminal_title
        add-zsh-hook preexec _command_terminal_title ;;
esac





## make sure that the terminal is in application mode when zle is active, since only then values from ${terminfo} are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} ));then
    zle-line-init() {
        echoti smkx
    }
    zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

## C-x,C-e: edit the current command line in ${EDITOR}
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
## up: match history forward
[[ -n ${terminfo[kcuu1]} ]] && bindkey ${terminfo[kcuu1]} up-line-or-search
## down: match history backward
[[ -n ${terminfo[kcud1]} ]] && bindkey ${terminfo[kcud1]} down-line-or-search
## home: go to beginning of line
[[ -n ${terminfo[khome]} ]] && bindkey ${terminfo[khome]} beginning-of-line
## end: go to end of line
[[ -n ${terminfo[kend]} ]] && bindkey ${terminfo[kend]} end-of-line
## perform history expansion and insert a space into the buffer; this is intended to be bound to space
bindkey ' ' magic-space
## FIXME: use a more general(less keymap-specific) way to set these key bindings which are not supported by vt100 and not in the terminfo library. See also http://stackoverflow.com/questions/7767702 http://www.leonerd.org.uk/code/libtermkey/ http://stackoverflow.com/questions/7528091
## C-right: move forward one word
bindkey '^[[1;5C' forward-word
## C-left: move backward one word
bindkey '^[[1;5D' backward-word
## S-tab: move through the completion menu backwards
[[ -n ${terminfo[kcbt]} ]] && bindkey ${terminfo[kcbt]} reverse-menu-complete
## del: delete forward
[[ -n ${terminfo[kdch1]} ]] && bindkey ${terminfo[kdch1]} delete-char
## ins: insert/overtype mode switcher, but I personally recommend to disable this
#bindkey ${terminfo[kich1]} overwrite-mode
## C-x,C-h: This is missing from the emacs keymap, but not from the vi one
bindkey '^x^h' _complete_help





# Git and svn aliases defined at the end because need completiion set before
## Git aliases
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

## SVN aliases
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
