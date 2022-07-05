#!/bin/bash

# Saez Python tools in PyPI
pip3 install --no-warn-script-location omnipath
pip3 install --no-warn-script-location git+https://github.com/saezlab/pypath.git@nobiocypher
pip3 install --no-warn-script-location git+https://github.com/saezlab/decoupler-py.git
# Scanpy
pip3 install --no-warn-script-location packaging 'scanpy[leiden]'
