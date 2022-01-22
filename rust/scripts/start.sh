#!/bin/bash
set -e

CURRENT_RELEASE="1"
CODE_SETTINGS=~/.local/share/code-server/User/settings.json
INSTALLED_RELEASE="0"
if [ -f  ~/.local/fingerprint ] ; then
    INSTALLED_RELEASE=$(cat ~/.local/fingerprint)
fi

if [ $INSTALLED_RELEASE -lt 1 ]; then
    mkdir -p /home/jovyan/.local/share/code-server/User/globalStorage/haskell.haskell
    SETTINGS=".\"files.exclude\".\"**/.*/\" = true | .\"telemetry.enableTelemetry\" = false"
    if [ -e $CODE_SETTINGS ] 
    then
        cat $CODE_SETTINGS | jq "$SETTINGS" > $CODE_SETTINGS.tmp
        mv $CODE_SETTINGS.tmp $CODE_SETTINGS
    else
        mkdir -p ~/.local/share/code-server/User
        jq -n "$SETTINGS" > $CODE_SETTINGS
    fi
fi

echo "$CURRENT_RELEASE" > ~/.local/fingerprint