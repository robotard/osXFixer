#!/bin/bash

echo "=== SIERRA MEDIA CHECK ==="

ESD="/Volumes/OS X Install ESD"
BASE="/Volumes/OS X Base System 1"

echo

if [ -d "$ESD" ]; then
    echo "OK: OS X Install ESD"
else
    echo "FAIL: OS X Install ESD missing"
fi

if [ -d "$ESD/Packages" ]; then
    echo "OK: Packages"
else
    echo "FAIL: Packages missing"
fi

if [ -f "$ESD/Packages/OSInstall.mpkg" ]; then
    echo "OK: OSInstall.mpkg"
else
    echo "FAIL: OSInstall.mpkg missing"
fi

if [ -f "$ESD/BaseSystem.dmg" ]; then
    echo "OK: BaseSystem.dmg"
else
    echo "FAIL: BaseSystem.dmg missing"
fi

if [ -d "$BASE" ]; then
    echo "OK: Sierra Base System mounted"
else
    echo "INFO: Sierra Base System not mounted"
fi

echo

diskutil list | grep -E "EFI|Macintosh HD|Recovery HD"

echo
echo "=== COMPLETE ==="