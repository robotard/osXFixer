#!/bin/bash

echo "=== SIERRA INSTALL ==="
date

ESD="/Volumes/OS X Install ESD"
TARGET="/Volumes/Macintosh HD"

if [ ! -d "$ESD" ]; then
    echo "ERROR: OS X Install ESD not mounted"
    exit 1
fi

if [ ! -d "$TARGET" ]; then
    echo "ERROR: Macintosh HD not mounted"
    exit 1
fi

BASE="$ESD/BaseSystem.dmg"

if [ ! -f "$BASE" ]; then
    echo "ERROR: BaseSystem.dmg missing"
    exit 1
fi

echo
echo "=== VERIFY ==="

ls -lh "$BASE"
ls -lh "$ESD/Packages/Essentials.pkg"

echo
echo "=== Mounting BaseSystem ==="

hdiutil attach "$BASE" -nobrowse

sleep 3

SOURCE=$(ls /Volumes | grep "OS X Base System" | tail -1)

if [ -z "$SOURCE" ]; then
    echo "ERROR: BaseSystem did not mount"
    exit 1
fi

echo "Using:"
echo "/Volumes/$SOURCE"


echo
echo "=== Copying Packages link ==="

rm -rf "/Volumes/$SOURCE/System/Installation/Packages"

ln -s "$ESD/Packages" \
"/Volumes/$SOURCE/System/Installation/Packages"


echo
echo "=== Blessing installer ==="

bless \
--folder "/Volumes/$SOURCE/System/Library/CoreServices" \
--bootefi


echo
echo "=== Setting startup ==="

bless \
--folder "/Volumes/$SOURCE/System/Library/CoreServices" \
--setBoot


echo
echo "=== Rebooting into installer ==="

echo "Press Ctrl+C within 10 seconds to cancel"

sleep 10

reboot