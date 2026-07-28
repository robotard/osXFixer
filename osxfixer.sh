#!/bin/bash
#
# ============================================================================
# osXFixer Bootstrap
# Designed for:
#   iMac12,2 (A1312 Mid-2011)
#
# Run from:
#   OS X Internet Recovery Terminal
#
# Example:
#   curl -fsSL https://raw.githubusercontent.com/robotard/osXFixer/main/osxfixer.sh | bash
#
# WARNING
# --------
# This script can ERASE an entire disk.
# Read every prompt carefully.
#
# ============================================================================

set -e

VERSION="0.1"

clear

echo "========================================================"
echo "                osXFixer ${VERSION}"
echo "========================================================"
echo

############################################
# Helpers
############################################

abort() {
    echo
    echo "ERROR: $1"
    exit 1
}

banner() {
    echo
    echo "--------------------------------------------------------"
    echo "$1"
    echo "--------------------------------------------------------"
}

############################################
# Check environment
############################################

banner "Checking environment"

sw_vers || true

echo

MODEL=$(sysctl -n hw.model 2>/dev/null || echo Unknown)

echo "Detected Model : $MODEL"

if command -v system_profiler >/dev/null; then
    SERIAL=$(system_profiler SPHardwareDataType | awk -F": " '/Serial/ {print $2}')
    echo "Serial         : ${SERIAL}"
fi

############################################
# Network
############################################

banner "Checking Internet"

if ping -c 1 github.com >/dev/null 2>&1; then
    echo "Internet OK"
else
    abort "No internet connection."
fi

############################################
# Disk listing
############################################

banner "Available disks"

diskutil list

echo

read -p "Target disk (example: disk0): " TARGET

[ -z "$TARGET" ] && abort "No disk selected."

echo
echo "YOU ARE ABOUT TO ERASE:"
echo
echo "    /dev/${TARGET}"
echo

read -p "Type ERASE to continue: " CONFIRM

[ "$CONFIRM" != "ERASE" ] && abort "Cancelled."

############################################
# Erase disk
############################################

banner "Erasing disk"

diskutil eraseDisk \
    JHFS+ \
    "Macintosh HD" \
    GPT \
    /dev/${TARGET}

echo
echo "Disk prepared."

############################################
# Hardware summary
############################################

banner "Hardware"

diskutil info /dev/${TARGET} || true

echo
echo "Machine: ${MODEL}"

############################################
# Decide install path
############################################

banner "Recommended installation path"

case "$MODEL" in

iMac12,1|iMac12,2)

echo
echo "Recommended path:"
echo
echo "  Recovery"
echo "      ↓"
echo "  Clean Install"
echo "      ↓"
echo "  OS X El Capitan"
echo "      ↓"
echo "  Verify Hardware"
echo "      ↓"
echo "  OpenCore Legacy Patcher"
echo "      ↓"
echo "  Monterey (recommended)"
echo
;;

*)

echo
echo "Unknown Mac."
echo "Proceed manually."
;;

esac

############################################
# Optional downloads
############################################

banner "Repository"

REPO="https://raw.githubusercontent.com/robotard/osXFixer/main"

mkdir -p /tmp/osxfixer

echo "Fetching support files..."

curl -fsSL \
"${REPO}/README.md" \
-o /tmp/osxfixer/README.md \
|| true

############################################
# Placeholder
############################################

banner "Installer"

cat <<EOF

==========================================================

Disk preparation complete.

Next stage depends upon what Apple Recovery
offers for your Mac.

Typical route:

Internet Recovery
        ↓
Install OS X
        ↓
Boot successfully
        ↓
Install OpenCore Legacy Patcher
        ↓
Upgrade to Monterey

==========================================================

EOF

echo
echo "Finished."