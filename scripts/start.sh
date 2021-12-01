#!/bin/bash
CURRENT_RELEASE="2"
CODE_SETTINGS=~/.local/share/code-server/User/settings.json
INSTALLED_RELEASE="0"
if [ -f  ~/.local/fingerprint ] ; then
    INSTALLED_RELEASE=$(cat ~/.local/fingerprint)
fi

if [ $INSTALLED_RELEASE -lt 1 ]; then
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

if [ $INSTALLED_RELEASE -lt 2 ]; then
    curl -sfLO https://github.com/hm-riscv/vscode-riscv-venus/releases/download/v1.6.0/hm.riscv-venus-1.6.0.vsix
    code-server --install-extension ./hm.riscv-venus-1.6.0.vsix
    code-server --install-extension /opt/extensions/zhwu95.riscv-0.0.8.vsix
    rm hm.riscv-venus-1.6.0.vsix
fi

echo "$CURRENT_RELEASE" > ~/.local/fingerprint