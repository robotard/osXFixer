#!/bin/bash
#
# iMac12,2 Recovery Diagnostic / Prep Script
# Intended for macOS Internet Recovery Terminal
#
# Does NOT erase disks automatically.
# Does NOT install anything automatically.
#

set -e

LOG="/tmp/osx-recovery-check-$(date +%Y%m%d-%H%M%S).log"

exec > >(tee -a "$LOG") 2>&1

echo "=== OS X Recovery Check ==="
date

echo
echo "=== System ==="
sw_vers || true
uname -a

echo
echo "=== Hardware ==="
ioreg -l | grep -E '"model"|board-id' || true

echo
echo "=== Disk Layout ==="
diskutil list

echo
echo "=== Mounted Volumes ==="
mount

echo
echo "=== Network ==="
ping -c 3 apple.com || true
ping -c 3 osrecovery.apple.com || true
ping -c 3 swscan.apple.com || true

echo
echo "=== Curl ==="
curl --version

echo
echo "=== Apple HTTPS Tests ==="
curl -Iv --http1.1 https://osrecovery.apple.com || true
curl -Iv --http1.1 https://swscan.apple.com || true

echo
echo "=== Installer Tools ==="
for tool in \
/usr/sbin/diskutil \
/usr/bin/hdiutil \
/usr/sbin/asr \
/usr/sbin/bless \
/usr/sbin/installer
do
    if [ -x "$tool" ]; then
        echo "FOUND $tool"
    else
        echo "MISSING $tool"
    fi
done

echo
echo "=== Recovery Logs ==="
grep -i "recovery server\|product fetch\|osinstall" /var/log/install.log 2>/dev/null || true

echo
echo "Log saved:"
echo "$LOG"

echo "=== COMPLETE ==="