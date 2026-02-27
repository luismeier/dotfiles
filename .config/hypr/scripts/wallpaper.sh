#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="${HOME}/Pictures/wallpapers"
STATE_LINK="${HOME}/.config/current_wallpaper"
FIT_MODE="${FIT_MODE:-cover}" # contain|cover|tile|fill

# Wait for hyprpaper to be ready (systemd managed or exec-once)
echo "Waiting for hyprpaper to be ready..."
timeout_s=30
for ((i = 0; i < timeout_s; i++)); do
  if pgrep -x hyprpaper >/dev/null; then
    break
  fi
  sleep 1
done

if ! pgrep -x hyprpaper >/dev/null; then
  echo "ERROR: hyprpaper is not running after ${timeout_s}s."
  exit 1
fi

if [[ ! -d "${WALLPAPER_DIR}" ]]; then
  echo "ERROR: wallpaper dir not found: ${WALLPAPER_DIR}"
  exit 1
fi

# Determine "current" wallpaper (prefer your own state link; it's unambiguous)
CURRENT_WALL=""
if [[ -L "${STATE_LINK}" ]]; then
  # readlink -f resolves to an absolute path if possible
  CURRENT_WALL="$(readlink -f "${STATE_LINK}" || true)"
fi

# Fallback: try to guess from hyprpaper's loaded list
if [[ -z "${CURRENT_WALL}" ]]; then
  # listloaded output format can vary; extract the first absolute-ish path we see
  CURRENT_WALL="$(hyprctl hyprpaper listloaded 2>/dev/null | tr -d '\r' | grep -Eo '(/[^ ]+\.(png|jpg|jpeg))' | head -n 1 || true)"
fi

echo -e "Current wallpaper:\n  ${CURRENT_WALL:-<unknown>}"

# Pick a random wallpaper different from CURRENT_WALL (if we know it)
if [[ -n "${CURRENT_WALL}" ]]; then
  WALLPAPER="$(
    find "${WALLPAPER_DIR}" -type f \
      \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
      ! -samefile "${CURRENT_WALL}" -print0 |
      shuf -z -n 1 | tr -d '\0'
  )"
else
  WALLPAPER="$(
    find "${WALLPAPER_DIR}" -type f \
      \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) -print0 |
      shuf -z -n 1 | tr -d '\0'
  )"
fi

if [[ -z "${WALLPAPER}" ]]; then
  echo "ERROR: No wallpapers found in ${WALLPAPER_DIR}"
  exit 1
fi

echo -e "New wallpaper:\n  ${WALLPAPER}"

# New hyprpaper IPC syntax: '[mon], [path], [fit_mode]' (mon can be empty for fallback)
# Example: ",/path/to/img.png,cover"
hyprctl hyprpaper wallpaper ",${WALLPAPER},${FIT_MODE}" >/dev/null

# Persist what we set (for next run + other scripts)
ln -sf "${WALLPAPER}" "${STATE_LINK}"
