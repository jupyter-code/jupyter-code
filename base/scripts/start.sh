#!/bin/bash
set -e

source /opt/scripts/helper.sh

uninstall_jupyter (){
    rm -rf ~/.local/share/code-server/CachedExtensionsVSIXs/
    rm -rf ~/.local/share/code-server/extensions/ms-python.python*/
    rm -rf ~/.local/share/code-server/extensions/ms-toolsai.jupyter*/
}


CURRENT_RELEASE="4"
CODE_SETTINGS=~/.local/share/code-server/User/settings.json
INSTALLED_RELEASE="0"
if [ -f  ~/.local/fingerprint ] ; then
    INSTALLED_RELEASE=$(cat ~/.local/fingerprint)
fi

if [ $INSTALLED_RELEASE -lt 1 ]; then
    update_settings
fi

if [ $INSTALLED_RELEASE -lt 2 ]; then
    curl -sfLO https://github.com/hm-riscv/vscode-riscv-venus/releases/download/v1.6.0/hm.riscv-venus-1.7.0.vsix
    code-server --install-extension ./hm.riscv-venus-1.7.0.vsix
    code-server --install-extension /opt/extensions/zhwu95.riscv-0.0.8.vsix
    rm hm.riscv-venus-1.7.0.vsix
fi

# Check that the installed release is less than 2 and not 0
if [ $INSTALLED_RELEASE -lt 3 ] && [ $INSTALLED_RELEASE -ne 0 ]; then
    uninstall_jupyter
fi

if [ $INSTALLED_RELEASE -lt 4 ] && [ $INSTALLED_RELEASE -ne 0 ]; then
    curl -sfLO https://github.com/hm-riscv/vscode-riscv-venus/releases/download/v1.6.0/hm.riscv-venus-1.7.0.vsix
    code-server --install-extension ./hm.riscv-venus-1.7.0.vsix    
    rm hm.riscv-venus-1.7.0.vsix
    update_settings
fi

echo "$CURRENT_RELEASE" > ~/.local/fingerprint