#!/bin/bash

echo "=== SIERRA TARGET PREP ==="

TARGET="disk0"

echo
diskutil info /dev/disk0s2 | grep -E "Device Identifier|Volume Name|File System"

echo
echo "WARNING: THIS ERASES Macintosh HD"
echo "Target: /dev/disk0s2"

printf "Type ERASE SIERRA: "
read OK

if [ "$OK" != "ERASE SIERRA" ]; then
    echo "Cancelled"
    exit 0
fi

diskutil eraseVolume JHFS+ "Macintosh HD" /dev/disk0s2

echo
echo "Target prepared:"
diskutil list disk0