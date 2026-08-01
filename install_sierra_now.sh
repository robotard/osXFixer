#!/bin/bash

echo "=== Sierra Installer Reality Check ==="
date

for V in "/Volumes/OS X Install ESD" "/Volumes/OS X Base System 1"
do
    echo
    echo "=== $V ==="

    if [ ! -d "$V" ]; then
        echo "NOT MOUNTED"
        continue
    fi

    echo "Mounted OK"

    echo
    echo "Installer-looking files:"
    find "$V" \
    \( -iname "*install*" -o -iname "*installer*" -o -iname "*osinstall*" \) \
    2>/dev/null

    echo
    echo "Large packages:"
    find "$V/Packages" -type f 2>/dev/null | grep -E "Essentials|OSInstall|BaseSystem"

done

echo
echo "=== Target ==="

diskutil info "/Volumes/Macintosh HD" | grep -E \
"Device Identifier|File System|OS Can Be Installed"

echo
echo "=== Finished ==="