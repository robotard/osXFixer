#!/bin/bash

echo "======================================"
echo "      SIERRA INSTALL NOW"
echo "======================================"

BASE="/Volumes/OS X Base System 1"
ESD="/Volumes/OS X Install ESD"
TARGET="/Volumes/Macintosh HD"

echo
echo "Checking volumes..."

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
echo "OK: Macintosh HD"

echo
echo "Checking payload..."

if [ -f "$ESD/Packages/Essentials.pkg" ]; then
    echo "OK: Essentials.pkg"
else
    echo "ERROR: Essentials.pkg missing"
    exit 1
fi

echo
echo "Finding Installer..."

INSTALLER=$(find "$BASE/System/Installation" -type f -name "Installer" 2>/dev/null | head -1)

if [ -z "$INSTALLER" ]; then
    echo "Installer binary not found."
    echo
    echo "Contents of System/Installation:"
    ls -la "$BASE/System/Installation"
    exit 1
fi

echo
echo "Found:"
echo "$INSTALLER"

echo
echo "Launching Sierra installer..."

"$INSTALLER"

EXIT=$?

echo
echo "Installer exited:"
echo "$EXIT"