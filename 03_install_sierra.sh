#!/bin/bash

echo "=== SIERRA INSTALL ==="

TARGET="Macintosh HD"
ESD="/Volumes/OS X Install ESD"

if [ ! -d "$ESD" ]; then
    echo "Installer media missing"
    exit 1
fi


echo
echo "Installer:"
echo "$ESD"

echo
echo "Target:"
diskutil info "$TARGET" | grep -E "Device Identifier|File System|Disk Size"


echo
echo "================================="
echo "THIS WILL ERASE:"
echo "$TARGET"
echo "================================="

printf "Type INSTALL-SIERRA to continue: "
read CONFIRM


if [ "$CONFIRM" != "INSTALL-SIERRA" ]; then
    echo "Cancelled."
    exit 0
fi


echo
echo "Confirmed."

echo
echo "At this stage:"
echo "Installer deployment command goes here."
echo "Stopped intentionally until disk identifier is confirmed."

diskutil list