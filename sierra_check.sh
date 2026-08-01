#!/bin/bash

echo "=== SIERRA INSTALLER STATUS ==="

echo
echo "[Volumes]"
ls /Volumes

ESD="/Volumes/OS X Install ESD"
BASE="/Volumes/OS X Base System 1"

echo
echo "[ESD]"
if [ -d "$ESD" ]; then
    echo "OK: OS X Install ESD mounted"

    [ -d "$ESD/Packages" ] && echo "OK: Packages folder found"
    [ -f "$ESD/Packages/OSInstall.mpkg" ] && echo "OK: OSInstall.mpkg found"
    [ -f "$ESD/BaseSystem.dmg" ] && echo "OK: BaseSystem.dmg found"

    echo
    echo "Largest packages:"
    ls -lh "$ESD/Packages" 2>/dev/null | grep pkg | tail -10

else
    echo "FAIL: OS X Install ESD missing"
fi

echo
echo "[Base System]"
if [ -d "$BASE" ]; then
    echo "OK: Sierra Base System mounted"

    [ -d "$BASE/System" ] && echo "OK: System folder"
    [ -d "$BASE/bin" ] && echo "OK: binaries"

else
    echo "FAIL: Sierra Base System missing"
fi

echo
echo "[Target Disk]"
diskutil list | grep -E "Macintosh HD|Recovery HD|EFI"

echo
echo "=== END ==="