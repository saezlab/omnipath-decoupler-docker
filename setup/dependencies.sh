#!/bin/bash

# For building C-Python bindings
apt -y install libcurl4-openssl-dev python3-dev
# Extras for pypath
apt -y install python3-igraph libcairo2-dev pkg-config


# Python tools dependencies (unstated dependencies?)
pip3 install --user --no-warn-script-location bioservices numpy scipy statsmodels pycurl pycairo
