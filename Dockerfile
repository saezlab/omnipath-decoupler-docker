# Largely based on:
# https://phusion.github.io/baseimage-docker/
# https://github.com/saezlab/saezverse
# https://github.com/rocker-org/rocker-versioned2

FROM phusion/baseimage:jammy-1.0.0

LABEL org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/saezlab/omnipath-decoupler-docker" \
      org.opencontainers.image.vendor="OmniPath" \
      org.opencontainers.image.authors="Denes Turei <turei.denes@gmail.com>"

CMD ["/sbin/my_init"]

ENV PASSWORD=szeged2022
ENV TZ=Europe/Berlin
ENV LANGUAGE=en_GB.UTF-8
ENV LANG=en_GB.UTF-8
ENV LC_ALL=en_GB.UTF-8
ENV DEFAULT_USER=omnipath
ENV R_VERSION=4.2.1
ENV R_HOME=/usr/local/lib/R
ENV DEBIAN_FRONTEND=noninteractive

COPY setup omnipath_setup

WORKDIR omnipath_setup

RUN chmod +x *.sh

RUN bash locales.sh
RUN bash default_user.sh

RUN chown -R omnipath:omnipath .

RUN apt-get -y update
RUN apt-get -y upgrade
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

RUN bash dependencies.sh
RUN bash installpy.sh
RUN bash install_r.sh

RUN Rscript --vanilla install.R

RUN bash setup.sh

WORKDIR /home/omnipath/
RUN rm -rf .cache/pip
RUN rm -rf omnipath_setup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN unset DEBIAN_FRONTEND

RUN usermod -aG sudo omnipath

USER omnipath

RUN curl -o /home/omnipath/.pythonrc -L 'https://raw.githubusercontent.com/lonetwin/pythonrc/master/pythonrc.py'

RUN printf 'options(menu.graphics=FALSE)\nlibrary(colorout)\n' > /home/omnipath/.Rprofile
RUN printf '\n\nexport PYTHONSTARTUP=~/.pythonrc\n' >> /home/omnipath/.bashrc
RUN mkdir notebooks
