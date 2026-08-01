#!/bin/bash

echo "======================================"
echo "      macOS Sierra Install Launcher   "
echo "======================================"

ESD="/Volumes/OS X Install ESD"
TARGET="/Volumes/Macintosh HD"
BASE="/Volumes/OS X Base System 1"

echo
echo "Checking..."

if [ ! -d "$ESD" ]; then
    echo "ERROR: OS X Install ESD missing"
    exit 1
fi

if [ ! -d "$TARGET" ]; then
    echo "ERROR: Macintosh HD missing"
    exit 1
fi

echo "OK: Installer media"
echo "OK: Target disk"

echo
echo "Target:"
diskutil info "$TARGET" | grep -E "Device Identifier|File System|OS Can Be Installed"

echo
echo "Finding installer..."

INSTALLER=$(find "$BASE" \
-name "Install*.app" \
-o -name "*Installer*.app" \
2>/dev/null | head -1)

if [ -n "$INSTALLER" ]; then
    echo "Found:"
    echo "$INSTALLER"

    echo
    echo "Launching installer..."
    
    open "$INSTALLER"

    exit $?
fi


echo "No installer app found."

echo
echo "Trying OSInstall engine..."

if [ -x "$BASE/System/Installation/CDIS/Mac OS X Installer.app/Contents/MacOS/Installer" ]; then

    "$BASE/System/Installation/CDIS/Mac OS X Installer.app/Contents/MacOS/Installer"

    exit $?

fi


echo
echo "Installer engine not found in expected location."
echo
echo "Available installation files:"

find "$BASE/System/Installation" \
-maxdepth 3 \
-type f \
2>/dev/null

echo
echo "STOP."