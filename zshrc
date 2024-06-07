#      _     _
#  _  | \   / |  Luis Meier
# | | |  \_/  |  https://github.com/luismeier
# | | | |\_/| |  https://luismeier.ch
# | |_|_|_  |_|
# |_______|
# My zsh config


# The following lines were added by compinstall
zstyle :compinstall filename '/home/luism/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Hist settings
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
source <(fzf --zsh)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Set editors
export EDITOR='nvim'
export VISUAL='code'

# Load antigen
source ~/dotfiles/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load plugins
antigen bundle navi
# antigen bundle diff-so-fancy
if [ -x "$(command -v fzf)" ]; then
    antigen bundle fzf
fi
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle wting/autojump
# antigen bundle marlonrichert/zsh-autocomplete@main
antigen bundle command-not-found
# Load the theme.
#antigen theme robbyrussell
# Tell Antigen that you're done.
antigen apply

## Docker stuff
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

#
# git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
# git config --global interactive.diffFilter "diff-so-fancy --patch"

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

### FUNCTIONS ###
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

function xrun ()
{
  if [[ "$XDG_SESSION_TYPE" == "wayland" ]] ; then
    GDK_BACKEND=x10 \
      QT_QPA_PLATFORM=xcb \
      SDL_VIDEODRIVER=x11 \
      _JAVA_AWT_WM_NONREPARENTING=1 \
      WINIT_UNIX_BACKEND=x11 \
      SDL_VIDEODRIVER=wayland \
      $@
  else
    $@
  fi
}

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


go_ros() {
  if [ -f "/etc/fedora-release" ]; then
    echo "You on Fedora mate. Doing nothing!"
  else
    export ROS_PYTHON_VERSION=3
    source /opt/ros/noetic/setup.zsh
  fi
}

go_ros2(){
  export ROS_VERSION=2
  export ROS_DOMAIN_ID=42
  export ROS_PYTHON_VERSION=3
  if [ -f "/etc/fedora-release" ]; then
     source /usr/lib64/ros2-humble/setup.zsh
  else
     source /opt/ros/humble/setup.zsh
  fi
}

# add cargo stuff to path
export PATH="$PATH:/home/luism/.cargo/bin"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(starship init zsh)"
