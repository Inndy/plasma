#!/bin/sh

umask 002

REQ_EXEC="python3 pip3"
for EXEC in ${REQ_EXEC} 
do
    if [ ! -x "$(command -v $EXEC)" ]
    then
        echo "error: unable to find $EXEC, this is required to setup this project"
        exit
    fi
done

PYTHON_VERSION=`python3 -c 'import sys; print("%i" % (sys.hexversion<0x03040000))'`
if [ $PYTHON_VERSION -ne 0 ]; then
    echo "error: you need at least python 3.4 to run this project"    
    exit
fi

python3 -c 'import future' >/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
    echo "error: unable to find the package 'future' for python3 (required for pefile)"
    exit
fi

python3 -m virtualenv -h > /dev/null
if [ $? -ne 0 ]; then
    echo "error: you need virtualenv to setup this project, go to https://virtualenv.pypa.io/ for details"
    exit
fi

python3 -m virtualenv venv

source venv/bin/activate

CAPSTONE_VERSION=3.0.4

pip3 install capstone==$CAPSTONE_VERSION

# PE
# https://github.com/erocarrera/pefile
pip3 install pefile

# ELF
pip3 install pyelftools

# Msgpack
pip3 install msgpack-python
