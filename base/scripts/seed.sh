#!/bin/bash
set -e
shopt -s dotglob
if [ -f $1/.local/fingerprint ] ; then
    exit 0
fi

cp -nR ~/* $1
