#!/bin/bash

echo "=== SIERRA INSTALL AUTOMATION ==="
date

ESD="/Volumes/OS X Install ESD"
TARGET="/Volumes/Macintosh HD"

echo
echo "=== CHECKING VOLUMES ==="

for V in "$ESD" "$TARGET"
do
    if [ -d "$V" ]; then
        echo "OK $V"
    else
        echo "MISSING $V"
        exit 1
    fi
done

echo
echo "=== CHECKING PAYLOAD ==="

ESS="$ESD/Packages/Essentials.pkg"
OSMP="$ESD/Packages/OSInstall.mpkg"

if [ -f "$ESS" ]; then
    echo "OK Essentials.pkg"
else
    echo "Missing Essentials.pkg"
fi

if [ -f "$OSMP" ]; then
    echo "OK OSInstall.mpkg"
else
    echo "Missing OSInstall.mpkg"
fi


echo
echo "=== TARGET ==="

diskutil info "$TARGET" | grep -E \
"Device Identifier|File System|OS Can Be Installed"


echo
echo "=== SEARCHING INSTALLER COMPONENTS ==="

OSINSTALL=$(find "$ESD" -name "OSInstall.mpkg" 2>/dev/null | head -1)

if [ -n "$OSINSTALL" ]; then
    echo "Found:"
    echo "$OSINSTALL"
fi


INSTALLER=$(find "$ESD" "$TARGET" \
-name "Installer" \
-type f \
2>/dev/null | head -1)


if [ -n "$INSTALLER" ]; then
    echo
    echo "Launching installer:"
    echo "$INSTALLER"
    "$INSTALLER"
    exit $?
fi


echo
echo "=== USING OSINSTALL ENGINE ==="

if [ -f "$OSINSTALL" ]; then

    echo "Attempting OSInstall..."

    /usr/sbin/installer \
    -pkg "$OSINSTALL" \
    -target "$TARGET"

    exit $?

fi


echo
echo "FAILED:"
echo "Installer engine not found."
echo "Payload exists but installer workflow is missing."

exit 1