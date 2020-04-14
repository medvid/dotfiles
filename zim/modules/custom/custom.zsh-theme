# https://github.com/ureesoriano/zsh-ubuntu-with-vitamins-zim-theme

# Colors:
# https://jonasjacek.github.io/colors/
setopt nopromptbang prompt{cr,percent,sp,subst}

PS1='%F{12}%n@%m%f:%F{10}%~%b%f %(?::%F{red}[%?] )%F{10}$%b%f '
unset RPS1
