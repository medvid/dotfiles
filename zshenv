# Start configuration added by Zim install {{{
#
# User configuration sourced by all invocations of the shell
#

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
# }}} End configuration added by Zim install

source /etc/profile
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

[[ -d "$HOME/.gem/ruby/2.5.0/bin" ]] && export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"

ANDROID_HOME=/mnt/data/Android/Sdk
if [[ -d "$ANDROID_HOME" ]]; then
    export ANDROID_HOME
    export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH
fi
