#!/bin/bash

# Build the documentation automatically when any file changes.
#
# Usage: ./autobuild.sh
#
# On Debian/Ubuntu, this requires:
#   sudo apt-get install inotify-tools

ROOT=`cd $(dirname $0) ; pwd`
cd $ROOT
make clean
make SPHINXOPTS=-q html
while (true); do
    echo
    echo ======================================================
    echo  Waiting for changes in documentation source files...
    echo ======================================================
    echo

    inotifywait \
        -q -r -e modify,move,create,delete \
        --exclude '\.?#.*|.*_flymake.*|.*\.doctree' \
        . ../lusmu

    make SPHINXOPTS=-q html

done
