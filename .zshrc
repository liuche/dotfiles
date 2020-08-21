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
#
# android
export ANDK=/Users/liuche/.mozbuild/android-ndk-r10e
export ASDK=/Users/liuche/.mozbuild/android-sdk-macosx

export ANDROID_HOME=$ASDK

# ########
# Exports
# ########
export PATH=~/bin:/Users/liuche/moz/code/moz-git-tools:/usr/local/share/npm/bin:$ASDK/platform-tools:$HOME/.fastlane/bin:$HOME/.rvm/bin:$ASDK/build-tools/28.0.3:$PATH
export HG=hg

export MANPAGER="vim -c '%!col -b' -c 'set ft=man nomod nolist' -c 'set nomodifiable' -"
export MANWIDTH=90

# other env vars
export BL=/Users/liuche/Documents/blogs
export REPOS=/Users/liuche/code/moz
export CODE=/Users/liuche/code
export MC=$REPOS/mozilla-central
export MCP=$MC/.hg/patches
export FA=$REPOS/focus-android
export FT=$REPOS/firefox-tv
export FI=$REPOS/focus-ios
export FE=$REPOS/fenix
export AC=$REPOS/android-components
export RU=$CODE/rust-projects
export ML=$CODE/ml-learning

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

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/liuche/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/liuche/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/liuche/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/liuche/Applications/google-cloud-sdk/completion.zsh.inc'; fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
conda_activate () {
  __conda_setup="$('/Users/liuche/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/Users/liuche/opt/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/Users/liuche/opt/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/Users/liuche/opt/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
}
# <<< conda initialize <<<

