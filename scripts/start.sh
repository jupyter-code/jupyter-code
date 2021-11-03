#!/bin/bash
CURRENT_RELEASE="1"
CODE_SETTINGS=~/.local/share/code-server/User/settings.json
if [ ! -f  ~/.local/fingerprint ] || [ $(cat ~/.local/fingerprint) -lt $CURRENT_RELEASE ]; then
    rm -rf ~/.local/share/code-server/CachedExtensionsVSIXs/
    rm -rf ~/.local/share/code-server/extensions/ms-python.python*/
    rm -rf ~/.local/share/code-server/extensions/ms-toolsai.jupyter*/
    curl -sfLO https://open-vsx.org/api/ms-toolsai/jupyter/2021.8.12/file/ms-toolsai.jupyter-2021.8.12.vsix
    curl -sfLO https://open-vsx.org/api/ms-python/python/2021.10.1365161279/file/ms-python.python-2021.10.1365161279.vsix
    code-server --install-extension ./ms-toolsai.jupyter-2021.8.12.vsix
    code-server --install-extension ./ms-python.python-2021.10.1365161279.vsix
    rm ms-toolsai.jupyter-2021.8.12.vsix 
    rm ms-python.python-2021.10.1365161279.vsix
    SETTINGS=".\"files.exclude\".\"**/.*/\" = true | .\"telemetry.enableTelemetry\" = false"
    if [ -e $CODE_SETTINGS ] 
    then
        cat $CODE_SETTINGS | jq "$SETTINGS" > $CODE_SETTINGS.tmp
        mv $CODE_SETTINGS.tmp $CODE_SETTINGS
    else
        jq -n "$SETTINGS" > $CODE_SETTINGS
    fi
fi

echo "$CURRENT_RELEASE" > ~/.local/fingerprint