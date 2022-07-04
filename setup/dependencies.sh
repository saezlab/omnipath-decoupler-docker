#!/bin/bash

DEBIAN_FRONTEND=noninteractive

# For building C-Python bindings
apt-get -y install libcurl4-openssl-dev libssl-dev python3 python3-dev python3-pip
# Extras for pypath
apt-get -y install python3-igraph libcairo2-dev pkg-config


# Python tools dependencies (unstated dependencies?)
pip3 install --user --no-warn-script-location bioservices numpy scipy statsmodels pycurl pycairo
