#!/bin/bash

echo "=== Sierra Install Now ==="
date

BASE="/Volumes/OS X Base System 1"
ESD="/Volumes/OS X Install ESD"
TARGET="/Volumes/Macintosh HD"

echo
echo "Checking..."

if [ ! -d "$BASE" ]; then
    echo "ERROR: Missing $BASE"
    exit 1
fi

if [ ! -d "$ESD" ]; then
    echo "ERROR: Missing $ESD"
    exit 1
fi

if [ ! -d "$TARGET" ]; then
    echo "ERROR: Missing $TARGET"
    exit 1
fi

echo "OK: Base System"
echo "OK: Install ESD"
echo "OK: Target"

echo
echo "Looking for installer..."

INSTALLER=$(find "$BASE" -type f -name "Installer" 2>/dev/null | head -1)

if [ -z "$INSTALLER" ]; then
    echo "Installer not found."
    echo "Searching CDIS:"
    find "$BASE/System/Installation" -maxdepth 3 -print 2>/dev/null
    exit 1
fi

echo
echo "Launching:"
echo "$INSTALLER"

"$INSTALLER"

echo
echo "Exit code:"
echo $?