#!/bin/bash

echo "================================"
echo " SIERRA INSTALL CHECK "
echo "================================"
date

ESD="/Volumes/OS X Install ESD"
TARGET="/Volumes/Macintosh HD"

echo
echo "=== Volumes ==="
ls /Volumes

echo
echo "=== Checking installer ==="

for x in \
"$ESD/BaseSystem.dmg" \
"$ESD/Packages" \
"$ESD/Packages/OSInstall.mpkg" \
"$ESD/Packages/Essentials.pkg"
do
    if [ -e "$x" ]; then
        echo "FOUND: $x"
    else
        echo "MISSING: $x"
    fi
done

echo
echo "=== Target disk ==="

diskutil info "$TARGET" | grep -E \
"Device Identifier|File System|Disk Size|OS Can Be Installed"

echo
echo "================================"
echo "WARNING"
echo "ERASE Macintosh HD"
echo "================================"

printf "Type YES ERASE SIERRA: "
read CONFIRM

if [ "$CONFIRM" != "YES ERASE SIERRA" ]; then
    echo "Cancelled"
    exit 0
fi

echo
echo "=== Formatting Macintosh HD ==="

diskutil eraseVolume \
JHFS+ \
"Macintosh HD" \
/dev/disk0s2


echo
echo "=== Looking for Installer.app ==="

find "/Volumes/OS X Base System 1" \
-name "*.app" 2>/dev/null


echo
echo "=== Finished discovery ==="