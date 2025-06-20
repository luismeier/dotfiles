# Neovim alias
alias v="nvim"
alias vk="NVIM_APPNAME=kickstart.nvim nvim"
vv() {
  select config in lazyvim kickstart nvchad astrovim lunarvim
  do NVIM_APPNAME=nvim-$config nvim $@; break; done
}

## Replace ls with exa if available
if [ -x "$(command -v eza)" ]; then
  alias ls='eza --icons'
  alias ll='eza -ghl --icons'
  alias la='eza -la --icons'
  alias lf='eza -a --icons'
else
  echo "Exa not available"
  alias ll='ls -alF --color=auto'
  alias la='ls -A --color=auto'
  alias l='ls -CF --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
fi


# Fedora specific stuff
if [ -f "/etc/fedora-release" ]; then
  # Setting an alias to prime-run
  alias prime-run="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
fi

# Some movement alias
alias ..='cd ..'
# alias ...='cd ../..'
# alias ....='cd ../../..'
# alias .....='cd ../../../..'
# alias ......='cd ../../../../..'

# Git aliases
alias gs="git status"
alias gc="git commit"
alias lg="lazygit"

# Colorize grep output
alias grep='grep --color=auto'

# Adding flags to commands
alias df="df -h"      # Human readable
alias free="free -m"  # Free in MB

# Confirm before overwriting things
alias cp="cp -i"
alias mv="mv -i"
# alias rm="rm -i"
#

