#!/bin/bash
set -e

DEFAULT_USER=${1:-${DEFAULT_USER:-"omnipath"}}

if id -u "${DEFAULT_USER}" >/dev/null 2>&1; then
    echo "User ${DEFAULT_USER} already exists"
else
    useradd -s /bin/bash -m "$DEFAULT_USER"
    echo "${DEFAULT_USER}:${DEFAULT_USER}" | chpasswd
fi
