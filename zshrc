# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


# --------------------
# Module configuration
# --------------------

#
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=14'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=14'

# ------------------
# Initialize modules
# ------------------

if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install


DIRSTACKSIZE=10

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

function cd () {
  if   [[ "x$*" == "x..." ]]; then
    cd ../..
  elif [[ "x$*" == "x...." ]]; then
    cd ../../..
  elif [[ "x$*" == "x....." ]]; then
    cd ../../../..
  elif [[ "x$*" == "x......" ]]; then
    cd ../../../../..
  else
    builtin cd "$@"
  fi
}

# Basic directory operations
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'

alias gcm='git cm'
alias gls='git ls-files'
alias glm='git log --topo-order --stat --pretty=format:"${_git_log_medium_format}"'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gy='git pull'
# alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all'
# alias glo='git log --oneline'
alias gstat='git log --stat'
alias glsm='git lsm'
alias gss='git status -s'
alias ga='git add'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard && git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias glp='git log -p -C -C -M'
alias gw='git show -p -C -C -M'
alias shortlog='git shortlog -sn'

#
# Color grep results
# Examples: http://www.jefftk.com/p/colored-grep
#
# sl : whole selected lines
# cx : whole context lines
# mt : matching text
# ms : matching text in a selected line
# mc : matching text in a context line
# fn : filenames
# ln : line numbers
# bn : byte offsets
# se : separators
#
export GREP_COLORS='sl=1;30:cx:0;mt=1;31:fn=0;32:ln=0;32:bn=0;31:se=0;36'

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# Show history
alias history='fc -l 1'

# Super user
alias _='sudo'

# Enable ls colors
alias ls='ls --color=tty'

# List direcory contents
alias lsa='ls -lah'
alias ll='ls -l'
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias sl=ls

alias dud='du --max-depth=1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias grep='grep --color=auto'

alias dc='cd'
alias ez="exec zsh"
alias gdb='gdb -q'

mcd () {
  mkdir $1 && cd $1
}
compdef mcd=cd

# Include distro-specific configuration
[[ -f /etc/exherbo-release ]] && source ~/.zsh/exherbo.zsh

if type nvim >/dev/null; then
  export EDITOR=nvim
  alias vi=nvim
  alias vim=nvim
fi

# /run/user/1000/tmux-1000 instead of /tmp/tmux-1000
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

# ModusToolbox 2.1
export CY_TOOLS_PATHS=/opt/ModusToolbox/tools_2.1
alias kp3-bulk="$CY_TOOLS_PATHS/fw-loader/bin/fw-loader --mode kp3-bulk"
alias kp3-daplink="$CY_TOOLS_PATHS/fw-loader/bin/fw-loader --mode kp3-daplink"

alias sshfs-lib="mount | grep -q /media/Library || sshfs rock64@192.168.88.5:/media/Library /media/Library -C -p 2222"
alias beet-import="beet import /media/Library/RED -i -l ~/.config/beets/import.err"

# auto-generated by kdesrc-build initial setup: do not remove!
# Add the kdesrc-build directory to the path
export PATH="$HOME/kde/src/kdesrc-build:$PATH"
# Create alias for running software built with kdesrc-build
kdesrc-run ()
{
  source "$HOME/kde/build/$1/prefix.sh" && "$HOME/kde/usr/bin/$@"
}
