# ==============================================================================
# UTILITY FUNCTIONS
# ==============================================================================

# Force applications to run under X11 (useful on Wayland)
function xrun() {
  GDK_BACKEND=x11 \
    QT_QPA_PLATFORM=xcb \
    SDL_VIDEODRIVER=x11 \
    _JAVA_AWT_WM_NONREPARENTING=1 \
    WINIT_UNIX_BACKEND=x11 \
    "$@"
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
  zip, rar, 7z, gz, bz2, xz, lzma
EOF
    return 1
  fi

  for archive in "$@"; do
    if [ ! -f "$archive" ]; then
      echo "extract: '$archive' - file does not exist"
      continue
    fi

    local lower="${archive:l}"  # zsh lowercase syntax
    case "$lower" in
      *.tar.bz2|*.tbz2|*.tar.gz|*.tgz|*.tar.xz|*.txz|*.tar)
        tar xvf "$archive" ;;
      *.bz2)
        bunzip2 "$archive" ;;
      *.gz)
        gunzip "$archive" ;;
      *.zip|*.epub|*.cbz)
        unzip "$archive" ;;
      *.rar|*.cbr)
        if ! command -v unrar &>/dev/null; then
          echo "extract: unrar not installed"
          continue
        fi
        unrar x -ad "$archive" ;;
      *.7z|*.cb7)
        if ! command -v 7z &>/dev/null; then
          echo "extract: 7z not installed"
          continue
        fi
        7z x "$archive" ;;
      *.xz)
        unxz "$archive" ;;
      *.lzma)
        unlzma "$archive" ;;
      *.cpio)
        cpio -id < "$archive" ;;
      *)
        echo "extract: '$archive' - unknown archive format"
        continue ;;
    esac
  done
}
