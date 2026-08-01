#!/bin/bash
#
# Sierra Installer Payload Check
# No writes, no erase, read-only checks only
#

echo "=== Sierra Installer Check ==="
date

echo
echo "=== Volumes ==="
ls /Volumes

echo
echo "=== OS X Install ESD ==="

ESD="/Volumes/OS X Install ESD"

if [ -d "$ESD" ]; then
    echo "Found: $ESD"

    echo
    echo "--- Top level ---"
    ls -lh "$ESD"

    echo
    echo "--- Packages ---"
    if [ -d "$ESD/Packages" ]; then
        echo "Packages found:"
        ls -lh "$ESD/Packages" | head -40
    else
        echo "No Packages folder found"
    fi

    echo
    echo "--- Key files ---"

    for f in \
    "Packages/OSInstall.mpkg" \
    "Packages/OSInstall.pkg" \
    "BaseSystem.dmg"
    do
        if [ -e "$ESD/$f" ]; then
            echo "FOUND: $f"
        else
            echo "MISSING: $f"
        fi
    done

else
    echo "OS X Install ESD not mounted"
fi

echo
echo "=== Base System 1 ==="

BASE="/Volumes/OS X Base System 1"

if [ -d "$BASE" ]; then
    echo "Found: $BASE"
    ls -lh "$BASE" | head -30
else
    echo "Base System 1 not mounted"
fi

echo
echo "=== Disk Layout ==="
diskutil list

echo
echo "=== Complete ==="