# Largely based on:
# https://phusion.github.io/baseimage-docker/
# https://github.com/saezlab/saezverse
# https://github.com/rocker-org/rocker-versioned2

FROM phusion/baseimage:22.04

LABEL org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/saezlab/omnipath-decoupler-docker" \
      org.opencontainers.image.vendor="OmniPath" \
      org.opencontainers.image.authors="Denes Turei <turei.denes@gmail.com>"

CMD ["/sbin/my_init"]

ENV PASSWORD=szeged2022
ENV TZ=Europe/Berlin
ENV LANG=en_GB.UTF-8
ENV DEFAULT_USER=omnipath
ENV R_VERSION=4.2.1
ENV R_HOME=/usr/local/lib/R

WORKDIR setup

RUN default_user.sh
RUN apt -y update
RUN apt -y upgrade
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

RUN chmod +x *.sh
RUN bash dependencies.sh

RUN bash installpy.sh

RUN bash install_r.sh

RUN Rscript --vanilla install.R

WORKDIR /home/omnipath/
RUN rm -rf .cache/pip
RUN rm -rf setup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
