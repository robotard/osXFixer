#!/bin/bash

echo "======================================"
echo "       SIERRA INSTALL NOW"
echo "======================================"

BASE="/Volumes/OS X Base System 1"
ESD="/Volumes/OS X Install ESD"
TARGET="/Volumes/Macintosh HD"

echo
echo "Checking volumes..."

[ -d "$BASE" ] && echo "OK Base System" || { echo "Missing Base System"; exit 1; }
[ -d "$ESD" ] && echo "OK Install ESD" || { echo "Missing Install ESD"; exit 1; }
[ -d "$TARGET" ] && echo "OK Macintosh HD" || { echo "Missing Macintosh HD"; exit 1; }

echo
echo "Checking payload..."

[ -f "$ESD/Packages/Essentials.pkg" ] && echo "OK Essentials.pkg" || exit 1
[ -f "$ESD/Packages/OSInstall.mpkg" ] && echo "OK OSInstall.mpkg" || exit 1

echo
echo "Finding installer..."

INSTALLER=$(find "$BASE" -type f -name "Installer" 2>/dev/null | head -1)

if [ -z "$INSTALLER" ]; then
    echo "No Installer binary found."
    echo
    echo "Trying CDIS:"
    ls -la "$BASE/System/Installation/CDIS" 2>/dev/null
    exit 1
fi

echo
echo "Found:"
echo "$INSTALLER"

echo
echo "Launching..."

"$INSTALLER"

echo
echo "Finished with code $?"