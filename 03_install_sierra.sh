#!/bin/bash

echo "=== SIERRA INSTALL ==="

TARGET="/Volumes/Macintosh HD"
ESD="/Volumes/OS X Install ESD"

if [ ! -d "$ESD" ]; then
    echo "FAIL: OS X Install ESD missing"
    exit 1
fi

if [ ! -d "$TARGET" ]; then
    echo "FAIL: Macintosh HD not mounted"
    exit 1
fi

echo
echo "Installer:"
echo "$ESD"

echo
echo "Target:"
diskutil info "$TARGET" | grep -E "Device Identifier|File System|Disk Size"

echo
echo "================================="
echo "WARNING"
echo "This will ERASE Macintosh HD"
echo "================================="

printf "Type INSTALL-SIERRA to continue: "
read CONFIRM

if [ "$CONFIRM" != "INSTALL-SIERRA" ]; then
    echo "Cancelled."
    exit 0
fi

echo
echo "Unmounting target..."

diskutil unmount "$TARGET"

echo
echo "Starting Sierra installer..."

installer \
-pkg "$ESD/Packages/OSInstall.mpkg" \
-target "/Volumes/Macintosh HD"

echo
echo "Installer finished with code: $?"

echo
echo "Blessing boot volume..."

bless \
--folder "/Volumes/Macintosh HD/System/Library/CoreServices" \
--bootefi

echo
echo "Done."