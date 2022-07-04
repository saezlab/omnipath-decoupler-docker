#!/bin/bash
set -e

LANGUAGE=${LANGUAGE:-en_GB.UTF-8}
LANG=${LANG:-en_GB.UTF-8}
LC_ALL=${LC_ALL:-en_GB.UTF-8}

sed -i 's/^/#/' /etc/locale.gen
echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "hu_HU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen --purge en_GB.utf8 en_US.utf8 hu_HU.utf8

/usr/sbin/update-locale LANG=${LANG}
