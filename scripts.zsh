function go_ros() {
  if [ -f "/etc/fedora-release" ]; then
    echo "You on Fedora mate. Doing nothing!"
  else
    export ROS_PYTHON_VERSION=3
    source /opt/ros/noetic/setup.zsh
  fi
}


function go_ros2() 
{
  export ROS_VERSION=2
  export ROS_DOMAIN_ID=42
  export ROS_PYTHON_VERSION=3
  if [ -f "./install/setup.zsh" ]; then
    echo "There is a local install sourcing it"
    source ./install/setup.zsh
  fi
  if [ -f "/etc/fedora-release" ]; then
     source /usr/lib64/ros2-humble/setup.zsh
  else
     source /opt/ros/humble/setup.zsh
  fi

  python3 -c "
import platform, os
print()
print('System:', platform.system(), platform.release())
print('Python:', platform.python_implementation(), platform.python_version())
print('   RMW:', os.environ.get('RMW_IMPLEMENTATION','?'))
print('   ROS:', os.environ.get('ROS_DISTRO','distro?'))
print('🤖 Welcome to ROS on', platform.node())
print()
"
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
