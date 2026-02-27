# ==============================================================================
# UTILITY FUNCTIONS
# ==============================================================================

# Force applications to run under X11 (useful on Wayland)
function xrun() {
  if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    "$@"
  else
    GDK_BACKEND=x11 \
      QT_QPA_PLATFORM=xcb \
      SDL_VIDEODRIVER=x11 \
      _JAVA_AWT_WM_NONREPARENTING=1 \
      WINIT_UNIX_BACKEND=x11 \
      "$@"
  fi
}

# Make directory and cd into it
function mkcd() {
  if [ -z "$1" ]; then
    echo "Usage: mkcd <directory>"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}

# Universal archive extractor
function extract() {
  if [ -z "$1" ]; then
    cat << 'EOF'
Usage: extract <archive_file> [archive_file_2] [...]

Supported formats:
  tar, tar.bz2, tar.gz, tar.xz, tbz2, tgz, txz
  zip, rar, 7z, gz, bz2, xz, lzma, Z
  deb, rpm, iso, cab, dmg, and more
EOF
    return 1
  fi

  for archive in "$@"; do
    if [ ! -f "$archive" ]; then
      echo "extract: '$archive' - file does not exist"
      return 1
    fi

    case "${archive,,}" in  # Convert to lowercase for matching
      *.tar.bz2|*.tbz2|*.tar.gz|*.tgz|*.tar.xz|*.txz|*.tar)
        tar xvf "$archive" ;;
      *.bz2)
        bunzip2 "$archive" ;;
      *.gz)
        gunzip "$archive" ;;
      *.zip|*.epub|*.cbz)
        unzip "$archive" ;;
      *.rar|*.cbr)
        unrar x -ad "$archive" ;;
      *.7z|*.cb7)
        7z x "$archive" ;;
      *.xz)
        unxz "$archive" ;;
      *.lzma)
        unlzma "$archive" ;;
      *.z)
        uncompress "$archive" ;;
      *.deb|*.rpm|*.iso|*.dmg|*.cab|*.msi|*.pkg|*.arj|*.chm|*.lzh|*.udf|*.wim|*.xar)
        7z x "$archive" ;;
      *.exe)
        cabextract "$archive" ;;
      *.cpio)
        cpio -id < "$archive" ;;
      *.ace|*.cba)
        unace x "$archive" ;;
      *.cbt)
        tar xvf "$archive" ;;
      *)
        echo "extract: '$archive' - unknown archive format"
        return 1 ;;
    esac
  done
}
