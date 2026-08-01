#!/bin/bash

echo "=== Sierra Installer Locate ==="

BASE="/Volumes/OS X Base System 1"
ESD="/Volumes/OS X Install ESD"

echo
echo "Searching for installer bundles..."

find "$BASE" \
\( -name "*.app" -o -name "*Installer*" -o -name "*Install*" \) \
2>/dev/null | grep -E "Install|Installer"

echo
echo "Searching ESD..."

find "$ESD" \
\( -name "*.app" -o -name "*Installer*" -o -name "*Install*" \) \
2>/dev/null | grep -E "Install|Installer"

echo
echo "Done"