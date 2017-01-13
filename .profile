#see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# If this is an xterm set the title to user@host:dir
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ "

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# color
export CLICOLOR=1
export LSCOLORS="gxfxcxdxbxegedabagacad"

# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:/local/sbin:$PATH

# personal vars
export ME=/Users/liuche/meng
export LATEX=/usr/local/texlive/texmf-local/tex/latex
export MOZ_QUIET=1

# moz vars 
export MZ=/Users/liuche/moz/code/hg/services-central
export SY=$MZ/services/sync
export OBJDIR=$MZ/obj-ff-dbg
export NI=$OBJDIR/dist/NightlyDebug.app/Contents/MacOS
export TS=$SY/tests/unit
export LA=/Users/liuche/moz/code/LoginApp/login-app
export AU=/Applications/Aurora.app/Contents/MacOS
export PR="/Users/liuche/Library/Application Support/Firefox/Profiles"

alias testone='make SOLO_FILE=$SOLO_FILE -C $OBJDIR/services/sync/tests check-one'
alias testall='make -C $OBJDIR/services/sync/tests xpcshell-tests'
alias irc="ssh-add ~/.ssh/moz_rsa; ssh -t pp screen -raAd irc"
alias issh="ssh-add ~/.ssh/moz_rsa; ssh -L 6667:localhost:3687 pp"
