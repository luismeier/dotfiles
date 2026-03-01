# ==============================================================================
# ENVIRONMENT VARIABLES
# ==============================================================================
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim -c 'Man!'"
export TERM="kitty"
export BROWSER="firefox"

# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview" # separate opts for history widget
