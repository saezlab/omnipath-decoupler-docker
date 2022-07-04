#!/bin/bash
set -e

# adapted from the Rocker Project
# https://github.com/rocker-org/rocker-versioned2

UBUNTU_VERSION=${UBUNTU_VERSION:-jammy}
CRAN_LINUX_VERSION=${CRAN_LINUX_VERSION:-cran40}
LANG=${LANG:-en_GB.UTF-8}
LC_ALL=${LC_ALL:-en_GB.UTF-8}
DEBIAN_FRONTEND=noninteractive

# Set up and install R
R_HOME=${R_HOME:-/usr/lib/R}

apt-get update

apt-get -y install --no-install-recommends \
      ca-certificates \
      less \
      libopenblas-base \
      locales \
      vim-tiny \
      wget \
      dirmngr \
      gpg \
      gpg-agent

echo "deb http://cloud.r-project.org/bin/linux/ubuntu ${UBUNTU_VERSION}-${CRAN_LINUX_VERSION}/" >> /etc/apt/sources.list

gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | apt-key add -

# Wildcard * at end of version will grab (latest) patch of requested version
apt-get update && apt-get -y install --no-install-recommends r-base-dev=${R_VERSION}*

rm -rf /var/lib/apt/lists/*

echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_GB.utf8
/usr/sbin/update-locale LANG=${LANG}

script -e "install.packages(c('littler', 'docopt'))"

## By default R_LIBS_SITE is unset, and defaults to this, so this is where `littler` will be.
## We set it here for symlinks, but don't make the env var persist (since it's already the default)
R_LIBS_SITE=/usr/local/lib/R/site-library
ln -s ${R_LIBS_SITE}/littler/examples/install.r /usr/local/bin/install.r
ln -s ${R_LIBS_SITE}/littler/examples/install2.r /usr/local/bin/install2.r
ln -s ${R_LIBS_SITE}/littler/examples/installGithub.r /usr/local/bin/installGithub.r
ln -s ${R_LIBS_SITE}/littler/bin/r /usr/local/bin/r