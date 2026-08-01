#!/bin/bash

echo "=== REBUILD SIERRA ENVIRONMENT ==="

DMG="/Volumes/LaCie/InstallOS.dmg"
WORK="/Volumes/LaCie/Sierra_Work"

if [ ! -f "$DMG" ]; then
    echo "Missing:"
    echo "$DMG"
    exit 1
fi


echo
echo "Mounting InstallOS.dmg..."

hdiutil attach "$DMG"


echo
echo "Finding InstallOS.pkg..."

PKG=$(find /Volumes -name "InstallOS.pkg" 2>/dev/null | head -1)

if [ -z "$PKG" ]; then
    echo "InstallOS.pkg not found"
    exit 1
fi

echo "$PKG"


echo
echo "Preparing extraction folder..."

rm -rf "$WORK/pkg"

# IMPORTANT:
# Do NOT mkdir pkg here.
# pkgutil creates it.

pkgutil --expand "$PKG" "$WORK/pkg"


echo
echo "Finding InstallESD..."

find "$WORK/pkg" -name "InstallESD.dmg" 2>/dev/null


echo
echo "Mounting InstallESD..."

ESD=$(find "$WORK/pkg" -name "InstallESD.dmg" 2>/dev/null | head -1)

if [ -n "$ESD" ]; then
    hdiutil attach "$ESD"
else
    echo "InstallESD not found"
fi


echo
echo "=== ENVIRONMENT READY ==="