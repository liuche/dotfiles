autoload -U compinit promptinit
compinit
promptinit

# ##########
# Bindings
# ##########

# vi mode
bindkey -v

# Display commands from history
# [[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
# [[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
# 
# [[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
# [[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# ########
# Colors
# ########
alias tmux='tmux -2'
autoload -U colors && colors
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg_no_bold[cyan]%}%~ %{$reset_color%}% # "

if [ $OSTYPE = "linux-gnu" ]; then
  alias ls="ls -pbF --color=auto"
else
  alias ls="ls -G"
fi

set background=dark

# ########
# Editors
# ########
export EDITOR=vim
export VISUAL=vim
export PAGER=less

# ########
# Exports
# ########
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/Users/liuche/Libs/addon-sdk-1.4.3/bin:/Users/liuche/moz/code/moz-git-tools:/usr/local/share/npm/bin:$ASDK/platform-tools:$PATH
export PYTHONPATH=/Library/Python/2.7/site-packages:/Library/Python/2.7:$PYTHONPATH
export HG=hg

export MANPAGER="vim -c '%!col -b' -c 'set ft=man nomod nolist' -c 'set nomodifiable' -"
export MANWIDTH=90

# other env vars
export BL=/Users/liuche/Documents/blogs
export REPOS=/Users/liuche/moz/code/repos
export PS=/Users/liuche/moz/code/nmx/prox-server
export PR=/Users/liuche/moz/code/nmx/prox
export MC=$REPOS/m-c
export MCP=$MC/.hg/patches
export MA=$REPOS/m-a
export MB=$REPOS/m-b
export MBP=$MB/.hg/patches
export GMC=$REPOS/git-m-c
export MA=$REPOS/m-a
export MAP=$MA/.hg/patches
export AS=/Users/liuche/moz/code/android/workspace/android-sync
export ACODE=$REPOS/../android/android-src/frameworks/base/core/java/android
export LOCALES=$MC/mobile/android/locales/maemo-locales
export L10NBASEDIR=$REPOS/l10n

export MOZ_HOST_BIN=$FX/objdir-desktop/dist/bin
st() { TEST_PATH="$@" make -sj8 -C ./objdir-droid mochitest-robocop; }
stb() { mach build build/mobile/robocop&& mach package&& mach install&& st "$@" }

# android
export ANDK=/Users/liuche/.mozbuild/android-ndk-r10e
export ASDK=/Users/liuche/.mozbuild/android-sdk-macosx

export ANDROID_HOME=$ASDK

# Aliases
if [ -f $HOME/.zsh_aliases ]; then
  . $HOME/.zsh_aliases
fi
# ##############
# Extra tweaks
# ##############
__git_files () {
  _wanted files expl 'local files' _files
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
