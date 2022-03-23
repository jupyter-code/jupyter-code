#!/bin/bash
set -e

source /opt/scripts/helper.sh

CURRENT_RELEASE="1"
CODE_SETTINGS=~/.local/share/code-server/User/settings.json
INSTALLED_RELEASE="0"
if [ -f  ~/.local/fingerprint ] ; then
    INSTALLED_RELEASE=$(cat ~/.local/fingerprint)
fi

if [ $INSTALLED_RELEASE -lt 1 ]; then    
    update_settings
fi

echo "$CURRENT_RELEASE" > ~/.local/fingerprint