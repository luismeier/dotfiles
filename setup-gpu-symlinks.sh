#!/usr/bin/env bash
set -euo pipefail

RULE_PATH="/etc/udev/rules.d/90-gpu-dev-path.rules"

detect_pci() {
  local vendor_hex="$1" # e.g. 0x8086 or 0x10de
  # Find a drm card whose parent device has the vendor we want
  for c in /sys/class/drm/card*; do
    [[ -e "$c/device/vendor" ]] || continue
    if [[ "$(cat "$c/device/vendor")" == "$vendor_hex" ]]; then
      # Resolve to PCI address like 0000:01:00.0
      readlink -f "$c/device" | awk -F/ '{print $NF}'
      return 0
    fi
  done
  return 1
}

INTEL_PCI=$(detect_pci 0x8086 || true)
NVIDIA_PCI=$(detect_pci 0x10de || true)

echo "Detected:"
echo "  Intel  PCI: ${INTEL_PCI:-<none>}"
echo "  NVIDIA PCI: ${NVIDIA_PCI:-<none>}"

UDEV_RULES='# Stable symlinks for Intel/NVIDIA DRM nodes (card + render)
# Generated automatically'

if [[ -n "${INTEL_PCI:-}" ]]; then
  UDEV_RULES+=$'\n'"# Intel iGPU"
  UDEV_RULES+=$'\n'"KERNEL==\"card*\",    SUBSYSTEM==\"drm\", SUBSYSTEMS==\"pci\", KERNELS==\"0000:${INTEL_PCI}\",  SYMLINK+=\"dri/intel-igpu\""
  UDEV_RULES+=$'\n'"KERNEL==\"renderD*\", SUBSYSTEM==\"drm\", SUBSYSTEMS==\"pci\", KERNELS==\"0000:${INTEL_PCI}\",  SYMLINK+=\"dri/intel-igpu-render\""
fi

if [[ -n "${NVIDIA_PCI:-}" ]]; then
  UDEV_RULES+=$'\n'"# NVIDIA dGPU"
  UDEV_RULES+=$'\n'"KERNEL==\"card*\",    SUBSYSTEM==\"drm\", SUBSYSTEMS==\"pci\", KERNELS==\"0000:${NVIDIA_PCI}\", SYMLINK+=\"dri/nvidia-dgpu\""
  UDEV_RULES+=$'\n'"KERNEL==\"renderD*\", SUBSYSTEM==\"drm\", SUBSYSTEMS==\"pci\", KERNELS==\"0000:${NVIDIA_PCI}\", SYMLINK+=\"dri/nvidia-dgpu-render\""
fi

echo "Writing rules to $RULE_PATH (sudo required)…"
echo "$UDEV_RULES" | sudo tee "$RULE_PATH" >/dev/null

echo "Reloading udev and triggering…"
sudo udevadm control --reload
sudo udevadm trigger -s drm

echo "Symlinks now (if devices are present):"
ls -l /dev/dri/ | sed 's/^/  /'
