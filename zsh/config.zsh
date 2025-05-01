
# History related settings
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase # remove duplicates from history
# setopt appendhistory
setopt SHARE_HISTORY # Shares between shells
# setopt INC_APPEND_HISTORY # Push command to hist before exec
setopt hist_ignore_space

# Duplicate history settings
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
