#!/bin/bash
#
# iMac Recovery diagnostic
#

LOG="/tmp/recovery-check.log"

echo "=== OS X Recovery Check ===" > "$LOG"
date >> "$LOG"

echo "" >> "$LOG"
echo "=== System Version ===" >> "$LOG"
sw_vers >> "$LOG" 2>&1

echo "" >> "$LOG"
echo "=== Hardware ===" >> "$LOG"
ioreg -l | grep -E '"model"|board-id' >> "$LOG" 2>&1

echo "" >> "$LOG"
echo "=== Disks ===" >> "$LOG"
diskutil list >> "$LOG" 2>&1

echo "" >> "$LOG"
echo "=== Volumes ===" >> "$LOG"
ls /Volumes >> "$LOG" 2>&1

echo "" >> "$LOG"
echo "=== Curl ===" >> "$LOG"
curl --version >> "$LOG" 2>&1

echo "" >> "$LOG"
echo "=== Apple Reachability ===" >> "$LOG"
ping -c 3 osrecovery.apple.com >> "$LOG" 2>&1

echo "" >> "$LOG"
echo "=== Installer Tools ===" >> "$LOG"

for x in \
/usr/bin/hdiutil \
/usr/sbin/asr \
/usr/sbin/bless \
/usr/sbin/installer \
/usr/sbin/diskutil
do
    if [ -e "$x" ]; then
        echo "FOUND $x" >> "$LOG"
    else
        echo "MISSING $x" >> "$LOG"
    fi
done

echo ""
echo "Finished. Log:"
echo "$LOG"