#!/bin/bash
#
# Sierra Extract + Launch Attempt
# Recovery-safe - no erase
#

set -e

SRC="/Volumes/LaCie/InstallOS.dmg"
WORK="/Volumes/LaCie/Sierra_Work"

echo "=== Sierra Extract + Launch Attempt ==="
date

if [ ! -f "$SRC" ]; then
    echo "Missing:"
    echo "$SRC"
    exit 1
fi

mkdir -p "$WORK"

echo
echo "Mounting DMG..."
hdiutil attach "$SRC"

echo
echo "Finding InstallOS.pkg..."
PKG=$(find /Volumes -name "InstallOS.pkg" 2>/dev/null | head -1)

if [ -z "$PKG" ]; then
    echo "InstallOS.pkg not found"
    exit 1
fi

echo "Found:"
echo "$PKG"

echo
echo "Expanding package..."
rm -rf "$WORK/pkg"
mkdir -p "$WORK/pkg"

pkgutil --expand "$PKG" "$WORK/pkg"

echo
echo "Searching for installer app..."

APP=$(find "$WORK/pkg" -name "*.app" 2>/dev/null | head -1)

if [ -z "$APP" ]; then
    echo "No .app found."
    echo "Searching all installer files:"
    find "$WORK/pkg" -name "*Install*" 2>/dev/null
    exit 1
fi

echo
echo "Found app:"
echo "$APP"

echo
echo "Attempting launch..."

EXEC="$APP/Contents/MacOS"

if [ -d "$EXEC" ]; then
    ls "$EXEC"

    BIN=$(find "$EXEC" -type f -perm -111 | head -1)

    if [ -n "$BIN" ]; then
        echo "Launching:"
        echo "$BIN"
        "$BIN" &
    else
        echo "No executable found."
    fi
else
    echo "No Contents/MacOS directory."
fi

echo
echo "=== Finished ===" 