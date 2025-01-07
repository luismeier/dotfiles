# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#      _     _
#  _  | \   / |  Luis Meier
# | | |  \_/  |  https://github.com/luismeier
# | | | |\_/| |  https://luismeier.ch
# | |_|_|_  |_|
# |_______|
# My zsh config
#


# Download antidote plugin mgr if it not exists
if [ ! -d "${ZDOTDIR:-$HOME}/.antidote" ];then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
fi

source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# Load completions
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
# prompt pure

# History
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase # remove duplicates from history
# setopt appendhistory
setopt SHARE_HISTORY
# setopt INC_APPEND_HISTORY # Push command to hist before exec
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Keybindiings
# bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# Ctrl-Space to accept
bindkey '^ ' autosuggest-accept
# Set editors
export EDITOR='nvim'
export VISUAL='nvim'
# export VISUAL='code'

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi


### Distro specific stuff ###

# Arch specific stuff
if [ -f "/etc/arch-release" ]; then
  ## Alias to run dockers with gpu on archlinux
  alias docker-gpu='docker run --gpus all --device /dev/nvidia0 --device /dev/nvidia-uvm --device /dev/nvidia-uvm-tools --device /dev/nvidiactl'

  # We add cuda to path
  # This should be symlinked to the right path
  export PATH="$PATH:/opt/cuda/bin/"
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib:/opt/cuda/lib64"

fi

# Fedora specific stuff
if [ -f "/etc/fedora-release" ]; then
  # Setting an alias to prime-run
  alias prime-run="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
fi


### ALIASES ###
alias v="nvim"

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

### Replace cat with bat
#if [ -x "$(command -v bat)" ]; then
# alias cat='bat'
#fi

# Some movement alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Git aliases
alias gs="git status"
alias gc="git commit"
alias lg="lazygit"

# Colorize grep output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Adding flags to commands
alias df="df -h"      # Human readable
alias free="free -m"  # Free in MB

# sudo !! alias
alias pls='sudo "$BASH" -c "$(history -p !!)"'

# Confirm before overwriting things
alias cp="cp -i"
alias mv="mv -i"
# alias rm="rm -i"
#


# add cargo stuff to path
export PATH="$PATH:/home/luism/.cargo/bin"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

# add my scripts
source /home/luism/dotfiles/scripts.zsh

if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook zsh)"
else
  echo "direnv not available"
fi
# Shell integrations
if [ -x "$(command -v fzf)" ]; then
  eval "$(fzf --zsh)"
else
  echo "fzf not available"
fi
if [ -x "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh)"
  alias cd="z" # this must be after the eval function
else
  echo "Zoxide not available"
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# bun completions
[ -s "/home/luism/.bun/_bun" ] && source "/home/luism/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
