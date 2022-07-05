#!/bin/bash
set -e

DEFAULT_USER=${1:-${DEFAULT_USER:-"omnipath"}}
PASSWORD=${PASSWORD:-"szeged2022"}

if id -u "${DEFAULT_USER}" >/dev/null 2>&1; then
    echo "User ${DEFAULT_USER} already exists"
else
    useradd -m -s /bin/bash -u 1000 -p "$(openssl passwd -1 -stdin <<< $PASSWORD)" "$DEFAULT_USER"
    echo "${DEFAULT_USER}:${PASSWORD}" | chpasswd
fi
