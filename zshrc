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


# The following lines were added by compinstall
zstyle :compinstall filename '/home/luism/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Hist settings
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# Set editors
export EDITOR='nvim'
export VISUAL='code'

# Load antigen
source ~/dotfiles/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load plugins
antigen bundle git
antigen bundle pip
antigen bundle navi
antigen bundle diff-so-fancy
antigen bundle fzf
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
# antigen theme robbyrussell
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen bundle Aloxaf/fzf-tab
antigen apply

#
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"

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



### ALIASES ###
## Alias to run dockers with gpu on archlinux
alias docker-gpu='docker run --gpus all --device /dev/nvidia0 --device /dev/nvidia-uvm --device /dev/nvidia-uvm-tools --device /dev/nvidiactl'

# Fedora Prime 
alias prime-run="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"

## Replace ls with exa
if [ -x "$(command -v exa)" ]; then
  alias ls='exa --icons'
  alias ll='exa -l --icons'
  alias la='exa -la --icons'
  alias lf='exa -a --icons'
fi

# Colorize grep output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Adding flags to commands
alias df="df -h"      # Human readable
alias free="Free -m"  # Free in MB

# sudo !! alias
alias pls='sudo "$BASH" -c "$(history -p !!)"'

# Confirm before overwriting things
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Thefuck currently commented out
# eval $(thefuck --alias)

# We add cuda to path
# This should be symlinked to the right path
export PATH="$PATH:/opt/cuda/bin/"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib:/opt/cuda/lib64"

go_ros() {
    export ROS_PYTHON_VERSION=3
    source /opt/ros/noetic/setup.zsh
}

go_ros2(){
     export ROS_DOMAIN_ID=42
     export ROS_VERSION=2
     export ROS_PYTHON_VERSION=3
     export ROS_DISTRO=galactic
     source /opt/ros2/galactic/setup.zsh
}

# Some ls aliases
activate_ls(){
  unalias ls
  unalias ll
  unalias la
  unalias lf

  alias ll='ls -alF --color=auto'
  alias la='ls -A --color=auto'
  alias l='ls -CF --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
}

